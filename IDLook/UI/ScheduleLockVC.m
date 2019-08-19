//
//  ScheduleLockVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockVC.h"
#import "ScheduleLockBottomV.h"
#import "ScheduleLockFootV.h"
#import "ScheduleLockVCM.h"
#import "ScheduleLockCellA.h"
#import "ScheduleLockCellB.h"
#import "ScheduleLockCellC.h"
#import "ScheduleLockCellD.h"
#import "ScheduleLockCellE.h"
#import "PublicWebVC.h"
#import "PayWaysVC.h"
#import "OrderProjectModel.h"
#import "ProjectDetailVC2.h"
#import "ServiceExplainPopV.h"

@interface ScheduleLockVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)ScheduleLockBottomV *bottomV;
@property(nonatomic,strong)ScheduleLockVCM *dsm;
@end

@implementation ScheduleLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"锁定档期"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self tableV];
    [self bottomV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(ScheduleLockVCM*)dsm
{
    if (!_dsm) {
        _dsm=[[ScheduleLockVCM alloc]init];
        BOOL serviceFeePaid = [self.projectInfo[@"serviceFeePaid"]boolValue];  //服务费是否已支付
        [_dsm refreshDataWithIsService:serviceFeePaid];
        _dsm.newDataNeedRefreshed = ^{
            
        };
    }
    return _dsm;
}

-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-60) style:UITableViewStyleGrouped];
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
        _tableV.tableFooterView=[self footV];
    }
    return _tableV;
}

-(ScheduleLockBottomV*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[ScheduleLockBottomV alloc]init];
        [self.view addSubview:_bottomV];
        BOOL serviceFeePaid = [self.projectInfo[@"serviceFeePaid"]boolValue];  //服务费是否已支付
        NSInteger serviceFee = [self.projectInfo[@"projectServiceFeePerDay"]integerValue];  //服务费
        NSInteger projectDays = [self.projectInfo[@"projectDays"]integerValue];  //项目天数
        NSInteger firstprice = self.info.firstPrice;
        NSInteger total = self.info.totalPrice;
        if (serviceFeePaid==NO) {
            firstprice =firstprice +serviceFee*projectDays;
            total=total+serviceFee*projectDays;
        }
        
        [_bottomV reloadWithFirstPrice:firstprice withTotal:total];
        
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-SafeAreaTabBarHeight_IphoneX);
            make.height.mas_equalTo(60);
        }];
        WeakSelf(self);
        _bottomV.placeOrderBlock  = ^{
            [weakself submitOrder];
        };
        _bottomV.praceDetailBlock = ^{

        };
        
    }
    return _bottomV;
}

-(UIView*)footV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
    ScheduleLockFootV *footV = [[ScheduleLockFootV alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
    [bg addSubview:footV];
    WeakSelf(self);
    footV.lookProtocolBlock = ^{  //查看档期预约金协议
        [weakself lookScheduleProtocol];
    };
    return bg;
}

//查看档期预约金协议
-(void)lookScheduleProtocol
{
    PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"档期预约金服务协议" url:@"http://www.idlook.com/public/appointment-money/index.html"];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dsm.ds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[(NSDictionary *)self.dsm.ds[indexPath.section] objectForKey:kScheduleLockVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    
    NSString *classStr = [(NSDictionary *)self.dsm.ds[sec] objectForKey:kScheduleLockVCMCellClass];
    ScheduleLockCellType type = [[(NSDictionary *)self.dsm.ds[sec] objectForKey:kScheduleLockVCMCellType] integerValue];
    
    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }

    if (type==ScheduleLockCellTypeProject) {
        ScheduleLockCellA *cell = (ScheduleLockCellA *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        [cell reloadUIWithProjectInfo:self.info.projectInfo];
        WeakSelf(self);
        cell.lookProjectDetialBlock = ^{
            NSDictionary *diaArg = @{
                                     @"projectId":self.info.projectInfo[@"projectId"],
                                     @"userId": @([[UserInfoManager getUserUID] integerValue])
                                     };
            [AFWebAPI_JAVA getProjectDetialWithArg:diaArg callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    NSDictionary *moDic = [object objectForKey:JSON_body];
                    ProjectModel2 *model2 = [ProjectModel2 yy_modelWithDictionary:moDic];
                    ProjectDetailVC2 *PDVC = [ProjectDetailVC2 new];
                    PDVC.hidesBottomBarWhenPushed=YES;
                    PDVC.model = model2;
                    PDVC.type = 3;
                    [weakself.navigationController pushViewController:PDVC animated:YES];
                }
            }];
        };
    }
    else if (type==ScheduleLockCellTypeService)
    {
        ScheduleLockCellB *cell = (ScheduleLockCellB *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        NSInteger serviceFee = [self.projectInfo[@"projectServiceFeePerDay"]integerValue];  //服务费
        NSInteger projectDays = [self.projectInfo[@"projectDays"]integerValue];  //项目天数
        [cell reloadUIWithPrice:serviceFee*projectDays];
        cell.lookServiceExpainBlock = ^{
            ServiceExplainPopV *popV = [[ServiceExplainPopV alloc]init];
            [popV showWithDay:projectDays withFreePrice:serviceFee];
        };
    }
    else if (type==ScheduleLockCellTypeArtistInfo)
    {
        ScheduleLockCellC *cell = (ScheduleLockCellC *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        [cell reloadUIWithProjectOrderInfo:self.info];
    }
    else if (type==ScheduleLockCellTypeGold)
    {
        ScheduleLockCellD *cell = (ScheduleLockCellD *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        [cell reloadUIWithPrice:self.info.firstPrice];
        WeakSelf(self);
        cell.lookProtocolBlock = ^{
            [weakself lookScheduleProtocol];
        };
    }
    else if (type==ScheduleLockCellTypeInsurance)
    {
        ScheduleLockCellE *cell = (ScheduleLockCellE *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        [cell reloadUI];

    }
    
    return obj;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sec = indexPath.section;
    ScheduleLockCellType type = [[(NSDictionary *)self.dsm.ds[sec] objectForKey:kScheduleLockVCMCellType] integerValue];
    if (type==ScheduleLockCellTypeInsurance)
    {
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"保单详情" url:[NSString stringWithFormat:@"http://www.idlook.com/public/protocol/html/index.html?num_id=%@",@""]];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

//提交订单
-(void)submitOrder
{
    [SVProgressHUD showWithStatus:@"正在锁档，请稍后。。。"];
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType]),
                             @"operate":@(301),
                             @"orderIdList":@[self.info.orderId]
                             };
    [AFWebAPI_JAVA getLockScheduleProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"锁档成功"];
            NSString *orderId = [object objectForKey:JSON_body][@"orderId"];
            PayWaysVC *payVC=[[PayWaysVC alloc]init];
            payVC.orderids=orderId;
            BOOL serviceFeePaid = [self.projectInfo[@"serviceFeePaid"]boolValue];  //服务费是否已支付
            NSInteger serviceFee = [self.projectInfo[@"projectServiceFeePerDay"]integerValue];  //服务费
            NSInteger projectDays = [self.projectInfo[@"projectDays"]integerValue];  //项目天数
            NSInteger firstprice = self.info.firstPrice;
            if (serviceFeePaid==NO) {
                firstprice =firstprice +serviceFee*projectDays;
            }
            payVC.totalPrice=firstprice;
            WeakSelf(self);
            payVC.refreshData = ^{
                NSDictionary *dicArg = @{@"operate":@(302),
                                         @"orderIdList":@[orderId],
                                         @"userId":[UserInfoManager getUserUID],
                                         @"userType":@([UserInfoManager getUserType])
                                         };
                [AFWebAPI_JAVA getLockScheduleProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
                    if (success) {
                        [weakself onGoback];
                    }
                    else
                    {
                        AF_SHOW_JAVA_ERROR
                    }
                }];
            };
            [self.navigationController pushViewController:payVC animated:YES];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

@end
