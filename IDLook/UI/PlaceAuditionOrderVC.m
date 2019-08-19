//
//  PlaceAuditionOrderVC.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceAuditionOrderVC.h"
#import "PlaceOrderCustomCell.h"
#import "PlaceOrderHeadV.h"
#import "BirthSelectV.h"
#import "PlaceOrderCellB.h"
#import "PlaceAuditCellB.h"
#import "PlaceAuditCellC.h"
#import "PlaceAuditCellD.h"
#import "EditStructM.h"
#import "CenterCustomCell.h"
#import "PriceBottomVA.h"
#import "PublicWebVC.h"
#import "PayWaysVC.h"
#import "DatePickPopV.h"
#import "OrderPickerPopV.h"
#import "CitySelectStep1.h"
#import "PlaceAuditionVCM.h"
#import "PlaceAuditItemCellA.h"
#import "PlaceAuditItemCellB.h"
#import "PlaceAuditItemCellC.h"
#import "AuditWayPopV.h"
#import "ProjectChooseVC.h"
#import "ProjectDetailVC.h"
#import "OrderProjectModel.h"

@interface PlaceAuditionOrderVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ProjectDetailVCDelegate>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)PriceBottomVA *bottomV;
@property(nonatomic,strong)PlaceAuditionVCM *dataM;
@property(nonatomic,strong)ProjectModel *projectModel;  //项目模型
@property(nonatomic,assign)BOOL isHaveProject;  //是否有项目

@end

@implementation PlaceAuditionOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"试镜下单"]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self.dataM refreshAuditionInfo];
    
    [self bottomV];
    
    [self reloadUIWithWay];
    
    [self getData];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                             @"artistid":self.info.UID};
    [AFWebAPI getUserInfoWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            self.info = [[UserInfoM alloc]initWithDic:[object objectForKey:JSON_data]];
            [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
    NSDictionary *dicArgA = @{@"userid":[UserInfoManager getUserUID],
                              @"type":@(1)};
    [AFWebAPI getProjectInfoWithArg:dicArgA callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array = [object objectForKey:JSON_data];
            if (array.count>0) {
                self.isHaveProject=YES;
            }
            [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

-(PlaceAuditionVCM*)dataM
{
    if (!_dataM) {
        _dataM = [[PlaceAuditionVCM alloc]init];
        _dataM.info=self.info;
        _dataM.orderInfo=self.sModel;
        WeakSelf(self);
        _dataM.newDataNeedRefreshed = ^{
            [weakself.tableV reloadData];
        };
    }
    return _dataM;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-48) style:UITableViewStyleGrouped];
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
        _tableV.tableFooterView=[self footV];
    }
    return _tableV;
}

-(PriceBottomVA*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[PriceBottomVA alloc]init];
        [self.view addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-SafeAreaTabBarHeight_IphoneX);
            make.height.mas_equalTo(47.5);
        }];
        WeakSelf(self);
        _bottomV.placeOrderBlock  = ^{
            [weakself placeOrderAction];
        };
    }
    return _bottomV;
}

-(UIView*)footV
{
    UIView *footV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 60)];
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:13.0];
    lab.textColor = [UIColor colorWithHexString:@"#999999"];
    lab.text=@"售前咨询电话：";
    [footV addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footV).offset(15);
        make.top.mas_equalTo(footV).offset(15);
    }];
    
    UIButton *phone = [UIButton buttonWithType:UIButtonTypeCustom];
    [phone setTitle:@"400 833 6969" forState:UIControlStateNormal];
    [phone setTitleColor:[UIColor colorWithHexString:@"#75BDFF"] forState:UIControlStateNormal];
    phone.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [footV addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right).offset(5);
        make.centerY.mas_equalTo(lab).offset(0);
    }];
    [phone addTarget:self action:@selector(takePhone) forControlEvents:UIControlEventTouchUpInside];
    return footV;
}

//打电话
-(void)takePhone
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return .1f;
    }
    return 10.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataM.ds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataM.ds[section]count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[(NSDictionary *)self.dataM.ds[indexPath.section][indexPath.row] objectForKey:kPlaceAuditionVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec= indexPath.section;
    NSInteger row = indexPath.row;
    NSString *classStr = [(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceAuditionVCMCellClass];
    WeakSelf(self);
    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }
    
    if ([classStr isEqualToString:@"PlaceAuditItemCellA"]) {
        PlaceAuditItemCellA *cell = (PlaceAuditItemCellA*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithType:1 withIsProject:self.isHaveProject];
    }
    else if ([classStr isEqualToString:@"PlaceAuditItemCellB"]) {
        PlaceAuditItemCellB *cell = (PlaceAuditItemCellB*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIModel:self.projectModel];
        cell.isExpendBlock = ^(BOOL isExpend) {
            weakself.tableV.contentOffset=CGPointMake(0, 0);
            weakself.projectModel.isExpend=isExpend;
            [weakself.dataM isExpendItemWithValue:isExpend withProjectModel:self.projectModel];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
    else if ([classStr isEqualToString:@"PlaceAuditItemCellC"])
    {
        PlaceAuditItemCellC *cell = (PlaceAuditItemCellC*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithModel:self.projectModel];
    }
    else if ([classStr isEqualToString:@"PlaceAuditCellC"]) {
        PlaceAuditCellC *cell = (PlaceAuditCellC*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithInfo:self.info];
    }
    else if ([classStr isEqualToString:@"PlaceOrderCustomCell"])
    {
        OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceAuditionVCMCellData];
        PlaceOrderCustomCell *cell = (PlaceOrderCustomCell*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithModel:model];
        cell.BeginEdit = ^{
        };
    }
    else if ([classStr isEqualToString:@"PlaceAuditCellD"])
    {
        PlaceAuditCellD *cell = (PlaceAuditCellD*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUI];
    }
    return obj;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *classStr = [(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceAuditionVCMCellClass];
    WeakSelf(self);
    if ([classStr isEqualToString:@"PlaceAuditItemCellA"] || [classStr isEqualToString:@"PlaceAuditItemCellC"]) {
        if (self.isHaveProject==NO) {  //新建项目
            [self addProject];
        }
        else
        {
            ProjectChooseVC *chooseVC= [[ProjectChooseVC alloc]init];
            chooseVC.projectType=1;
            chooseVC.projectModel=self.projectModel;
            chooseVC.selectProjectModelBlock = ^(ProjectModel * _Nonnull projectModel) {
                weakself.projectModel=projectModel;
                [weakself.dataM addItemRefreshCell];
            };
            [self.navigationController pushViewController:chooseVC animated:YES];
        }
    }
    
    else if ([classStr isEqualToString:@"PlaceOrderCustomCell"])
    {
        OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceAuditionVCMCellData];

        AuditWayPopV *popV = [[AuditWayPopV alloc]init];
        [popV showWithOrderM:model];
        WeakSelf(self);
        popV.auditionWayChooseWithModel = ^(OrderStructM *OrderM) {
            model.content=OrderM.title;
            model.price=OrderM.price;
            model.type=OrderM.type;
            [weakself reloadUIWithWay];
        };
    }
    else if ([classStr isEqualToString:@"PlaceAuditCellD"])
    {
        //http://page.idlook.com/public/protocol/html/index.html?num_id=   正式
        //http://www.pre.idlook.com/public/protocol/html/index.html?num_id=  测试
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"保单详情" url:[NSString stringWithFormat:@"http://www.idlook.com/public/protocol/html/index.html?num_id=%@",self.model.policynum]];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    [self.view endEditing:YES];
}

-(void)reloadUIWithWay
{
    OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][1] objectForKey:kPlaceAuditionVCMCellData];
    [self.bottomV reloadUIWithPrice:model.price WithType:0];
    [self.dataM refreshInsuranceCellWithModel:model];
    
    [self.tableV reloadData];
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//新建项目
-(void)addProject
{
    ProjectDetailVC *PDVC = [ProjectDetailVC new];
    PDVC.isAudition = NO;
    PDVC.delegate=self;
    PDVC.type = 1;
    [self.navigationController pushViewController:PDVC animated:YES];
}

#pragma mark--ProjectDetailVCDelegate
-(void)VCRefereshWithProjectModel:(ProjectModel *)projectModel
{
    if (projectModel==nil) {
        return;
    }
    self.isHaveProject=YES;
    self.projectModel=projectModel;
    [self.dataM addItemRefreshCell];
}

#pragma mark---
#pragma 下单
-(void)placeOrderAction
{
    if (self.projectModel.projectid.length==0) {
        [SVProgressHUD showImage:nil status:@"请添加试镜项目"];
        return;
    }
    
    OrderStructM *typeModel = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][1] objectForKey:kPlaceAuditionVCMCellData];  //试镜方式
    if (typeModel.content.length==0) {
        [SVProgressHUD showImage:nil status:typeModel.placeholder];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在下单，请稍后." maskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dic = @{@"userid":[UserInfoManager getUserUID],   //用户id
                          @"artistid":self.info.UID,               //艺人id
                          @"auditionmode":@(typeModel.type),       //试镜方式
                          @"projectid":self.projectModel.projectid, //项目id
                          @"price":typeModel.price,               //订单价格
                          @"totalprice":typeModel.price};        //总价格
    [AFWebAPI ProjectAuditionPlaceOrder:dic callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"下单成功!"];
                        
            WeakSelf(self);
            OrderProjectModel *projectModel = [[OrderProjectModel alloc]initWithDic:[object objectForKey:JSON_data]];
            OrderModel *orderModel = [projectModel.orderlist firstObject];
            PayWaysVC *payVC=[[PayWaysVC alloc]init];
            payVC.orderids=orderModel.orderId;
            payVC.totalPrice=[orderModel.totalprice integerValue];
            payVC.refreshData = ^{
                [weakself onGoback];
            };
            [self.navigationController pushViewController:payVC animated:YES];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}



@end
