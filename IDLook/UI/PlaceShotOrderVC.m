//
//  PlaceShotOrderVC.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceShotOrderVC.h"
#import "PlaceOrderCustomCell.h"
#import "PlaceOrderHeadV.h"
#import "PlaceOrderCellB.h"
#import "PlaceAuditCellB.h"
#import "PlaceAuditCellC.h"
#import "PlaceAuditCellD.h"
#import "EditStructM.h"
#import "CenterCustomCell.h"
#import "PriceBottomVB.h"
#import "PublicWebVC.h"
#import "OfferTypePopV.h"
#import "OfferTypePopV2.h"
#import "CitySelectStep1.h"
#import "OrderPickerPopV.h"
#import "ShotStepCellA.h"
#import "ShotStepCellF.h"
#import "ShotPriceDPopV.h"
#import "AddPriceModel.h"
#import "DatePickPopV.h"
#import "PayWaysVC.h"
#import "DayExplainPopV.h"
#import "ShotFootV.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"
#import "ShotNoticePopV.h"
#import "PlaceShotVCM.h"
#import "PlaceAuditItemCellA.h"
#import "PlaceAuditItemCellB.h"
#import "PlaceAuditItemCellC.h"
#import "MakeupWayPopV.h"
#import "ScheduleWayPopV.h"
#import "ProjectChooseVC.h"
#import "ProjectDetailVC.h"
#import "UserLookPricePopV.h"

@interface PlaceShotOrderVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TableVTouchDelegate,ProjectDetailVCDelegate>
@property(nonatomic,strong)TouchTableV *tableV;

@property(nonatomic,strong)PriceBottomVB *bottomV;
@property(nonatomic,strong)NSArray *videoDayPriceLsit;   //视频天数报价列表，每一天的报价
@property(nonatomic,assign)NSInteger downCount;  //倒计时
@property(nonatomic,strong)PlaceShotVCM *dataM;
@property(nonatomic,strong)ProjectModel *projectModel;  //项目模型
@property(nonatomic,assign)BOOL isHaveProject;  //是否有项目
@property(nonatomic,strong)NSDictionary *orderPriceInfo;  //订单价格信息
@property(nonatomic,strong)NSArray *priceList;  //报价列表
@end

@implementation PlaceShotOrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"拍摄下单"]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.downCount=5;
    [self bottomV];
    [self .dataM refreshShotInfo];
    [self getData];

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][2] objectForKey:kPlaceShotVCMCellData];
    
    if (self.videoTypeDic!=nil) {
        model.videoTypeDic=self.videoTypeDic;
    }
    
    //刷新艺人信息
    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                             @"artistid":self.info.UID};
    [AFWebAPI getUserInfoWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            self.info = [[UserInfoM alloc]initWithDic:[object objectForKey:JSON_data]];
            [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.bottomV reloadUIWithTotalPrice:0 withSale:0 withScore:0];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
    //查看是否有项目
    NSDictionary *dicArgA = @{@"userid":[UserInfoManager getUserUID],
                             @"type":@(2)};
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
    
    //获取报价列表
    NSDictionary *dicArgB = @{@"userId":@([[UserInfoManager getUserUID] integerValue]),
                             @"actorId":self.dataM.info.UID};
    [AFWebAPI_JAVA getQuotaListWithArg:dicArgB callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSDictionary *dic = [object objectForKey:JSON_body];
            self.priceList = (NSArray*)safeObjectForKey(dic, @"quotationList");
        }else{
          
        }
    }];
}

-(PlaceShotVCM*)dataM
{
    if (!_dataM) {
        _dataM = [[PlaceShotVCM alloc]init];
        _dataM.info=self.info;
        WeakSelf(self);
        _dataM.newDataNeedRefreshed = ^{
            [weakself.tableV reloadData];
        };
    }
    return _dataM;
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-128) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableV.separatorColor =Public_LineGray_Color;
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

-(PriceBottomVB*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[PriceBottomVB alloc]init];
        [self.view addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-SafeAreaTabBarHeight_IphoneX);
            make.height.mas_equalTo(60+68);
        }];
        WeakSelf(self);
        _bottomV.placeOrderBlock  = ^{
            OrderStructM *model = (OrderStructM*)[(NSDictionary *)weakself.dataM.ds[1][1] objectForKey:kPlaceShotVCMCellData];  //定妆方式

            NSInteger day = 0;
            OrderStructM *model2 = (OrderStructM*)[(NSDictionary *)weakself.dataM.ds[1][2] objectForKey:kPlaceShotVCMCellData];  //下单类别
            if (model2.videoTypeArray.count>=0) {
                PriceModel *pModel = [model2.videoTypeArray firstObject];
                day=pModel.day;
            }
            
            ShotPriceDPopV *popV=[[ShotPriceDPopV alloc]init];
            [popV showWithLoad:NO withModel:model withPriceInfo:weakself.orderPriceInfo];
            [weakself placeOrderAction];
        };
        _bottomV.praceDetailBlock = ^{
            OrderStructM *model = (OrderStructM*)[(NSDictionary *)weakself.dataM.ds[1][1] objectForKey:kPlaceShotVCMCellData];  //定妆方式

            ShotPriceDPopV *popV=[[ShotPriceDPopV alloc]init];
            [popV showWithLoad:YES withModel:model withPriceInfo:weakself.orderPriceInfo];
        };
    }
    return _bottomV;
}

-(ShotFootV*)footV
{
    CGFloat height = 70;
    if ([UserInfoManager getUserSubType]==UserSubTypePurPersonal) {
        height = 135;
    }
    
    ShotFootV *footV =[[ShotFootV alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, height)];
    footV.takePhoneBlock = ^{  //打电话
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        });
    };
    WeakSelf(self);
    footV.upgradeBlock = ^{  //升级
        [weakself upgradeCompany];
    };
    footV.protocolBlock = ^{  //协议
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"委托代收代付条款" url:@"http://www.idlook.com/public/entrusted-notification/index.html"];
        [weakself.navigationController pushViewController:webVC animated:YES];
    };
    return footV;
}

//升级成企业买家
-(void)upgradeCompany
{
    
    if ([UserInfoManager getUserAuthState]==1) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dic =@{@"userid":[UserInfoManager getUserUID],
                             @"usertype":@([UserInfoManager getUserType])};
        [AFWebAPI getAuthInfoWithArg:dic callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD dismiss];
                
                NSDictionary *dic = [object objectForKey:JSON_data];
                AuthBuyerVC *authVC=[[AuthBuyerVC alloc]init];
                authVC.buyType=1;
                authVC.upgradeDic=dic;
                authVC.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:authVC animated:YES];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    else if ([UserInfoManager getUserAuthState]==2 || [UserInfoManager getUserAuthState]==3)
    {
        MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
        stateVC.authState=[UserInfoManager getUserAuthState];
        stateVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:stateVC animated:YES];
    }
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
    return [self.dataM.ds[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[(NSDictionary *)self.dataM.ds[indexPath.section][indexPath.row] objectForKey:kPlaceShotVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec= indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *classStr = [(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceShotVCMCellClass];
    WeakSelf(self);
    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }
    if ([classStr isEqualToString:@"PlaceAuditItemCellA"]) {
        PlaceAuditItemCellA *cell = (PlaceAuditItemCellA*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithType:2 withIsProject:self.isHaveProject];
    }
    else if ([classStr isEqualToString:@"PlaceAuditItemCellB"]) {
        PlaceAuditItemCellB *cell = (PlaceAuditItemCellB*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIModel:self.projectModel];
        cell.isExpendBlock = ^(BOOL isExpend) {
            weakself.tableV.contentOffset=CGPointMake(0, 0 );
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
    else if ([classStr isEqualToString:@"PlaceAuditCellC"]) {  //艺人信息
        PlaceAuditCellC *cell = (PlaceAuditCellC*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithInfo:self.info];
    }
    else if ([classStr isEqualToString:@"PlaceOrderCustomCell"])  //
    {
        OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceShotVCMCellData];
        PlaceOrderCustomCell *cell = (PlaceOrderCustomCell*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithModel:model];
        cell.BeginEdit = ^{
        };
    }
    else if ([classStr isEqualToString:@"ShotStepCellF"])  //拍摄类别
    {
        OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceShotVCMCellData];
        ShotStepCellF *cell = (ShotStepCellF*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithModel:model];
    }
    
    else if ([classStr isEqualToString:@"ShotStepCellA"])  //档期预约金
    {
        OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceShotVCMCellData];
        ShotStepCellA *cell = (ShotStepCellA*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithModel:model];
        cell.ShotStepCellABlock = ^{  //说明
            [weakself expainSchedule];
        };
    }
    
    else if ([classStr isEqualToString:@"PlaceAuditCellD"])  //保险
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
    NSString *classStr = [(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceShotVCMCellClass];
    WeakSelf(self);
    if ([classStr isEqualToString:@"PlaceAuditItemCellA"] || [classStr isEqualToString:@"PlaceAuditItemCellC"]) {
        if (self.isHaveProject==NO) {  //新建项目
            [self addProject];
        }
        else   //选择项目
        {
            ProjectChooseVC *chooseVC= [[ProjectChooseVC alloc]init];
            chooseVC.projectType=2;
            chooseVC.projectModel=self.projectModel;
            chooseVC.selectProjectModelBlock = ^(ProjectModel * _Nonnull projectModel) {
                weakself.projectModel=projectModel;
                [weakself.dataM addItemRefreshCell];
                [weakself calculateTotalPrice];
            };
            [self.navigationController pushViewController:chooseVC animated:YES];
        }
    }
 
    else if ([classStr isEqualToString:@"PlaceOrderCustomCell"])  //定妆场地
    {
        OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceShotVCMCellData];
        MakeupWayPopV *popV = [[MakeupWayPopV alloc]init];
        [popV showWithOrderM:model];
        popV.auditionWayChooseWithModel = ^(OrderStructM *OrderM) {
            model.content=OrderM.title;
            model.price=OrderM.price;
            model.type=OrderM.type;
            [weakself calculateTotalPrice];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
    else if ([classStr isEqualToString:@"ShotStepCellF"])  //拍摄类别
    {
        OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceShotVCMCellData];

        if (self.priceList.count>0) {
            UserLookPricePopV *popV = [[UserLookPricePopV alloc]init];
            [popV showOfferTypeWithPriceList:self.priceList withSelectDic:model.videoTypeDic[@"dic"] withDay:[model.videoTypeDic[@"day"]integerValue] withMastery:self.dataM.info.mastery withType:1];
            popV.typeSelectBlock = ^(NSDictionary * _Nonnull dic, NSInteger day) {
                model.videoTypeDic=@{@"dic":dic,@"day":@(day)};
                [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
                [weakself calculateTotalPrice];
            };
            popV.confrimActionBlock = ^(NSDictionary * _Nonnull dic, NSInteger day) {
                [weakself calculateTotalPrice];
            };
        }else{
            [SVProgressHUD showImage:nil status:@"暂无报价！"];
        }
    }
    else if ([classStr isEqualToString:@"ShotStepCellA"])  //档期预约金
    {
        if (self.projectModel.projectid.length==0) {
            [SVProgressHUD showImage:nil status:@"请添加拍摄项目"];
            return;
        }
        OrderStructM *model1 = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][1] objectForKey:kPlaceShotVCMCellData];  //定妆方式
        OrderStructM *model2 = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][2] objectForKey:kPlaceShotVCMCellData];  //下单类别
        
        if (model1.content.length==0) {
            [SVProgressHUD showImage:nil status:model1.placeholder];
            return;
        }
        if (model2.videoTypeDic==nil) {
            [SVProgressHUD showImage:nil status:model2.placeholder];
            return;
        }
        

        OrderStructM *model = (OrderStructM*)[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kPlaceShotVCMCellData];
        ScheduleWayPopV *popV = [[ScheduleWayPopV alloc]init];
        [popV showWithOrderM:model withPrice:self.orderPriceInfo[@"bailPrice"]];
        popV.auditionWayChooseWithModel = ^(OrderStructM *OrderM) {
            model.content=OrderM.title;
            model.price=OrderM.price;
            model.type=OrderM.type;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        popV.lookScheduleBlock = ^{
            [weakself expainSchedule];
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

//档期预约金页面
-(void)expainSchedule
{
    PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"档期预约金服务协议" url:@"http://www.idlook.com/public/appointment-money/index.html"];
    [self.navigationController pushViewController:webVC animated:YES];
}

//新建项目
-(void)addProject
{
    ProjectDetailVC *PDVC = [ProjectDetailVC new];
    PDVC.isAudition = YES;
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

//计算价格
-(void)calculateTotalPrice
{
    OrderStructM *model1 = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][1] objectForKey:kPlaceShotVCMCellData];  //定妆场地
    OrderStructM *model2 = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][2] objectForKey:kPlaceShotVCMCellData];  //拍摄类别
    
    if (self.projectModel.projectid.length==0) {
        return;
    }
    if (model1.content.length==0) {
        return;
    }
    if (model2.videoTypeDic==nil) {
        return;
    }
    
    NSDictionary *dic = model2.videoTypeDic[@"dic"];
    NSInteger day = [model2.videoTypeDic[@"day"]integerValue];
    
    NSArray *priceList = dic[@"priceList"];
    NSString *price = @"0";
    
    for (int i=0; i<priceList.count; i++) {
        NSDictionary *dicA = priceList[i];
        if ([dicA[@"days"]integerValue]==day) {
            price =dicA[@"actorPrice"];
        }
    }
    
    NSDictionary *dicA = @{@"advertType":dic[@"advertType"],@"days":@(day),@"price":price};
    NSDictionary *dicArg = @{@"actorId":self.dataM.info.UID,
                             @"userId":[UserInfoManager getUserUID],
                             @"itemList":@[dicA],
                             @"projectId":self.projectModel.projectid,
                             @"shotOrderType":
                                 @{@"shotOrderPrice":model1.price,@"shotOrderType":@(model1.type)}
                             };
    [AFWebAPI_JAVA calculateOrderPriceWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_body];
            self.orderPriceInfo=dic;
            NSDictionary *orderPriceDetail = (NSDictionary*)safeObjectForKey(dic, @"orderPriceDetail");
            [self.bottomV reloadUIWithTotalPrice:[dic[@"totalPrice"]integerValue] withSale:[orderPriceDetail[@"showFreePrice"]integerValue] withScore:[dic[@"points"]integerValue]];
//            [self getDayPrice];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}


//获取单天报价列表
-(void)getDayPrice
{
    OrderStructM *model1 = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][2] objectForKey:kPlaceShotVCMCellData];  //下单类别

    NSDictionary *dic = model1.videoTypeDic[@"dic"];   //类别相关信息
    NSInteger advertType = [dic[@"advertType"]integerValue];
    NSInteger singleType =[dic[@"singleType"]integerValue];
    
    NSDictionary *dicArg =@{@"userid":self.info.UID,
                            @"adtype":@(advertType),
                            @"addetailstype":@(singleType)};
    [AFWebAPI getQuotaDetailWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            NSDictionary *dic =[object objectForKey:JSON_data];
            NSArray *array = [dic objectForKey:@"day"];
            self.videoDayPriceLsit=array;
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

#pragma mark---
#pragma 下单
-(void)placeOrderAction
{
    OrderStructM *model1 = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][1] objectForKey:kPlaceShotVCMCellData];  //定妆方式
    OrderStructM *model2 = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][2] objectForKey:kPlaceShotVCMCellData];  //下单类别
    OrderStructM *model3 = (OrderStructM*)[(NSDictionary *)self.dataM.ds[1][3] objectForKey:kPlaceShotVCMCellData];  //锁档方式
    
    if (self.projectModel.projectid.length==0) {
        [SVProgressHUD showImage:nil status:@"请添加拍摄项目"];
        return;
    }
    
    if (model1.content.length==0) {
        [SVProgressHUD showImage:nil status:model1.placeholder];
        return;
    }
    if (model2.videoTypeDic==nil) {
        [SVProgressHUD showImage:nil status:model2.placeholder];
        return;
    }
    if (model3.content.length==0) {
        [SVProgressHUD showImage:nil status:@"请确认是否预约档期"];
        return;
    }
 
    NSInteger totalPrice=0;    //总价
    NSInteger makeupPrice=0;   //定妆费
    NSInteger showPrice=0;    //演出费
    NSInteger showFreePrice=0;  //演出费优惠
    NSInteger tax=0;         //税费
    NSInteger insuranceFee=0;  //保险费
    if (self.orderPriceInfo!=nil) {
        totalPrice=[self.orderPriceInfo[@"totalPrice"]integerValue];
        NSDictionary *orderPriceDetail = self.orderPriceInfo[@"orderPriceDetail"];
        makeupPrice=[orderPriceDetail[@"makeupPrice"]integerValue];
        showPrice=[orderPriceDetail[@"showPrice"]integerValue];
        showFreePrice=[orderPriceDetail[@"showFreePrice"]integerValue];
        tax=[orderPriceDetail[@"tax"]integerValue];
        insuranceFee=[orderPriceDetail[@"insuranceFee"]integerValue];
    }
    
    NSDictionary *dic = model2.videoTypeDic[@"dic"];   //类别相关信息
    NSInteger day = [model2.videoTypeDic[@"day"]integerValue];  //天数
    NSArray *priceList = dic[@"priceList"];
    NSInteger advertType = [dic[@"advertType"]integerValue];
//    NSInteger singleType =[dic[@"singleType"]integerValue];
    NSString *salePriceVip = @"0";
    
    NSString *advName = @"";
    for (int i=0; i<priceList.count; i++) {
        NSDictionary *dicA = priceList[i];
        if ([dicA[@"days"]integerValue]==day) {
            salePriceVip =dicA[@"salePriceVip"];
        }
    }
    
    if (advertType==1) {
        advName=@"视频";
    }
    else if (advertType==2)
    {
        advName=@"平面";
    }
    else if (advertType==4)
    {
        advName=@"套拍";
    }
    
    if (priceList.count<5) {
        [SVProgressHUD showImage:nil status:@"获取价格失败"];
        return;
    }
    NSDictionary *price1Dic = priceList[0];  //一天报价
    NSDictionary *price2Dic = priceList[1];  //两天报价
    NSDictionary *price3Dic = priceList[2];  //三天报价
    NSDictionary *price4Dic = priceList[3];  //四天报价
    NSDictionary *price5Dic = priceList[4];  //五天报价
    
    NSDictionary *dicA = @{@"userid":[UserInfoManager getUserUID],      //用户id
                          @"artistid":self.info.UID,                  //艺人id
                          @"ordertype":@(model1.type),                //定妆类型
                          @"quotedprice":salePriceVip,              //广告类别报价
                          @"shottype":advName,              //广告类别
                          @"projectid":self.projectModel.projectid,  //项目id
                          @"shootdays":@(day),            //天数
                          @"showprice":@(showPrice),           //演出费
                          @"freeprice":@(showFreePrice),           //演出费优惠
                          @"ordertypeprice":@(makeupPrice),            //预约意向金或者定妆各类型金额
                          @"totalprice":@(totalPrice),          //总价格
                          @"totalprofit":self.orderPriceInfo[@"totalCost"],        //资源方收到的总价格
                          @"onedayprice":price1Dic[@"salePrice"],        //一天报价
                          @"twodayprice":price2Dic[@"salePrice"],        //两天报价
                          @"threedayprice":price3Dic[@"salePrice"],      //三天报价
                          @"fourdayprice":price4Dic[@"salePrice"],       //四天报价
                          @"fivedayprice":price5Dic[@"salePrice"],       //五天报价
                          @"payterms":@(model3.type),                //锁档方式
                          };
    
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dicA];
    
    if (model3.type==1) {  //锁档支付
        [dicArg setObject:self.orderPriceInfo[@"bailPrice"] forKey:@"bailprice"];
    }

    WeakSelf(self);
    if ([UserInfoManager getUserSubType]!=3) {
        ShotNoticePopV *popV = [[ShotNoticePopV alloc]init];
        [popV showWithCountDown:self.downCount];
        popV.agreeAndPayBlock = ^{
            [weakself placeOrderServiceWithDic:dicArg];
        };
        popV.TimercountDownBlock = ^(NSInteger count) {
            weakself.downCount=count;
        };
    }
    else
    {
        [self placeOrderServiceWithDic:dicArg];
    }
}

-(void)placeOrderServiceWithDic:(NSDictionary*)dicArg
{
    [SVProgressHUD showWithStatus:@"正在下单，请稍后." maskType:SVProgressHUDMaskTypeClear];
    [AFWebAPI ProjectShotPlaceOrder:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"下单成功!"];
            NSDictionary *dic = [object objectForKey:JSON_data];
            NSArray *orderlist = (NSArray*)safeObjectForKey(dic, @"orderlist") ;
            if (orderlist.count) {
                [self getIntegralWithOrderId:[orderlist firstObject][@"orderid"]];
            }
            
            [self onGoback];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

//下单成功积分回掉
-(void)getIntegralWithOrderId:(NSString*)orderId
{
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID],
                             @"orderIdList":@[orderId]};
    [AFWebAPI_JAVA placeOrderIntegralBackWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

@end
