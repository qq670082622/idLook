//
//  PayWaysVC.m
//  IDLook
//
//  Created by HYH on 2018/7/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PayWaysVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "WXApi.h"
#import "payRequsestHandler.h"
#import "InsuranceBuySuccessVC.h"

#import "PayWayCell.h"

#define AP_SUBVIEW_XGAP   (20.0f)
#define AP_SUBVIEW_YGAP   (30.0f)
#define AP_SUBVIEW_WIDTH  (([UIScreen mainScreen].bounds.size.width) - 2*(AP_SUBVIEW_XGAP))

#define AP_BUTTON_HEIGHT  (60.0f)
#define AP_INFO_HEIGHT    (200.0f)

@interface PayWaysVC ()<UITableViewDelegate,UITableViewDataSource,WXApiDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,assign) BOOL hadPay;
@end

@implementation PayWaysVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选择支付方式"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    if ([WXApi isWXAppInstalled]) {  //是否安装微信
        self.dataSource = @[@{@"title":@"支付宝支付",@"desc":@"支付宝安全支付",@"image":@"payway_alipay"},
                           // @{@"title":@"微信支付",@"desc":@"微信安全支付",@"image":@"payway_wechat"}
                            ];
    }
    else
    {
        self.dataSource = @[@{@"title":@"支付宝支付",@"desc":@"支付宝安全支付",@"image":@"payway_alipay"}];
    }
    
    [self tableV];
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessBack) name:@"paySuccess" object:nil];
}

-(void)paySuccessBack
{
    if (_hadPay) {
        return;
    }
    if (_orderType==1) {//是保险
        [self createInsurance];
        return;
    }
    if (self.refreshData) {
        self.refreshData();
    }
    [self onGoback];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"paySuccess" object:nil];
}

-(void)initUI
{
    UIButton *payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setTitle:[NSString stringWithFormat:@"支付 ¥%ld 元",self.totalPrice] forState:UIControlStateNormal];
    payBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    payBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 6, 0, -6);
    payBtn.backgroundColor=Public_Red_Color;
    [self.view addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
}

-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.scrollEnabled=NO;
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

//支付
-(void)payAction
{
    PayWayCell *cell1=[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    PayWayCell *cell2=[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (cell1.selectBtn.selected==NO && cell2.selectBtn.selected==NO) {
        [
         SVProgressHUD showErrorWithStatus:@"请选择支付方式"];
        return;
    }
    
    if (cell1.selectBtn.selected==YES) {
        [self doAPPay];
    }
    else if(cell2.selectBtn.selected==YES)
    {
        [self wxPay];
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
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"PayWayCell";
    PayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[PayWayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        if (indexPath.row==0) {
            cell.selectBtn.selected=YES;
        }
    }
    [cell realoadUIWithDic:self.dataSource[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PayWayCell *cell1=[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    PayWayCell *cell2=[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (indexPath.row==0) {
        cell1.selectBtn.selected=YES;
        cell2.selectBtn.selected=NO;
    }
    else if (indexPath.row==1)
    {
        cell1.selectBtn.selected=NO;
        cell2.selectBtn.selected=YES;
    }

}

#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
// 选中商品调用支付宝极简支付
//
- (void)doAPPay
{
    WeakSelf(self);
    NSDictionary *dicArg = @{@"total_amount":@(self.totalPrice),//0.01
                             @"body":APP_NAME,
                             @"subject":APP_NAME,
                             @"payid":[UserInfoManager getUserUID],
                             @"orderids":self.orderids,
                             };
    
    [AFWebAPI aliPayWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            
            NSDictionary *dic = [object objectForKey:JSON_data];
            NSString *orderString = [dic objectForKey:@"payInfo"];
            
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = @"idlook";
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                NSString *resultStr = resultDic[@"result"];
                if ([resultStr containsString:@"Success"]) {
                    if (self.orderType==1) {
                        self.hadPay = YES;
                        [self createInsurance];
                    }
                }
//                if (_orderType==1) {
//                    [weakself createInsurance];
//                }
            }];
        }
        else
        {
//            InsuranceBuySuccessVC *successvc = [InsuranceBuySuccessVC new];
//            successvc.isSuccess = NO;
//            successvc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:successvc animated:YES];
            AF_SHOW_RESULT_ERROR
        }
    }];
}


#pragma mark -
#pragma mark   ==============微信支付==============
-(void)wxPay
{
    NSDictionary *dicArg = @{@"total_amount":@(1),  //1
                             @"body":APP_NAME,
                             @"orderids":self.orderids,
                             @"payid":[UserInfoManager getUserUID]
                             };
    [AFWebAPI wxPayWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_data];
            NSMutableString *stamp  = [dic objectForKey:@"timestamp"];
    
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dic objectForKey:@"partnerid"];
            req.prepayId            = [dic objectForKey:@"prepayid"];
            req.nonceStr            = [dic objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dic objectForKey:@"package"];
            req.sign                = [dic objectForKey:@"sign"];
            [WXApi sendReq:req];
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dic objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
          
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}
 //3___支付成功调java后端去平安生成保单
-(void)createInsurance
{
    [AFWebAPI_JAVA createInsuranceWithArg:_insuranceDic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"支付成功，稍后保单内容将发送到您手机!"];
            InsuranceBuySuccessVC *successvc = [InsuranceBuySuccessVC new];
            successvc.isSuccess = YES;
            successvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:successvc animated:YES];
            //                 [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}

@end