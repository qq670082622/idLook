//
//  AuditionNoticeVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditionNoticeVC.h"
#import "ScheduleCellA.h"
#import "ScheduleCellB.h"
#import "AuditNoticeFooterView.h"
#import "AuditNoticeCellA.h"
#import "AuditNoticeCellB.h"
#import "BirthSelectV.h"

@interface AuditionNoticeVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation AuditionNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self getData];
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//获取数据
-(void)getData
{
    self.dataSource=[NSMutableArray new];
    if (self.noticeType==0) {  //试镜通知
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"试镜通知"]];

        self.dataSource= [[NSMutableArray alloc]initWithObjects:
                          @{@"title":@"试镜时间",@"content":(NSString*)safeObjectForKey(self.info.tryVideoInfo, @"auditionDate"),@"placeholder":@"请选择试镜时间",@"type":@(0)},
                          @{@"title":@"试镜地址",@"content":(NSString*)safeObjectForKey(self.info.tryVideoInfo, @"tryVideoAddress"),@"placeholder":@"请填写试镜地址",@"type":@(1)},
                          @{@"title":@"备注",@"content":(NSString*)safeObjectForKey(self.info.tryVideoInfo, @"remark"),@"placeholder":@"选填，如：对演员的着装要求等等…",@"type":@(2)},
                          nil];
    }
    else if(self.noticeType==1)//拍摄通知
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"拍摄通知"]];
        self.dataSource= [[NSMutableArray alloc]initWithObjects:
                          @{@"title":@"拍摄时间",@"content":(NSString*)safeObjectForKey(self.info.shotInfo, @"shotDate"),@"placeholder":@"请选择拍摄时间",@"type":@(0)},
                          @{@"title":@"拍摄地址",@"content":(NSString*)safeObjectForKey(self.info.shotInfo, @"shotAddress"),@"placeholder":@"请填写拍摄地址",@"type":@(1)},
                          @{@"title":@"备注",@"content":(NSString*)safeObjectForKey(self.info.shotInfo, @"remark"),@"placeholder":@"选填，如：对演员的着装要求等等…",@"type":@(2)},
                          nil];
    }
    else if (self.noticeType==2)  //定妆修改时间
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改时间地点"]];
        self.dataSource= [[NSMutableArray alloc]initWithObjects:
                          @{@"title":@"定妆时间",@"content":(NSString*)safeObjectForKey(self.info.makeupInfo, @"makeupDate"),@"placeholder":@"请选择定妆时间",@"type":@(0)},
                          @{@"title":@"定妆地址",@"content":(NSString*)safeObjectForKey(self.info.makeupInfo, @"makeupAddress"),@"placeholder":@"请填写定妆地址",@"type":@(1)},
                          nil];
    }
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
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
    return 190.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.f;
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
    if (indexPath.row==2) {
        return 200;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    WeakSelf(self);
    if (indexPath.row==0 || indexPath.row==1) {
        static NSString *identifer = @"AuditNoticeCellA";
        AuditNoticeCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuditNoticeCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithDic:dic];
        cell.textFieldChangeBlock = ^(NSString * _Nonnull text) {
            NSDictionary *newDic =  @{@"title":dic[@"title"],@"content":text,@"placeholder":dic[@"placeholder"],@"type":dic[@"type"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:newDic];
        };
        return cell;
    }
    else
    {
        static NSString *identifer = @"ScheduleCellA";
        AuditNoticeCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuditNoticeCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithDic:dic];
        cell.textViewChangeBlock = ^(NSString * _Nonnull text) {
            NSDictionary *newDic =  @{@"title":dic[@"title"],@"content":text,@"placeholder":dic[@"placeholder"],@"type":dic[@"type"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:newDic];
        };
        return cell;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString *identifer = @"AuditNoticeFooterView";
    AuditNoticeFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    if(!footerView)
    {
        footerView = [[AuditNoticeFooterView alloc] initWithReuseIdentifier:identifer];
        [footerView.backgroundView setBackgroundColor:[UIColor clearColor]];
    }
    WeakSelf(self);
    footerView.confrimBlock = ^{
        [weakself submitAction];
    };
    return footerView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    if (indexPath.row==0) {
        BirthSelectV *birthV = [[BirthSelectV alloc] init];
        WeakSelf(self);
        birthV.didSelectDate = ^(NSString *dateStr){
            NSDictionary *newDic =  @{@"title":dic[@"title"],@"content":dateStr,@"placeholder":dic[@"placeholder"],@"type":dic[@"type"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:newDic];
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        DateType type=DateTypeDay;
        if (self.noticeType==0) {
            type=DateTypeMinute;
        }
        [birthV showWithString:dic[@"content"] withType:type];
    }
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//确定
-(void)submitAction
{
    if (self.noticeType==0) {  //试镜通知
        NSDictionary *dic1 = self.dataSource[0];
        NSDictionary *dic2 = self.dataSource[1];
        NSDictionary *dic3 = self.dataSource[2];
        
        if (([dic1[@"content"]length]==0 && [dic2[@"content"]length]==0)&&[dic3[@"content"]length]==0) {
            [SVProgressHUD showErrorWithStatus:@"请填写通告信息"];
            return;
        }
        NSDictionary *dicArg = @{@"operate":@(213),
                                 @"orderId":self.info.orderId,
                                 @"userId":[UserInfoManager getUserUID],
                                 @"userType":@([UserInfoManager getUserType]),
                                 @"tryVideoNotifyInfo":@{@"tryVideoDate":dic1[@"content"],
                                                      @"tryVideoAddress":dic2[@"content"],
                                                      @"remark":dic3[@"content"]
                                                      }
                                 };
        [SVProgressHUD  showWithStatus:@"正在发送通告，请稍等。。。"];
        [AFWebAPI_JAVA getTryVideoProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"通告已发送"];
                [self onGoback];
            }
            else
            {
                AF_SHOW_JAVA_ERROR
            }
        }];
    }
    else if (self.noticeType==1) //拍摄通知
    {
        NSDictionary *dic1 = self.dataSource[0];
        NSDictionary *dic2 = self.dataSource[1];
        NSDictionary *dic3 = self.dataSource[2];
        
        if (([dic1[@"content"]length]==0 && [dic2[@"content"]length]==0)&&[dic3[@"content"]length]==0) {
            [SVProgressHUD showErrorWithStatus:@"请填写通告信息"];
            return;
        }
        NSDictionary *dicArg = @{@"operate":@(306),
                                 @"orderIdList":@[self.info.orderId],
                                 @"userId":[UserInfoManager getUserUID],
                                 @"userType":@([UserInfoManager getUserType]),
                                 @"shotNotifyInfo":@{@"shotDate":dic1[@"content"],
                                                      @"shotAddress":dic2[@"content"],
                                                      @"remark":dic3[@"content"]
                                                      }
                                 };
        [SVProgressHUD  showWithStatus:@"正在发送通告，请稍等。。。"];
        [AFWebAPI_JAVA getLockScheduleProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"通告已发送"];
                [self onGoback];
            }
            else
            {
                AF_SHOW_JAVA_ERROR
            }
        }];
    }
    else if (self.noticeType==2) //定妆修改时间地点
    {
        NSDictionary *dic1 = self.dataSource[0];
        NSDictionary *dic2 = self.dataSource[1];
        
        if ([dic1[@"content"]length]==0 && [dic2[@"content"]length]==0) {
            [SVProgressHUD showErrorWithStatus:@"请填写通告信息"];
            return;
        }
        NSInteger makeupType = [(NSNumber*)safeObjectForKey(self.info.makeupInfo, @"makeupType") integerValue];

        NSDictionary *dicArg = @{@"operate":@(405),
                                 @"orderId":self.info.orderId,
                                 @"userId":[UserInfoManager getUserUID],
                                 @"userType":@([UserInfoManager getUserType]),
                                 @"makeupOrderInfo":@{@"makeupType":@(makeupType),
                                                      @"makeupDate":dic1[@"content"],
                                                      @"makeupAddress":dic2[@"content"]
                                                      }
                                 };
        [SVProgressHUD  showWithStatus:@"正在修改，请稍后。"];
        [AFWebAPI_JAVA getMakeupProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self onGoback];
            }
            else
            {
                AF_SHOW_JAVA_ERROR
            }
        }];
    }
}

@end
