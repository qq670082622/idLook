//
//  MsgMainVC.m
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MsgMainVC.h"
#import "MsgMainCellA.h"
#import "MsgMainHeadV.h"
#import "OrderDetialVC.h"
#import "OrderProjectModel.h"
#import "ProjectOrderDetialVC.h"

@interface MsgMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation MsgMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setWhiteNavgationItemTitle:@"消息"]];

    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];

    [self getData];
    [self tableV];
    
    [self setBG];
    
}

-(void)getData
{
    [self.tableV startLoading];

    NSDictionary *dicArg=@{@"userid":[UserInfoManager getUserUID]};
    [AFWebAPI getOrderNewsList:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            
            [self.dataSource removeAllObjects];
            
            NSArray *array = [object objectForKey:JSON_data];
            for (int i=0; i<array.count; i++) {
                NSDictionary *dic = array[i];
                OrderProjectModel *model = [[OrderProjectModel alloc]initWithDic:dic];
                [self.dataSource addObject:model];
            }
            _tableV.animatedStyle = TABTableViewAnimationEnd;
            [self.tableV reloadData];
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeOrderMsg];
            }
        }
        else
        {
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeNetwork];
            }
            AF_SHOW_RESULT_ERROR
        }
        [self.tableV headerEndRefreshing];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)setBG
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.backgroundColor=[UIColor clearColor];
    imageV.contentMode=UIViewContentModeScaleAspectFill;
    imageV.image=[UIImage imageNamed:@"message_top_bg"];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
    }];
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,SafeAreaTopHeight,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
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
        _tableV.backgroundColor=[UIColor clearColor];
        [_tableV addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
        _tableV.animatedStyle = TABTableViewAnimationStart;
//        [_tableV addFooterWithTarget:self action:@selector(pullUpToRefresh:)];
    }
    return _tableV;
}

-(void)pullDownToRefresh:(id)sender
{
    [self getData];
}

-(void)pullUpToRefresh:(id)sender
{
    [self.tableV footerEndRefreshing];
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==self.dataSource.count-1) {
        return 20.0f;
    }
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 60.0;
    }
    return 46.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"MsgMainCellA";
    MsgMainCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[MsgMainCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    [cell initUI];
    if (tableView.animatedStyle != TABTableViewAnimationStart) {
        OrderProjectModel *model = self.dataSource[indexPath.section];
        [cell reloadUIWithModel:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderProjectModel *projectModel = self.dataSource[indexPath.section];
//    OrderDetialVC *detialVc = [[OrderDetialVC alloc]init];
//    detialVc.hidesBottomBarWhenPushed=YES;
//    detialVc.orderModel = projectModel.orderModel;
//    detialVc.projectModel=projectModel;
//    [self.navigationController pushViewController:detialVc animated:YES];
    
    ProjectOrderDetialVC *detialVC = [[ProjectOrderDetialVC alloc]init];
    detialVC.hidesBottomBarWhenPushed=YES;
    detialVC.orderId=projectModel.orderModel.orderId;
    [self.navigationController pushViewController:detialVC animated:YES];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"MsgMainHeadV";
    MsgMainHeadV *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    if(!headerView)
    {
        headerView = [[MsgMainHeadV alloc] initWithReuseIdentifier:identifer];
        [headerView.backgroundView setBackgroundColor:[UIColor clearColor]];
    }
    OrderProjectModel *model = self.dataSource[section];
    [headerView reloadUIWithDate:model.orderModel.orderdate];
    return headerView;
}

@end
