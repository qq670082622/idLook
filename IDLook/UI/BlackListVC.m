//
//  BlackListVC.m
//  IDLook
//
//  Created by HYH on 2018/8/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "BlackListVC.h"
#import "UserInfoVC.h"
#import "BlackListCell.h"

@interface BlackListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation BlackListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"黑名单"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    self.dataSource =[NSMutableArray new];
    [self getData];
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getData
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    if ([UserInfoManager getIsJavaService]) {
        NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID]};
        [AFWebAPI_JAVA getBlackListWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD dismiss];
                
                NSArray *array = [object  objectForKey:JSON_body];
                [self.dataSource removeAllObjects];
                for (int i=0; i<array.count; i++) {
                    [self.dataSource addObject:array[i]];
                }
                
                if (array.count==0) {
                    [SVProgressHUD showImage:nil status:@"暂无黑名单"];
                }
                
                [self.tableV reloadData];
            }
            else
            {
                AF_SHOW_JAVA_ERROR
            }
        }];
    }
    else{
    
    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID]};
    [AFWebAPI getBlackListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            
            NSArray *array = [object  objectForKey:JSON_data];
            [self.dataSource removeAllObjects];
            for (int i=0; i<array.count; i++) {
                [self.dataSource addObject:array[i]];
            }
            
            if (array.count==0) {
                [SVProgressHUD showImage:nil status:@"暂无黑名单"];
            }
            
            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    }
}

-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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
    }
    return _tableV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
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
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"BlackListCell";
    BlackListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[BlackListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell reloadUIWithDic:self.dataSource[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic =self.dataSource[indexPath.row];
    UserInfoM *info = [[UserInfoM alloc]init];
    if ([UserInfoManager getIsJavaService]) {
        info.UID=dic[@"userId"];
    }
    else
    {
        info.UID=dic[@"userid"];
    }
    
    UserInfoVC *userInfoVC=[[UserInfoVC alloc]init];
    UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
    uInfo.actorId =[info.UID integerValue];
    userInfoVC.info =uInfo;
    [self.navigationController pushViewController:userInfoVC animated:YES];
    
}

@end
