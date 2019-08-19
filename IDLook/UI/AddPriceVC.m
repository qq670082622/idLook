//
//  AddPriceVC.m
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddPriceVC.h"
#import "AddPriceSubA.h"
#import "AddPriceSubB.h"
#import "AddPriceSubC.h"

#import "AddPriceFootV.h"
#import "OrderCategoryPopV.h"
#import "PricePreviewPopV.h"
#import "SinglePricePopV.h"
#import "AddPriceManger.h"
#import "PreviewSubVA.h"
#import "AddPriceSubV.h"
#import "AdvertTypeSelectPopV.h"
@interface AddPriceVC ()<UIScrollViewDelegate>
@property(nonatomic,assign)NSInteger advType;
@property(nonatomic,assign)NSInteger advSubType;
@property(nonatomic,strong)AddPriceManger *dsm;
@property(nonatomic,strong)UIScrollView *scrollV;
@property(nonatomic,strong)UIButton *lookPriceBtn;
@property(nonatomic,strong)UIButton *getPriceBtn;
@property(nonatomic,assign)BOOL modifyPrice;
@end

@implementation AddPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    if (self.type==AddPriceTypeAdd) {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"新增报价"]];
    }
    else
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改报价"]];
        [self getPriceDetial];
    }
    
    self.advType=self.model.advertType;
    self.advSubType=self.model.advertType;
    
    [self dsm];
    
    [self scrollV];
    
    [self initUI];
    
    [self initScrollView];

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//获取报价详情
-(void)getPriceDetial
{
//     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//    NSDictionary *dicArg =@{@"userid":[UserInfoManager getUserUID],
//                            @"adtype":@(self.model.type),
//                            @"addetailstype":@(self.model.subType)};
//    [AFWebAPI getQuotaDetailWithArg:dicArg callBack:^(BOOL success, id object) {
//        if (success) {
//            [SVProgressHUD dismiss];
//            NSDictionary *dic =[object objectForKey:JSON_data];
//            NSArray *array = [dic objectForKey:@"day"];
//            [self.dsm changeShotDayPriceWithArray:array];
//        }
//        else
//        {
//            AF_SHOW_RESULT_ERROR
//        }
//    }];
    [self.dsm changeShotDayPriceWithPriceList:_priceArray];
}

//预览报价
-(void)looPriceAction
{
    AddPriceSubA *cellA = [self.scrollV viewWithTag:100];
 AddPriceSubA *cellB = [self.scrollV viewWithTag:101];
    if (cellA.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请选择广告类别!"];
        return;
    }
    if (cellB.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请输入单项报价!"];
        return;
    }
    PricePreviewPopV *popV=[[PricePreviewPopV alloc]init];
    popV.dsm=self.dsm;
    [popV showWithTitle:cellA.textField.text];
    WeakSelf(self);
    popV.getPriceBlock = ^{
        [weakself getPriceAction];
    };
}

//生成报价
-(void)getPriceAction
{
    AddPriceSubA *cellA = [self.scrollV viewWithTag:100];
    AddPriceSubA *cellB = [self.scrollV viewWithTag:101];

    if (cellA.textField.text.length==0 || cellB.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请将广告类别或报价填写完整！"];
        return;
    }
//    {
//        addetailstype = 2;
//        adtype = 2;
//        dayfive = 9250;
//        dayfour = 7750;
//        dayone = 2500;
//        daythree = 6125;
//        daytwo = 4375;
//        singleprice = 2500;
//        userid = 2271;
//    }
    
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableDictionary *dicJava = [NSMutableDictionary new];
    [dicJava setObject:@([[UserInfoManager getUserUID]integerValue]) forKey:@"userId"];
     [dicJava setObject:@(_advType) forKey:@"advertType"];
    NSMutableArray *pricelist = [NSMutableArray new];
   
    [dicArg setObject:[UserInfoManager getUserUID] forKey:@"userid"];
    [dicArg setObject:cellB.textField.text forKey:@"singleprice"];

    NSArray *array = [self.dsm.ds firstObject];
    for (int i =0; i<array.count; i++) {
        AddPriceModel *model =array[i];
        [dicArg setObject:@(model.price) forKey:model.eng];
        if (i==0) {
             [dicJava setObject:@(model.price) forKey:@"actorSalePrice"];
        }
        
        NSDictionary *singlePrice = @{
                                      @"days":@(i+1),
                                      @"price":@(model.price)
                                      };
        [pricelist addObject:singlePrice];
    }
           [dicJava setObject:pricelist forKey:@"priceInfoList"];
    
    if (self.type==AddPriceTypeAdd) {  //新增
          [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        if ([UserInfoManager getIsJavaService]) {//java后台
            [AFWebAPI_JAVA modifyQuotaWithArg:dicJava callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    [SVProgressHUD dismiss];
                    [self onGoback];
                    self.addPriceBlock();
                }else{
                    [SVProgressHUD showErrorWithStatus:object];
                }
            }];
        }else{
        
        [dicArg setObject:@(self.advType) forKey:@"adtype"];
        [dicArg setObject:@(self.advSubType) forKey:@"addetailstype"];
        
       
        [AFWebAPI addNewQuotaWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD dismiss];
                [self onGoback];
                self.addPriceBlock();
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
        }
    }
    else  //修改
    {
        //先判断是否没有修改任何报价而点击修改报价
      
        if (_modifyPrice == NO) {
             [SVProgressHUD showImage:nil status:@"报价未修改，无法保存！"];
            return;
        }
         [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        if ([UserInfoManager getIsJavaService]) {//java后台
            [AFWebAPI_JAVA modifyQuotaWithArg:dicJava callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    [SVProgressHUD dismiss];
                    [self onGoback];
                    self.addPriceBlock();
                }else{
                    [SVProgressHUD showErrorWithStatus:object];
                }
            }];
        }else{
        [dicArg setObject:@(self.model.creativeid) forKey:@"creativeid"];
        
        
        [AFWebAPI modifyQuotaWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD dismiss];
                [self onGoback];
                self.addPriceBlock();
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
        }
    }
}


-(void)initUI
{
    UIButton *lookPriceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [lookPriceBtn setTitle:@"预览报价" forState:UIControlStateNormal];
    lookPriceBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    lookPriceBtn.backgroundColor=[UIColor colorWithHexString:@"#FE7A62"];
    [self.view addSubview:lookPriceBtn];
    self.lookPriceBtn = lookPriceBtn;
    [lookPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(UI_SCREEN_WIDTH/2);
        make.height.mas_equalTo(50);
    }];
    [lookPriceBtn addTarget:self action:@selector(looPriceAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *getPriceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [getPriceBtn setTitle:@"生成报价" forState:UIControlStateNormal];
    getPriceBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    getPriceBtn.backgroundColor=Public_Red_Color;
    [self.view addSubview:getPriceBtn];
    self.getPriceBtn = getPriceBtn;
    [getPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(UI_SCREEN_WIDTH/2);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [getPriceBtn addTarget:self action:@selector(getPriceAction) forControlEvents:UIControlEventTouchUpInside];
}

-(AddPriceManger*)dsm
{
    if (!_dsm) {
        _dsm=[[AddPriceManger alloc]init];
          NSDictionary *firstDic =  [self.model.detailInfoList firstObject];
        if (_model.examineState==12){//修改审核时再修改
          
            [_dsm refreshPriceInfoWithSinglePrice:[firstDic[@"examPrice"] integerValue] andAdverType:_advType];
           }else{//正常情况下来修改
          [_dsm refreshPriceInfoWithSinglePrice:[firstDic[@"actorPrice"] integerValue] andAdverType:_advType];
            
        }

     //   [_dsm refreshPriceInfoWithSinglePrice:self.model.waitPrice];
        WeakSelf(self);
        _dsm.newDataNeedRefreshed = ^{
            [weakself reloadScrollViewData];
        };
    }
    return _dsm;
}

-(UIScrollView*)scrollV
{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-50-SafeAreaTopHeight)];
        _scrollV.delegate = self;
        _scrollV.pagingEnabled=NO;
        _scrollV.scrollEnabled = YES;
        _scrollV.backgroundColor = [UIColor clearColor];
        _scrollV.showsHorizontalScrollIndicator = YES;
        _scrollV.showsVerticalScrollIndicator = YES;
        [self.view addSubview:_scrollV];
    }
    return _scrollV;
}

-(void)initScrollView
{
    self.scrollV.contentSize=CGSizeMake(0, 190*4+48*2+130);

    AddPriceSubA *cellA  = [[AddPriceSubA alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
    cellA.backgroundColor=[UIColor whiteColor];
    cellA.tag=100;
    cellA.userInteractionEnabled=YES;
    [self.scrollV addSubview:cellA];
    [cellA reloadUIWithType:self.type withTtile:self.model.title];
    UITapGestureRecognizer *tapA=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAdvType)];
    [cellA addGestureRecognizer:tapA];
    
    AddPriceSubB *cellB  = [[AddPriceSubB alloc]initWithFrame:CGRectMake(0,48, UI_SCREEN_WIDTH, 64)];//74 - 58
     [cellB reloadUIWithChange:YES];
    CGFloat nextHeight = 122;
    BOOL ischange = YES;
    NSDictionary *priceDic = _priceArray[0];
    NSInteger examPrice = [[priceDic objectForKey:@"examPrice"]integerValue];
     NSInteger price = [[priceDic objectForKey:@"actorPrice"]integerValue];
  if (_model.examineState==11) {//增加审核中
      cellB.tipsLab.text = [NSString stringWithFormat:@"您新增的报价为¥%ld/天，正在审核中。",examPrice];
        cellB.textField.hidden = YES;
        cellB.descLab.hidden = YES;
    }else if (_model.examineState==12){//修改审核
      
        cellB.tipsLab.text = [NSString stringWithFormat:@"您修改后的报价为¥%ld/天，正在审核中。",examPrice];
        
    }else if (_model.status==1){//删除审核
        cellB.tipsLab.text = [NSString stringWithFormat:@"删除正在审核中。"];
    }else{//正常
        ischange = NO;
        cellB.frame = CGRectMake(0, 48, UI_SCREEN_WIDTH, 48);
        nextHeight = 106;
    }
    
    cellB.backgroundColor=[UIColor whiteColor];
    cellB.tag=101;
    cellB.userInteractionEnabled=YES;
    [self.scrollV addSubview:cellB];
    [cellB reloadUIWithChange:ischange];
    UITapGestureRecognizer *tapB=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inputPrice)];
    [cellB addGestureRecognizer:tapB];
    
//    if (self.type==AddPriceTypeModify) {
//        cellB.textField.text=[NSString stringWithFormat:@"%ld",self.model.price];
//    }
    if (_model.examineState==12){//修改审核时再修改
        
        cellB.textField.text=[NSString stringWithFormat:@"%ld",examPrice];
        
    }else{//正常情况下来修改
        
        cellB.textField.text=[NSString stringWithFormat:@"%ld",(long)price];
        
        
    }
    
    
    NSArray *titleArray=self.dsm.titleArray;
    
    for (int i=0; i<self.dsm.ds.count; i++) {
        NSArray *array = self.dsm.ds[i];
        AddPriceSubC *subV=[[AddPriceSubC alloc]initWithFrame:CGRectMake(0,nextHeight+10+190*i,UI_SCREEN_WIDTH,180)];
        subV.tag=1000+i;
        [subV reloadUIWithArray:array withType:i withTitle:titleArray[i]];
      
        subV.backgroundColor=[UIColor whiteColor];
        [self.scrollV addSubview:subV];
        WeakSelf(self);
        subV.clickPriceWithTag = ^(NSInteger tag) {
            [weakself editPriceWithTag:tag];
        };
    }
    
    AddPriceFootV *footV = [[AddPriceFootV alloc]initWithFrame:CGRectMake(0, 96+190*self.dsm.ds.count, UI_SCREEN_WIDTH, 130)];
    [self.scrollV addSubview:footV];
    [footV reloadUI];
}

//编辑天数报价
-(void)editPriceWithTag:(NSInteger)tag
{
    
    AddPriceSubA *cellA = [self.scrollV viewWithTag:100];
    AddPriceSubB *cellB = [self.scrollV viewWithTag:101];
    
    if (cellA.textField.text.length==0 || cellB.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请将广告类别或报价填写完整！"];
        return;
    }
    
    NSArray *array = [self.dsm.ds firstObject];
    AddPriceModel *model =array[tag];
    
    NSDictionary *dic = [UserInfoManager getPublicConfig];
    CGFloat min;
    CGFloat max;
    if (_advType!=4) {
         min = [dic[@"dayPriceLimit"][@"low"] floatValue];
         max = [dic[@"dayPriceLimit"][@"hig"] floatValue];
    }else{
         min = [dic[@"comboDayPriceLimit"][@"low"] floatValue];
         max = [dic[@"comboDayPriceLimit"][@"hig"] floatValue];
    }
    
    CGFloat price1 = roundf([cellB.textField.text floatValue]*(1+min*tag));
    CGFloat price2 = roundf([cellB.textField.text floatValue]*(1+max*tag));
    SinglePricePopV *popV = [[SinglePricePopV alloc]init];
    
    [popV showWithPrice:[NSString stringWithFormat:@"%ld",model.price] withMinPrice:price1 withMaxPrice:price2 withEditType:EditPricePopTypeModify];
    WeakSelf(self);
    popV.confirmBlock = ^(NSString *content) {
        CGFloat price =[content floatValue];
        [weakself.dsm changePriceWithTag:tag withPrice:price];
        weakself.modifyPrice = YES;
    };
}

#pragma mark ----Action
//选择广告类别
-(void)selectAdvType
{
    if (self.type==AddPriceTypeAdd)
    {
    __block  AddPriceSubA *cell = [self.scrollV viewWithTag:100];
        WeakSelf(self);
//        OrderCategoryPopV *popV= [[OrderCategoryPopV alloc]init];
//        popV.typeSelectAction = ^(NSString *content,NSInteger advType,NSInteger advSubType) {
//            cell.textField.text=content;
//            weakself.advType = advType;
//            weakself.advSubType=advSubType;
//            NSLog(@"--%@--%ld--%ld",content,advType,advSubType);
//        };
//        NSArray  *array = [NSArray array];
//        if (cell.textField.text.length) {
//            array=[NSArray arrayWithObject:@(self.advSubType)];
//        }
//
//        [popV showWithType:OrderCheckTypeShotType withSelect:array withMultiSel:NO withEnableArray:self.existArray];
        AdvertTypeSelectPopV *popV = [[AdvertTypeSelectPopV alloc] init];
        popV.typeSelectAction = ^(NSInteger advSubType) {
            weakself.advType = advSubType;
            weakself.advSubType=advSubType;
            if (advSubType==1) {
                 cell.textField.text=@"视频";
            }else if (advSubType==2) {
                cell.textField.text=@"平面";
            }else{
                 cell.textField.text=@"套拍";
                weakself.advType = 4;
                weakself.advSubType=4;
            }
        
        };
//        NSArray  *array = [NSArray array];
//                if (cell.textField.text.length) {
//                    array=[NSArray arrayWithObject:@(self.advSubType)];
//                }
      //  [popV showWithType:OrderCheckTypeShotType withSelect:array withMultiSel:NO withEnableArray:self.existArray];
        [popV showWithSelect:_advSubType withMultiSel:NO withEnableArray:self.existArray];
    }
}

//输入报价
-(void)inputPrice
{
    AddPriceSubA *cellA = [self.scrollV viewWithTag:100];
    if (cellA.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请先选择广告类别!"];
        return;
    }
    
    NSArray *array=[PublicManager getOrderCellType:OrderCheckTypeShotType];
    NSDictionary *dic;
    if (_advType == 4) {
      dic = [array lastObject];
    }else  if (_advType == 2){
    dic = array[1];
    }else{
        dic = array[0];
    }
    NSArray *arr1 = dic[@"data"];
    NSDictionary *dic1 = arr1[0];
//    for (int i=0; i<arr1.count; i++) {
//        NSDictionary *dicA = arr1[i];
//        if (self.advSubType == [dicA[@"attrid"] integerValue]) {
//            dic1 = dicA;
//        }
//    }
    
    
    AddPriceSubB *cellB = [self.scrollV viewWithTag:101];
    SinglePricePopV *popV = [[SinglePricePopV alloc]init];
    [popV showWithPrice:cellB.textField.text withMinPrice:[dic1[@"range1"] floatValue] withMaxPrice:[dic1[@"range2"] floatValue] withEditType:EditPricePopTypeSingle];
    [popV.textField becomeFirstResponder];
    WeakSelf(self);
    popV.confirmBlock = ^(NSString *content) {
        cellB.textField.text=[NSString stringWithFormat:@"%ld",[content integerValue]];
        NSInteger price =[content integerValue];
        [weakself.dsm refreshPriceInfoWithSinglePrice:price andAdverType:_advType];
         weakself.modifyPrice = YES;
    };
}

#pragma mark --刷新数据
-(void)reloadScrollViewData
{
     for (int i=0; i<self.dsm.ds.count; i++) {
         AddPriceSubC *subV = [self.scrollV viewWithTag:1000+i];
         NSArray *array = self.dsm.ds[i];
         
         [subV refreshDataWithArray:array withType:i];
     }
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    [self.lookPriceBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-34);
    }];
    [self.getPriceBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-34);
    }];
    self.scrollV.height -= 34;
}
@end
