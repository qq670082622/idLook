//
//  MyOrderMainVC.m
//  IDLook
//
//  Created by HYH on 2018/5/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyOrderMainVC.h"
#import "MyOrderMainVC+Action.h"
#import "MyOrderTopV.h"
#import "MyOrderBottomV.h"
#import "MyOrderVCM.h"
#import "OrderDetialVC.h"
#import "RejectOrderPopV.h"
#import "AcceptOrderPopV.h"
#import "PayWaysVC.h"
#import "PriceModel.h"
#import "PlaceShotOrderVC.h"
#import "AuthPopV.h"
#import "AuthResourcerVC.h"
#import "MyAuthStateVC.h"
#import "MyOrderProjectCellA.h"
#import "MyOrderProjectCellB.h"
#import "OrderProjectModel.h"
#import "ProjectDetailVC.h"
#import "ProjectModel.h"
#import "ScriptPrivaryPopV.h"
#import "PublishGradeViewController.h"
#import "CheckGradeViewController.h"
#import "ApplyInvoicePopV.h"
#import "MyOrderListCellA.h"
#import "MyOrderListCellB.h"
#import "ProjectOrderDetialVC.h"
#import "VideoPlayer.h"
#import "ProjectModel2.h"
#import "ProjectDetailVC2.h"
#import "QNTestVC.h"
#import "DatePickPopV.h"
@interface MyOrderMainVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MyOrderProjectCellBDelegate,MyOrderProjectCellADelegate>
{
    VideoPlayer *_player;
}
@property (nonatomic,strong)MyOrderTopV *topV;
@property (nonatomic,strong)MyOrderBottomV *bottomV;
@property (nonatomic,strong)UIScrollView *scrollV;
@property (nonatomic,strong)MyOrderVCM *dsm;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign)NSInteger totalPrice;  //总价格
@property (nonatomic,strong)NSString *selectOrders;  //选中的订单
@end

@implementation MyOrderMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"我的订单"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self dsm];
    [self topV];
    [self scrollV];
    [self refreshBottomV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshData
{
    CustomTableV *tableV=[self correspondingTableViewWithTag:self.currIndex];
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeClear];
    [self.dsm refreshOrderListWithState:self.currIndex CallBack:^(BOOL success) {
        if (success) {
            [tableV hideNoDataScene];
            NSInteger count= [self.dsm.ds[self.currIndex] count];
            if (count==0) {
                [tableV showWithNoDataType:NoDataTypeOrder];
            }
        }
        else
        {
            [tableV hideNoDataScene];
            NSInteger count= [self.dsm.ds[self.currIndex] count];
            if (count==0) {
                [tableV showWithNoDataType:NoDataTypeNetwork];
            }
        }
        tableV.animatedStyle = TABTableViewAnimationEnd;
        [tableV reloadData];
        [tableV headerEndRefreshing];
        [SVProgressHUD dismiss];
        [self refreshBottomV];
    }];
}

-(MyOrderVCM*)dsm
{
    if (!_dsm) {
        _dsm=[[MyOrderVCM alloc]init];
        [self refreshData];
    }
    return _dsm;
}


-(MyOrderTopV*)topV
{
    if (!_topV) {
        _topV=[[MyOrderTopV alloc]initWithCUrePage:self.currIndex];
        [self.view addSubview:_topV];
        [_topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(40);
        }];
        WeakSelf(self);
        _topV.orderClickTypeBlock = ^(NSInteger type) {
            if (weakself.currIndex!=type) {
                [weakself.scrollV setContentOffset:CGPointMake(UI_SCREEN_WIDTH*type, 0) animated:NO];
                weakself.currIndex=type;
                [weakself refreshData];
                [weakself refreshBottomV];
            }
        };
    }
    return _topV;
}

-(MyOrderBottomV*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[MyOrderBottomV alloc]init];
        [self.view addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(48+SafeAreaTabBarHeight_IphoneX);
        }];
        _bottomV.hidden=YES;
        WeakSelf(self);
        _bottomV.OrderBottomPayBlock = ^{
            [weakself payAction];
        };
    }
    return _bottomV;
}

- (UIScrollView *)scrollV
{
    if(!_scrollV)
    {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight-40)];
        _scrollV.delegate = self;
        _scrollV.pagingEnabled=YES;
        _scrollV.scrollEnabled = NO;
        _scrollV.backgroundColor = [UIColor clearColor];
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollV];
        _scrollV.contentSize = CGSizeMake(UI_SCREEN_WIDTH*5, 0);
        
        for (int i =0; i<self.dsm.ds.count; i++) {
            
            CGFloat bottomHeight = 0;
//            if ([UserInfoManager getUserType]==UserTypePurchaser&&(i==1||i==2)) {
//                bottomHeight=SafeAreaTabBarHeight_IphoneX+48;
//            }
            
            CustomTableV *tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*i,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight-40-bottomHeight) style:UITableViewStyleGrouped];
            tableV.delegate = self;
            tableV.dataSource = self;
            tableV.tag=100+i;
            tableV.bounces=YES;
            tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
            tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [self.scrollV addSubview:tableV];
            tableV.estimatedRowHeight = 0;
            tableV.estimatedSectionHeaderHeight = 0;
            tableV.estimatedSectionFooterHeight = 0;
            tableV.backgroundColor=[UIColor clearColor];
            [tableV addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
        }
        _scrollV.contentOffset=CGPointMake(UI_SCREEN_WIDTH*self.currIndex, 0);
    }
    return _scrollV;
}

-(void)pullDownToRefresh:(id)sender
{
    [self refreshData];
}

//合并付款
-(void)payAction
{
    if (self.selectOrders.length==0) {  //未选中订单
        [SVProgressHUD showImage:nil status:@"请选择付款订单"];
        return;
    }
    
    //选中订单，但付款价格是0
    if (self.selectOrders.length>0 &&self.totalPrice<=0) {
        [SVProgressHUD showWithStatus:@"正在锁定档期" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dicArg = @{@"orderids":self.selectOrders};
        [AFWebAPI getZeroPayWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"档期已锁定"];
                [self refreshData];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
        return;
    }
    
    PayWaysVC *payVC=[[PayWaysVC alloc]init];
    payVC.orderids=self.selectOrders;
    payVC.totalPrice=self.totalPrice;
    WeakSelf(self);
    payVC.refreshData = ^{
        [weakself refreshData];
        [weakself getIntegral];
    };
    [self.navigationController pushViewController:payVC animated:YES];
}

//支付成功积分回掉
-(void)getIntegral
{
    NSArray *orderS = [self.selectOrders componentsSeparatedByString:@","];
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID],
                             @"orderIdList":orderS};
    [AFWebAPI_JAVA placeOrderIntegralBackWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//筛选底部价格
-(void)refreshBottomV
{
    return;
    if ([UserInfoManager getUserType]==UserTypePurchaser&&( self.currIndex==1||self.currIndex==2)) {
        self.bottomV.hidden=NO;
    }
    else
    {
        self.bottomV.hidden=YES;
    }
    
    //将其他数据选中状态清楚
    NSMutableArray *sec = self.dsm.ds[self.currIndex];
    if (sec.count==0) {
        self.bottomV.hidden=YES;
    }
    
    //选中的订单
    NSMutableArray *selectOrders = [NSMutableArray new];
    
    NSInteger total = 0;

    for (int i=0; i<sec.count; i++) {
        OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][i] objectForKey:kMyOrderVCMCellData];
        BOOL isPayService = NO; //是否需要加服务费
        for (int j=0; j<projectModel.orderlist.count; j++) {
            OrderModel *orderModel = projectModel.orderlist[j];
            if (orderModel.isChoose) {
                NSInteger price = 0;
                if (projectModel.type==1) {  //试镜
                    if ([orderModel.orderstate isEqualToString:@"new"]) {  //
                        price = [orderModel.price integerValue];
                    }
                }
                else if (projectModel.type==2)  //拍摄
                {
                    if (projectModel.ordeState==OrderStateTypeConfirm&&[orderModel.orderstate isEqualToString:@"acceptted"]) {  //首款  定妆费+档期预约金
                        price = [orderModel.ordertypeprice integerValue]+[orderModel.bailprice integerValue];
                    }
                    else if (projectModel.ordeState==OrderStateTypeGoing&&[orderModel.orderstate isEqualToString:@"paiedone"]) //尾款  总价-定妆费-档期预约金
                    {
                        price = [orderModel.totalprice integerValue]- [orderModel.ordertypeprice integerValue]-[orderModel.bailprice integerValue];
                    }
                }
                
                total=total+price;
                [selectOrders addObject:orderModel.orderId];
                if (projectModel.type==2 && projectModel.documentarystatus==0) {  //需要付服务费
                    isPayService = YES;
                }
            }
        }
        
        if (isPayService) {  //服务费
            total = total+projectModel.auditiondays*400;
        }
    }
    
    NSString *orderidS = [selectOrders componentsJoinedByString:@","];
    self.selectOrders = orderidS;
    self.totalPrice = total;
    [self.bottomV reloadUIWithPrice:total];
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dsm.ds[self.currIndex] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSString *classStr = [(NSDictionary *)self.dsm.ds[self.currIndex][sec] objectForKey:kMyOrderVCMCellClass];
    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }
    WeakSelf(self);
//    if ([classStr isEqualToString:@"MyOrderProjectCellA"]) {
//        OrderProjectModel *model = [(NSDictionary *)self.dsm.ds[self.currIndex][sec] objectForKey:kMyOrderVCMCellData];
//        MyOrderProjectCellA *cell = (MyOrderProjectCellA*)obj;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.indexPath=indexPath;
//        cell.delegate=self;
//        [cell reloadUIWithModel:model];
//    }
//    else if ([classStr isEqualToString:@"MyOrderProjectCellB"])
//    {
//        OrderProjectModel *model = [(NSDictionary *)self.dsm.ds[self.currIndex][sec] objectForKey:kMyOrderVCMCellData];
//        MyOrderProjectCellB *cell = (MyOrderProjectCellB*)obj;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.indexPath=indexPath;
//        cell.delegate=self;
//        [cell reloadUIWithModel:model];
//    }
//
//    else
        if ([classStr isEqualToString:@"MyOrderListCellA"]) {//买家
       
        NSDictionary *dic = [(NSDictionary *)self.dsm.ds[self.currIndex][sec] objectForKey:kMyOrderVCMCellData];
//            if (dic) {
//                <#statements#>
//            }
            MyOrderListCellA *cell = (MyOrderListCellA*)obj;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            [cell reloadUIWithDic:dic];
cell.buttonClickBlock = ^(NSInteger type, ProjectOrderInfoM * _Nonnull info) {
//            [weakself BottomButtonAction:type withProjectInfo:info];
        };
        cell.MyOrderlookOrderDetialBlock = ^(ProjectOrderInfoM * _Nonnull info) {  //查看订单详情
            ProjectOrderDetialVC *detialVC = [[ProjectOrderDetialVC alloc]init];
            detialVC.orderId=info.orderId;
            [weakself.navigationController pushViewController:detialVC animated:YES];
        };
        NSDictionary *projectInfo = dic[@"projectInfo"];
        cell.lookProjectdetialBlock = ^{
            NSDictionary *diaArg = @{
                                     @"projectId":projectInfo[@"projectId"],
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
    else if ([classStr isEqualToString:@"MyOrderListCellB"])//演员
    {
        MyOrderListCellB *cell = (MyOrderListCellB*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        NSDictionary *dic = [(NSDictionary *)self.dsm.ds[self.currIndex][sec] objectForKey:kMyOrderVCMCellData];
        [cell reloadUIWithDic:dic];
        cell.buttonClickBlock = ^(NSInteger type, ProjectOrderInfoM * _Nonnull info) {
            [weakself BottomButtonAction:type withProjectInfo:info];
        };
        cell.MyOrderlookOrderDetialBlock = ^(ProjectOrderInfoM * _Nonnull info) {  //查看订单详情
            ProjectOrderDetialVC *detialVC = [[ProjectOrderDetialVC alloc]init];
            detialVC.orderId=info.orderId;
            [weakself.navigationController pushViewController:detialVC animated:YES];
        };
        NSDictionary *projectInfo = dic[@"projectInfo"];
        cell.lookProjectdetialBlock = ^{
            NSDictionary *diaArg = @{
                                     @"projectId":projectInfo[@"projectId"],
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
    
    return obj;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if ([UserInfoManager getUserType]==UserTypeResourcer) {  //资源方，查看订单
//        [self lookOrderDetialWithIndexPath:indexPath withTag:0];
//    }
}

#pragma mark--MyOrderProjectCellADelegate
//查看项目
-(void)lookProjectWithIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath=indexPath;
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    NSDictionary *dicArg = @{@"projectid":projectModel.projectid};
    [AFWebAPI getProjectDetialWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            ProjectModel *model = [ProjectModel yy_modelWithDictionary:[object objectForKey:JSON_data]];
            ProjectDetailVC *PDVC = [ProjectDetailVC new];
            if (model.type==1) {
                PDVC.isAudition = NO;
            }
            else
            {
                PDVC.isAudition = YES;
            }
            PDVC.model = model;
            if (model.editstatus==1) {
                PDVC.type = 2;
            }
            else
            {
                PDVC.type = 3;
            }
            [self.navigationController pushViewController:PDVC animated:YES];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

//查看订单详情
-(void)lookOrderDetialWithIndexPath:(NSIndexPath *)indexPath withTag:(NSInteger)tag
{
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *orderModel =  projectModel.orderlist[tag];
    OrderDetialVC *detialVc = [[OrderDetialVC alloc]init];
    detialVc.orderModel = orderModel;
    detialVc.projectModel=projectModel;
    detialVc.isRefreshData = ^{
        [self refreshData];
    };
    [self.navigationController pushViewController:detialVc animated:YES];
}

//取消订单
-(void)cancleOrderWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"取消订单?" message:@"请确认是否要取消订单，订单一旦取消无法恢复" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
                                                        OrderModel *orderModel =  projectModel.orderlist[tag];
                                                        
                                                        [SVProgressHUD showWithStatus:@"正在取消订单..." maskType:SVProgressHUDMaskTypeClear];
                                                        
                                                        NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                                                                                 @"orderid":orderModel.orderId};
                                                        [AFWebAPI getcancleOrder:dicArg callBack:^(BOOL success, id object) {
                                                            if (success) {
                                                                [SVProgressHUD showSuccessWithStatus:@"订单已取消"];
                                                                [self refreshData];
                                                            }
                                                            else
                                                            {
                                                                AF_SHOW_RESULT_ERROR
                                                            }
                                                        }];
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}

//退出登录
-(void)logOut
{

}

//确认完成订单
-(void)confrimFinishOrderWithIndexPath:(NSIndexPath *)indexPath withTag:(NSInteger)tag
{
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *orderModel =  projectModel.orderlist[tag];

    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *dicArg=@{@"orderid":orderModel.orderId,
                           @"userid":[UserInfoManager getUserUID]};
    [AFWebAPI finishOrder:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"订单已完成"];
            [self refreshData];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

//再次确认档期
-(void)confrimSchedAgainOrderWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag
{
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *orderModel =  projectModel.orderlist[tag];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dicArg=@{@"orderid":orderModel.orderId,
                           @"buyerid":[UserInfoManager getUserUID]};
    [AFWebAPI getConfrimSchedAgainWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"档期已确认！"];
            [self refreshData];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

//评价，查看评价
-(void)evaluateOrderWithIndexPath:(NSIndexPath*)indexPath
{
    OrderProjectModel *model = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    WeakSelf(self);
    if (model.isevaluate==1) {
        PublishGradeViewController *vc = [PublishGradeViewController new];
//传userDetailInfo        vc.projectModel = model;
      
        vc.gradeSuccessReferesh = ^{
            [weakself refreshData];
        };
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        CheckGradeViewController *vc = [CheckGradeViewController new];
        vc.projectModel = model;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//申请开票
-(void)applyforinvoiceWithIndexPath:(NSIndexPath *)indexPath
{
    ApplyInvoicePopV *popV  = [[ApplyInvoicePopV alloc] init];
    [popV show];
}

//选中整个项目
-(void)selectAllProjectOrderWithIndexPath:(NSIndexPath*)indexPath withSelect:(BOOL)select
{
    //将其他数据选中状态清楚
    NSMutableArray *sec = self.dsm.ds[self.currIndex];
    for (int i=0; i<sec.count; i++) {
        OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][i] objectForKey:kMyOrderVCMCellData];
        if (i!=indexPath.section) {
            projectModel.isChoose=NO;
            for (int j=0; j<projectModel.orderlist.count; j++) {
                OrderModel *orderModel = projectModel.orderlist[j];
                orderModel.isChoose=NO;
            }
        }
    }
    
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    projectModel.isChoose=select;
    for (int i=0; i<projectModel.orderlist.count; i++) {
        OrderModel *model = projectModel.orderlist[i];
        model.isChoose=select;
    }
    
    CustomTableV *tableV=[self correspondingTableViewWithTag:self.currIndex];
    [tableV reloadData];
   
    [self refreshBottomV];
}

//选中项目下的一个订单
-(void)selectOneOrderWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag withSelect:(BOOL)select
{
    //将其他数据选中状态清楚
    NSMutableArray *sec = self.dsm.ds[self.currIndex];
    for (int i=0; i<sec.count; i++) {
        OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][i] objectForKey:kMyOrderVCMCellData];
        if (i!=indexPath.section) {
            projectModel.isChoose=NO;
            for (int j=0; j<projectModel.orderlist.count; j++) {
                OrderModel *orderModel = projectModel.orderlist[j];
                orderModel.isChoose=NO;
            }
        }
    }
    
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *orderModel =  projectModel.orderlist[tag];
    orderModel.isChoose = select;
    BOOL isAll = YES;
    //是否有未选中的
    for (int i=0; i<projectModel.orderlist.count; i++) {
        OrderModel *modelA = projectModel.orderlist[i];
        if (modelA.isChoose==NO) {
            isAll=NO;
        }
    }
    projectModel.isChoose=isAll;
    
    CustomTableV *tableV=[self correspondingTableViewWithTag:self.currIndex];
    [tableV reloadData];
    [self refreshBottomV];
}

#pragma mark--MyOrderProjectCellBDelegate
//接单
-(void)acceptOrderWithIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath=indexPath;
    [self acceltOrderActionWithIndexPath:indexPath];
}

//确认档期
-(void)confrimScheduleWithIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath=indexPath;
    [self acceltOrderActionWithIndexPath:indexPath];
}

//上传视频
-(void)uploadVideoWithIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath=indexPath;
    [self uploadVideo];
}

//拒单
-(void)rejectOrderWithIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath=indexPath;
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *model = [projectModel.orderlist firstObject];
    
    RejectOrderPopV *popV=[[RejectOrderPopV alloc]init];
    [popV showWithOrderType:model.ordertype];
    WeakSelf(self);
    popV.rejectWithReason = ^(NSString *reason) {
        [weakself rejectWithReason:reason withIndexPath:indexPath];
    };
}
#pragma -mark videoOnLine 发起在线试镜
-(void)videoOnLineWithIndexPath:(NSIndexPath *)indexPath
{
//    NSString *auditionDate = info.tryVideoInfo[@"auditionDate"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-DD HH:mm"];
//    NSDate *audition = [dateFormatter dateFromString:auditionDate];
//    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSComparisonResult result = [audition compare:nowDate];
//    if (result == NSOrderedDescending) {
//        //NSLog(@"Date1  is in the future");
//        [SVProgressHUD showImage:nil status:@"还没有到试镜时间不能确认完成"];
//        return;
//    }
    self.indexPath=indexPath;
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *model = [projectModel.orderlist firstObject];
    NSDictionary *arg = @{
                          @"orderId":model.orderId,
                          @"userId":@([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA lauchAuditionOnlineWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *body = object[@"body"];
            NSString *token = body[@"token"];
            if (token.length>0) {
                QNTestVC *qn = [QNTestVC new];
                qn.isCall = YES;
                qn.token = token;
                qn.hisAvatar = body[@"otherHead"];
                qn.hisName = body[@"otherName"];
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (authStatus != AVAuthorizationStatusAuthorized) {
                    
                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                        NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
                        if (granted) {
                            [self presentViewController:qn animated:YES completion:nil];
                        }
                    }];
                    
                } else {  //做你想做的（可以去打开设置的路径）
                    [self presentViewController:qn animated:YES completion:nil];
                }
                
            }else{
                [SVProgressHUD showImage:nil status:@"未获取到试镜间信息"];
            }
        }
      
    }];
}
//-(void)modifyAuditionTimeWithIndexPath:(NSIndexPath *)indexPath
//{
//    self.indexPath=indexPath;
//    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
//    OrderModel *model = [projectModel.orderlist firstObject];
//    NSString *auditionDate = model.datereservation;
//    DatePickPopV *popV = [[DatePickPopV alloc]init];
//    NSDate *minimumDate = [NSDate date];
//    NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
//    [popV showWithMinDate:minimumDate maxDate:maximumDate];
//    popV.dateString = ^(NSString * _Nonnull str) {
//
//        if ([auditionDate containsString:str]) {//选了一样的天数 不操作
//
//        }else{//选择了不一样的天数
//            NSMutableDictionary *tryInfo = [NSMutableDictionary new];
//            [tryInfo addEntriesFromDictionary:info.tryVideoInfo];
//            [tryInfo removeObjectForKey:@"auditionDate"];
//            [tryInfo setObject:str forKey:@"auditionDate"];
//            info.tryVideoInfo = [tryInfo copy];
//            [weakself tryVideoProceWithInfo:info withOperate:208 withStatus:@"已修改试镜时间" isRefresh:YES];
//        }
//
//    };
//}
#pragma mark-----Action
-(void)acceptWithIndexParh:(NSIndexPath*)indexPath
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *model = [projectModel.orderlist firstObject];
    
    NSDictionary *dicArg=@{@"orderid":model.orderId,
                           @"userid":[UserInfoManager getUserUID]};
    NSString *service ;
    if (model.ordertype==OrderTypeShot) {
        service=@"Order.proAccept";
    }
    else if (model.ordertype==OrderTypeAudition)
    {
        service=@"order.accept";
    }
    [AFWebAPI getAcceptOrder:dicArg withSerivce:service callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self refreshData];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

//上传视频/图片
- (void)uploadVideo
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    
    picker.mediaTypes = [NSArray arrayWithObject:availableMedia[1]]; //设置媒体类型为public.image
    [self presentViewController:picker animated:YES completion:^{}];
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][self.indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *model = [projectModel.orderlist firstObject];

    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.movie"]) {
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSData *file = [NSData dataWithContentsOfURL:url];
        
        [SVProgressHUD showWithStatus:@"正在上传视频" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dicArg=@{@"orderid":model.orderId,
                               @"userid":model.actorid};
        [AFWebAPI uploadVideoAuditionOrder:dicArg data:file callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"视频已上传！"];
                [self refreshData];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

//接单
-(void)acceltOrderActionWithIndexPath:(NSIndexPath*)indexPath
{
    if ([UserInfoManager getUserAuthState]!=1) {
        AuthPopV *popV = [[AuthPopV alloc]init];
        [popV show];
        popV.goAuthBlock = ^{
            if ([UserInfoManager getUserAuthState]==0) {
                AuthResourcerVC *authVC=[[AuthResourcerVC alloc]init];
                [self.navigationController pushViewController:authVC animated:YES];
            }
            else if ([UserInfoManager getUserAuthState]==2 || [UserInfoManager getUserAuthState]==3)
            {
                MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
                stateVC.authState=[UserInfoManager getUserAuthState];
                [self.navigationController pushViewController:stateVC animated:YES];
            }
        };
        return;
    }
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *model = [projectModel.orderlist firstObject];
    
    ScriptPrivaryPopV *scriptPopV = [[ScriptPrivaryPopV alloc]init];
    [scriptPopV show];
    scriptPopV.confrimOrder = ^{
        if (model.payterms==1 && model.ordertype==OrderTypeShot) {
            AcceptOrderPopV *popV = [[AcceptOrderPopV alloc]init];
            [popV show];
            popV.acceptOrder = ^{
                [self acceptWithIndexParh:indexPath];
            };
        }
        else
        {
            [self acceptWithIndexParh:indexPath];
        }
    };
}

-(void)rejectWithReason:(NSString*)reason withIndexPath:(NSIndexPath*)indexPath
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    OrderProjectModel *projectModel = [(NSDictionary *)self.dsm.ds[self.currIndex][indexPath.section] objectForKey:kMyOrderVCMCellData];
    OrderModel *model = [projectModel.orderlist firstObject];
    
    NSDictionary *dicArg=@{@"orderid":model.orderId,
                           @"msg":reason,
                           @"userid":[UserInfoManager getUserUID]};
    NSString *service ;
    if (model.ordertype==OrderTypeShot) {
        service=@"Order.proReject";
    }
    else if (model.ordertype==OrderTypeAudition)
    {
        service=@"order.reject";
    }
    
    [AFWebAPI getRejectOrder:dicArg withSerivce:service callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"订单已拒绝"];
            
            [self refreshData];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}


#pragma mark--
//根据tag得到当前tableView
-(CustomTableV*)correspondingTableViewWithTag:(NSInteger)tag
{
    CustomTableV *tableV=[self.scrollV viewWithTag:tag+100];
    return tableV;
}

//播放视频
-(void)playVideoWithUrl:(NSString *)url
{
    
    
    [_player destroyPlayer];
    _player = nil;
    
    _player = [[VideoPlayer alloc] init];
    _player.videoUrl =url;
    _player.onlyFullScreen=YES;
    
    _player.completedPlayingBlock = ^(VideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
    _player.dowmLoadBlock = ^{
        
    };
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player destroyPlayer];
    _player = nil;
}

@end
