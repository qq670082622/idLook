//
//  AssetsMainVC.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AssetsMainVC.h"
#import "AssetsTopV.h"
#import "AssetsMainHeadV.h"
#import "AssetsSelectV.h"
#import "AssetsMainCell.h"
#import "AssetsSelectPopV.h"
#import "ForwardVC.h"
#import "AssetsSelectPopV.h"
#import "AssetModel.h"

@interface AssetsMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property (nonatomic,strong)AssetsTopV *topV;
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,assign)CGFloat totalMoney;
@property(nonatomic,assign)NSInteger assetsType;  //资产类型
@end

@implementation AssetsMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"资产管理"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];
    self.assetsType=0;
    
    [self getData];
    [self tableV];
    
    
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(self.tableV.contentOffset.y / SafeAreaTopHeight)>0.99?0.99:(self.tableV.contentOffset.y /SafeAreaTopHeight)]] forBarMetrics:UIBarMetricsDefault];
//    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

}

-(void)getData
{
    NSDictionary *dic =@{@"userId":[UserInfoManager getUserUID],
                         @"orderType":@(0)};
    
    [AFWebAPI_JAVA getCapitalDetailsWithArg:dic callBack:^(BOOL success, id object) {
        if (success) {
            NSDictionary *dic= [object objectForKey:JSON_body];
            NSArray *array = (NSArray*)safeObjectForKey(dic, @"transactionDetailsList");
            [self.dataSource removeAllObjects];
            for (int i=0; i<array.count; i++) {
                AssetModel *model= [AssetModel yy_modelWithDictionary:array[i]];
                [self.dataSource addObject:model];
            }
            NSString *total = [NSString stringWithFormat:@"%@",dic[@"total"]];
            [self.topV refreshTotalAssets:total];
            self.totalMoney = [total floatValue];
            
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeAssets];
            }
            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeNetwork];
            }
        }
    }];
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
        _tableV.tableHeaderView=[self tableHeadV];

    }
    return _tableV;
}


-(UIView*)tableHeadV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 190)];
    bg.backgroundColor=[UIColor whiteColor];
    AssetsTopV *headIcon = [[AssetsTopV alloc]initWithFrame:CGRectMake(0,30,UI_SCREEN_WIDTH,190)];
    [bg addSubview:headIcon];
    WeakSelf(self);
    headIcon.forwardBlock = ^{   //提现
        ForwardVC *forward=[[ForwardVC alloc]init];
        forward.totalMoney=self.totalMoney;
        forward.refreshUI = ^{
            [weakself getData];
        };
        [weakself.navigationController pushViewController:forward animated:YES];
    };
    self.topV=headIcon;
    return bg;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"AssetsMainCell";
    AssetsMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[AssetsMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell reloadUIWithModel:self.dataSource[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
