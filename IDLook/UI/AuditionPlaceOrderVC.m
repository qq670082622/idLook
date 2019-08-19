//
//  AuditionPlaceOrderVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditionPlaceOrderVC.h"
#import "ScheduleLockBottomV.h"
#import "ScheduleLockFootV.h"
#import "ScheduleLockVCM.h"
#import "ScheduleLockCellA.h"
#import "ScheduleLockCellE.h"
#import "AuditionPOCellA.h"
#import "AuditionBottomV.h"
#import "PlaceOrderModel.h"
#import "AuditWayPopV.h"
#import "BirthSelectV.h"
#import "PublicWebVC.h"
#import "OrderProjectModel.h"
#import "ProjectDetailVC2.h"
#import "PayWaysVC.h"

@interface AuditionPlaceOrderVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)AuditionBottomV *bottomV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger auditType;  //试镜类型
@property(nonatomic,strong)NSString *auditTime;  //试镜时间，最晚上传作品时间
@property(nonatomic,strong)NSString *auditAddress;  //试镜地点
@end

@implementation AuditionPlaceOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"试镜下单"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self getData];
    [self tableV];
    [self bottomV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    NSArray *array = @[@{@"title":@"饰演角色",@"content":self.info.roleInfo[@"roleName"],@"placeholder":@"",@"ischoose":@(YES),@"isEdit":@(NO)},
                       @{@"title":@"试镜方式",@"content":@"",@"placeholder":@"请选择试镜方式",@"ischoose":@(NO),@"isEdit":@(NO),@"price":@"0"},
                       ];
    self.dataSource = [NSMutableArray new];
    
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic =array[i];
        OrderStructM *model = [[OrderStructM alloc]initWithDic:dic];
        [self.dataSource addObject:model];
    }
    
}

-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-48) style:UITableViewStyleGrouped];
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

-(AuditionBottomV*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[AuditionBottomV alloc]init];
        [self.view addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-SafeAreaTabBarHeight_IphoneX);
            make.height.mas_equalTo(48);
        }];
        WeakSelf(self);
        _bottomV.priceDetailBlock = ^{  //价格明细
            
        };
        _bottomV.placeOrderBlock = ^{  //下单
            [weakself submitOrder];
        };
    }
    return _bottomV;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 143;
    }
    else if (indexPath.section==1)
    {
        if (self.auditType==0) {  //未选择
             return 190;
        }
        else if (self.auditType==1) {   //自备
            return 286+30;
        }
        else if (self.auditType==2) //影棚
        {
            return 238;
        }
        else if (self.auditType==3)  //手机
        {
            return 260;
        } else if (self.auditType==4)  //在线试镜
        {
            return 238;
        }
        return 260;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    if (sec==0) {
        static NSString *identifer = @"ScheduleLockCellA";
        ScheduleLockCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[ScheduleLockCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
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
        return cell;
    }
    else if (sec==2)
    {
        static NSString *identifer = @"ScheduleLockCellE";
        ScheduleLockCellE *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[ScheduleLockCellE alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        [cell reloadUI];
        return cell;
    }
    else//试镜
    {
        static NSString *identifer = @"AuditionPOCellA";
        AuditionPOCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuditionPOCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        [cell reloadUIWithProjectOrderInfo:self.info withArray:self.dataSource withType:0];
        WeakSelf(self);
        cell.AuditionPOCellABeginEdit = ^(NSInteger type){
            
        };
        cell.AuditionPOCellAtextFieldChangeBlock = ^(NSString *text,NSInteger type) {
            OrderStructM *model = weakself.dataSource[type];
            model.content = text;
        };
        cell.typeClickBlock = ^(NSInteger type) {
            OrderStructM *model1 = weakself.dataSource[1];
            if (type==1) {  //试镜方式

                AuditWayPopV *popV = [[AuditWayPopV alloc]init];
                [popV showWithOrderM:model1];
                
                popV.auditionWayChooseWithModel = ^(OrderStructM *OrderM) {
                    weakself.auditType=OrderM.type;

                    model1.content=OrderM.title;
                    model1.price=OrderM.price;
                    model1.type=OrderM.type;
                    [weakself.bottomV reloadUIWithPrice:model1.price];
                    
                    [weakself initDataWithAuditType:OrderM.type];
                    [weakself.tableV reloadData];
                };
            }
            else if (type==2)  //试镜时间
            {
                OrderStructM *model2 = weakself.dataSource[2];

                BirthSelectV *birthV = [[BirthSelectV alloc] init];
                birthV.didSelectDate = ^(NSString *dateStr){
                    model2.content = dateStr;
                    [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                };
                DateType type = DateTypeDay;
                if (model1.type==1 || model1.type==2 || model1.type==4) {
                    type =DateTypeMinute;
                }
                [birthV showWithString:model2.content withType:type];
            }
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"保单详情" url:[NSString stringWithFormat:@"http://www.idlook.com/public/protocol/html/index.html?num_id=%@",@""]];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

//选择不同的试镜方式填充不同的数据
-(void)initDataWithAuditType:(NSInteger)type
{
    OrderStructM *model1 = self.dataSource[1];

    if (type==1) {  //自备场地
        NSArray *array = @[@{@"title":@"饰演角色",@"content":self.info.roleInfo[@"roleName"],@"placeholder":@"",@"ischoose":@(YES),@"isEdit":@(NO)},
                           @{@"title":@"试镜方式",@"content":@"",@"placeholder":@"请选择试镜方式",@"ischoose":@(NO),@"isEdit":@(NO),@"price":@"0"},
                           @{@"title":@"试镜时间",@"content":@"",@"placeholder":@"请选择试镜时间",@"ischoose":@(NO),@"isEdit":@(NO)},
                           @{@"title":@"试镜场地",@"content":@"",@"placeholder":@"请填写试镜场地",@"ischoose":@(YES),@"isEdit":@(YES)},
                           ];
        
        [self.dataSource  removeAllObjects];
        
        for (int i=0; i<array.count; i++) {
            NSDictionary *dic =array[i];
            OrderStructM *model = [[OrderStructM alloc]initWithDic:dic];
            [self.dataSource addObject:model];
        }
        [self.dataSource replaceObjectAtIndex:1 withObject:model1];

    }
    else if (type==2) //影棚
    {

        NSArray *array = @[@{@"title":@"饰演角色",@"content":self.info.roleInfo[@"roleName"],@"placeholder":@"",@"ischoose":@(YES),@"isEdit":@(NO)},
                           @{@"title":@"试镜方式",@"content":@"",@"placeholder":@"请选择试镜方式",@"ischoose":@(NO),@"isEdit":@(NO),@"price":@"0"},
                           @{@"title":@"试镜时间",@"content":@"",@"placeholder":@"请选择试镜时间",@"ischoose":@(NO),@"isEdit":@(NO)},
                           ];
        
        [self.dataSource  removeAllObjects];
        
        for (int i=0; i<array.count; i++) {
            NSDictionary *dic =array[i];
            OrderStructM *model = [[OrderStructM alloc]initWithDic:dic];
            [self.dataSource addObject:model];
        }
        [self.dataSource replaceObjectAtIndex:1 withObject:model1];
    }
    else if (type==3)  //手机
    {
        NSArray *array = @[@{@"title":@"饰演角色",@"content":self.info.roleInfo[@"roleName"],@"placeholder":@"",@"ischoose":@(YES),@"isEdit":@(NO)},
                           @{@"title":@"试镜方式",@"content":@"",@"placeholder":@"请选择试镜方式",@"ischoose":@(NO),@"isEdit":@(NO),@"price":@"0"},
                           @{@"title":@"最晚上传作品日期",@"content":@"",@"placeholder":@"请选择最晚上传作品时间",@"ischoose":@(NO),@"isEdit":@(NO)}];
        
        [self.dataSource  removeAllObjects];
        
        for (int i=0; i<array.count; i++) {
            NSDictionary *dic =array[i];
            OrderStructM *model = [[OrderStructM alloc]initWithDic:dic];
            [self.dataSource addObject:model];
        }
        [self.dataSource replaceObjectAtIndex:1 withObject:model1];
    }
    else if (type==4)  //在线试镜
    {
        NSArray *array = @[@{@"title":@"饰演角色",@"content":self.info.roleInfo[@"roleName"],@"placeholder":@"",@"ischoose":@(YES),@"isEdit":@(NO)},
                           @{@"title":@"试镜方式",@"content":@"",@"placeholder":@"请选择试镜方式",@"ischoose":@(NO),@"isEdit":@(NO),@"price":@"0"},
                           @{@"title":@"试镜时间",@"content":@"",@"placeholder":@"请选择试镜时间",@"ischoose":@(NO),@"isEdit":@(NO)}];
        
        [self.dataSource  removeAllObjects];
        
        for (int i=0; i<array.count; i++) {
            NSDictionary *dic =array[i];
            OrderStructM *model = [[OrderStructM alloc]initWithDic:dic];
            [self.dataSource addObject:model];
        }
        [self.dataSource replaceObjectAtIndex:1 withObject:model1];
    }
}


//提交订单
-(void)submitOrder
{
    OrderStructM *model1 = self.dataSource[1];
    OrderStructM *model2 = self.dataSource[2];
    
    if (model1.content.length==0) {
        [SVProgressHUD showErrorWithStatus:model1.placeholder];
        return;
    }
    
    if (model2.content.length==0) {
        [SVProgressHUD showErrorWithStatus:model2.placeholder];
        return;
    }
    
    NSString *tryVideoAddress =@"";
    NSString *auditionDate =@"";
    NSString *workLastDate =@"";

    if (self.auditType==1) {  //自备
        OrderStructM *model3 = self.dataSource[3];
        tryVideoAddress=model3.content;
        auditionDate=model2.content;
    }
    else if (self.auditType==2)  //影棚
    {
        auditionDate=model2.content;
    }
    else if (self.auditType==3)  //手机
    {
        workLastDate=model2.content;
    }
    else if (self.auditType==4)  //在线试镜
    {
        auditionDate=model2.content;
    }
    NSDictionary *dicArg = @{@"operate":@(201),
                             @"orderId":self.info.orderId,
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType]),
                             @"auditionOrderInfo":@{@"auditionDate":auditionDate,
                                                    @"auditionMode":@(model1.type),
                                                    @"workLastDate":workLastDate,
                                                    @"tryVideoAddress":tryVideoAddress
                                                    }
                             };
    [SVProgressHUD  showWithStatus:@"正在下单，请稍后。"];
    [AFWebAPI_JAVA getTryVideoProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"下单成功"];
            
            NSString *orderId = [object objectForKey:JSON_body][@"orderId"];
            PayWaysVC *payVC=[[PayWaysVC alloc]init];
            payVC.orderids=orderId;
            payVC.totalPrice=[model1.price integerValue];
            WeakSelf(self);
            payVC.refreshData = ^{
                NSDictionary *dicArg = @{@"operate":@(202),
                                         @"orderId":orderId,
                                         @"userId":[UserInfoManager getUserUID],
                                         @"userType":@([UserInfoManager getUserType])
                                         };
        
                [AFWebAPI_JAVA getTryVideoProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
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
