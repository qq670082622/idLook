
//
//  SystemMsgVC.m
//  IDLook
//
//  Created by HYH on 2018/6/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SystemMsgVC.h"
#import "SystemMsgCell.h"
#import "SysMsgDB.h"

@interface SystemMsgVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation SystemMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"系统消息"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];
    
    [SysMsgDB shareInstance];
    
    [self getData];
    
    [self tableV];
}

-(void)onGoback
{
    self.refreshUIBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    NSDictionary *dicArg=@{@"userid":[UserInfoManager getUserUID]};
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [AFWebAPI getCustomMsgWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array = [object objectForKey:JSON_data];
            [self.dataSource addObjectsFromArray:array];
            [self.dataSource addObjectsFromArray: [[SysMsgDB shareInstance]loadSystemMsgWithPeerID:[UserInfoManager getUserUID]]];
            [self.tableV reloadData];
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeCustomMsg];
            }
            for (int i =0; i<array.count; i++) {
                [[SysMsgDB shareInstance]insertSysMsgList:array[i]];
            }
            [UserInfoManager setUnreadCount:0];        
        }
        else
        {
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeNetwork];
            }
            AF_SHOW_RESULT_ERROR
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
    }
    return _tableV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42.f;
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
    return 91;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"SystemMsgCell";
    SystemMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[SystemMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    [cell reloadUIWithDic:self.dataSource[indexPath.section]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"UITableViewHeaderFooterView";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    if(!headerView)
    {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifer];
        headerView.backgroundView=[[UIImageView alloc]initWithImage:nil];
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12.0];
        label.tag = 0x26;
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(headerView.mas_centerX);
            make.bottom.mas_equalTo(headerView).offset(-11);
        }];
    }
    NSString *str = [self.dataSource[section] objectForKey:@"datetime"];
    UILabel *label = (UILabel *)[headerView viewWithTag:0x26];
    label.text = str;
    return headerView;
}

@end
