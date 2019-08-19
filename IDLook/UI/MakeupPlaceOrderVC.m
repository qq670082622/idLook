//
//  MakeupPlaceOrderVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/28.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "MakeupPlaceOrderVC.h"
#import "ScheduleLockBottomV.h"
#import "ScheduleLockFootV.h"
#import "ScheduleLockVCM.h"
#import "ScheduleLockCellA.h"
#import "ScheduleLockCellE.h"
#import "AuditionPOCellA.h"
#import "AuditionBottomV.h"
#import "PlaceOrderModel.h"
#import "MakeupTypePopV.h"
#import "BirthSelectV.h"
#import "PublicWebVC.h"
#import "OrderProjectModel.h"
#import "ProjectDetailVC2.h"

@interface MakeupPlaceOrderVC ()<UITableViewDataSource,UITableViewDelegate,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)AuditionBottomV *bottomV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation MakeupPlaceOrderVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"定妆下单"]];
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
                       @{@"title":@"定妆类别",@"content":@"",@"placeholder":@"请选择定妆类别",@"ischoose":@(NO),@"isEdit":@(NO),@"price":@"0"},
                       @{@"title":@"定妆时间",@"content":@"",@"placeholder":@"请选择定妆时间",@"ischoose":@(NO),@"isEdit":@(NO)},
                       @{@"title":@"定妆地址",@"content":@"",@"placeholder":@"请填写定妆地址",@"ischoose":@(YES),@"isEdit":@(YES)}];
    self.dataSource = [NSMutableArray new];
    
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic =array[i];
        OrderStructM *model = [[OrderStructM alloc]initWithDic:dic];
        [self.dataSource addObject:model];
    }
    
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-48) style:UITableViewStyleGrouped];
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
        return 287;
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
    else
    {
        static NSString *identifer = @"AuditionPOCellA";
        AuditionPOCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuditionPOCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        [cell reloadUIWithProjectOrderInfo:self.info withArray:self.dataSource withType:1];
        WeakSelf(self);
        cell.typeClickBlock = ^(NSInteger type) {
            [weakself.view endEditing:YES];
            OrderStructM *model = weakself.dataSource[type];
            if (type==1) {
                MakeupTypePopV *popV = [[MakeupTypePopV alloc]init];
                [popV showWithOrderM:model];
                popV.auditionWayChooseWithModel = ^(OrderStructM *OrderM) {
                    model.content=OrderM.title;
                    model.price=OrderM.price;
                    model.type=OrderM.type;
                    [weakself.bottomV reloadUIWithPrice:model.price];
                    [weakself.tableV reloadData];
                };
            }
            else if (type==2)
            {
                BirthSelectV *birthV = [[BirthSelectV alloc] init];
                birthV.didSelectDate = ^(NSString *dateStr){
                    model.content = dateStr;
                    [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                };
                [birthV showWithString:model.content withType:DateTypeDay];
            }
        };
        cell.AuditionPOCellABeginEdit = ^(NSInteger type){};
        cell.AuditionPOCellAtextFieldChangeBlock = ^(NSString *text,NSInteger type) {
            OrderStructM *model = weakself.dataSource[type];
            model.content = text;
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


//提交订单
-(void)submitOrder
{
    for (int i=1; i<self.dataSource.count; i++) {
         OrderStructM *model = self.dataSource[i];
        if (model.content.length==0) {
            [SVProgressHUD showErrorWithStatus:model.placeholder];
            return;
        }
    }
    
    OrderStructM *model1 = self.dataSource[1];
    OrderStructM *model2 = self.dataSource[2];
    OrderStructM *model3 = self.dataSource[3];

    if (model1.content.length==0) {
        [SVProgressHUD showErrorWithStatus:model1.placeholder];
        return;
    }
    
    if (model2.content.length==0) {
        [SVProgressHUD showErrorWithStatus:model2.placeholder];
        return;
    }
    
    NSDictionary *dicArg = @{@"operate":@(401),
                             @"orderId":self.info.orderId,
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType]),
                             @"makeupOrderInfo":@{@"makeupType":@(model1.type),
                                                  @"makeupDate":model2.content,
                                                  @"makeupAddress":model3.content
                                                  }
                             };
    [SVProgressHUD  showWithStatus:@"正在下单，请稍后。"];
    [AFWebAPI_JAVA getMakeupProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"下单成功"];
            [self onGoback];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
