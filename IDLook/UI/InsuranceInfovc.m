//
//  InsuranceInfovc.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsuranceInfovc.h"
#import "UseSelectPopView.h"
#import "HotelCalendarViewController.h"
#import "NSCalendar+Ex.h"
#import "DatePickPopV.h"
#import "PayWaysVC.h"
#import "PublicPickerView.h"
#import "WebVC.h"
#import "InsuranceBuySuccessVC.h"
@interface InsuranceInfovc ()<HotelCalendarViewDelegate,HotelCalendarViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *cardBtn;
- (IBAction)cardAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *cardNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *jobBtn;
- (IBAction)jobAction:(id)sender;
@property(nonatomic,assign)NSInteger jobType;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
- (IBAction)timeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
- (IBAction)agreeAction:(id)sender;
- (IBAction)needKnow:(id)sender;
- (IBAction)insuranceTips:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *price;
- (IBAction)buy:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
- (IBAction)sexAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *birthView;
@property (weak, nonatomic) IBOutlet UIButton *birthBtn;
- (IBAction)birthAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *jobView;
@property (weak, nonatomic) IBOutlet UILabel *startTip;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property(nonatomic,assign)BOOL isAgree;

//@property(nonatomic,strong)NSMutableDictionary *insuranceInfo;
@end

@implementation InsuranceInfovc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];
    _isAgree = YES;
    if (_selectType==1) {
        _type.text = @"平安意外伤害保险 - 20万版";
        _price.text = @"￥10";
    }else{
        _type.text = @"平安意外伤害保险 - 30万版";
          _price.text = @"￥15";
    }
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"填写投保信息"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    self.sexView.hidden = YES;
    self.birthView.hidden = YES;
    self.phoneView.y = self.sexView.y;
    self.jobView.y = self.birthView.y;
    self.startTip.y = self.jobView.bottom+15;
    self.timeView.y = self.startTip.bottom+15;
}


- (IBAction)cardAction:(id)sender {
    [self resign];
    WeakSelf(self);
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
    popv.dataSource = [NSArray arrayWithObjects:@"身份证",@"护照",@"其他",nil];
    popv.title = @"证件类型";
    popv.selectStr = _cardBtn.titleLabel.text;
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
        [weakself.cardBtn setTitle:string forState:0];
        if ([string isEqualToString:@"身份证"]) {
            weakself.sexView.hidden = YES;
            weakself.birthView.hidden = YES;
            weakself.phoneView.y = weakself.sexView.y;
            weakself.jobView.y = weakself.birthView.y;
            weakself.startTip.y = weakself.jobView.bottom+15;
            weakself.timeView.y = weakself.startTip.bottom+15;
           }else if ([string isEqualToString:@"护照"]){
            weakself.sexView.hidden = NO;
            weakself.birthView.hidden = NO;
            weakself.phoneView.y = weakself.birthView.bottom;
            weakself.jobView.y = weakself.phoneView.bottom;
            weakself.startTip.y = weakself.jobView.bottom+15;
            weakself.timeView.y = weakself.startTip.bottom+15;
        }
         weakself.scroll.contentSize = CGSizeMake(UI_SCREEN_WIDTH, weakself.timeView.bottom+60);
    };
}
- (IBAction)jobAction:(id)sender {
    WeakSelf(self);
//    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
//    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
//    popv.dataSource = [NSArray arrayWithObjects:@"演员",@"制片",@"导演",@"场务",@"其他",nil];
//    popv.title = @"被保人职务";
//    popv.selectStr = [_jobBtn.titleLabel.text isEqualToString:@"请选择被保人职务"]?@"":_jobBtn.titleLabel.text;
//    [popv initSubviews];
//    popv.selectID = ^(NSString * _Nonnull string) {
//        [weakself.jobBtn setTitle:string forState:0];
//    };
     [self resign];
    PublicPickerView *pickerV = [[PublicPickerView alloc] init];
    pickerV.title=@"被保人职务";
    pickerV.didSelectBlock = ^(NSString *select) {
       [weakself.jobBtn setTitle:select forState:0];
        NSArray *jobs =  @[@"制作经理",@"制片",@"制作助理",@"导演",@"Free制片",@"采购人员",@"其他"];
        for(int i = 0;i<jobs.count;i++){
            NSString *jobStr = jobs[i];
            if ([jobStr isEqualToString:select]) {
                weakself.jobType = i+1;
            }
        }
    };
    [pickerV showWithPickerType:PickerTypePostion withDesc:_jobBtn.titleLabel.text];
}
- (IBAction)sexAction:(id)sender {
     [self resign];
    WeakSelf(self);
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
    popv.dataSource = [NSArray arrayWithObjects:@"男",@"女",nil];
    popv.title = @"选择性别";
    popv.selectStr = [_sexBtn.titleLabel.text isEqualToString:@"请选择性别"]?@"":_sexBtn.titleLabel.text;
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {
        [weakself.sexBtn setTitle:string forState:0];
    };
}
- (IBAction)birthAction:(id)sender {
     [self resign];
    NSDate *maximumDate = [NSDate date];
    NSString *dateString=@"1900-01-01";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSDate *minimumDate=[dateFormatter dateFromString:dateString];
    
    DatePickPopV *popV = [[DatePickPopV alloc]init];
    [popV showWithMinDate:minimumDate maxDate:maximumDate];
    WeakSelf(self);
    popV.dateString = ^(NSString * _Nonnull str) {
        [weakself.birthBtn setTitle:str forState:0];
    };
}
- (IBAction)timeAction:(id)sender {
     [self resign];
    HotelCalendarViewController *vc = [[HotelCalendarViewController alloc]init];
    vc.delegate = self;
    vc.dataSource = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:NO completion:nil];
}
- (IBAction)agreeAction:(id)sender {
     [self resign];
    if (_isAgree) {
        [_agreeBtn setImage:[UIImage imageNamed:@"insurance_buy_radio_n"] forState:0];
        _isAgree = NO;
    }else{
        [_agreeBtn setImage:[UIImage imageNamed:@"insurance_buy_radio_s"] forState:0];
        _isAgree = YES;
    }
}

- (IBAction)needKnow:(id)sender {
    //须知
    WebVC *wvc = [WebVC new];
    wvc.hidesBottomBarWhenPushed = YES;
    wvc.navTitle = @"保险须知";
    wvc.fileName = @"InsuranceTipsPDF";
    [self.navigationController pushViewController:wvc animated:YES];
}

- (IBAction)insuranceTips:(id)sender {
    //细则
    WebVC *wvc = [WebVC new];
    wvc.hidesBottomBarWhenPushed = YES;
    wvc.navTitle = @"保险条款";
    wvc.fileName = @"InsurancePDF";
    [self.navigationController pushViewController:wvc animated:YES];
}
- (IBAction)buy:(id)sender {
    if ([self.name.text isEqualToString:@"与证件姓名一致"]||self.name.text.length<2) {
        [SVProgressHUD showErrorWithStatus:@"请填写被保人姓名"];
        return;
    }
    
    if ([self.cardNumTextField.text isEqualToString:@"所持证件号码"]||self.cardNumTextField.text.length<2) {
        [SVProgressHUD showErrorWithStatus:@"请填写所持证件号码"];
        return;
    }
    if(![self cly_verifyIDCardString:self.cardNumTextField.text] && [_cardBtn.titleLabel.text isEqualToString:@"身份证"])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写正确的证件号码"];
        return;
    }
    if ([self.phoneNumTextField.text isEqualToString:@"用于接收电子保单"]||self.phoneNumTextField.text.length<2) {
        [SVProgressHUD showErrorWithStatus:@"请填写被保人电话"];
        return;
    }
    
    if ([self.jobBtn.titleLabel.text isEqualToString:@"请选择被保人职务"]||self.jobBtn.titleLabel.text.length<2) {
        [SVProgressHUD showErrorWithStatus:@"请填写被保人职务"];
        return;
    }
    
    if ([self.timeBtn.titleLabel.text isEqualToString:@"请选择开始日期"]||self.timeBtn.titleLabel.text.length<2) {
        [SVProgressHUD showErrorWithStatus:@"请选择保障起期"];
        return;
    }
    if ([_cardBtn.titleLabel.text isEqualToString:@"护照"]) {
        if ([self.sexBtn.titleLabel.text isEqualToString:@"请选择性别"]||self.sexBtn.titleLabel.text.length==0) {
            [SVProgressHUD showErrorWithStatus:@"请选择性别"];
            return;
        }
        if ([self.birthBtn.titleLabel.text isEqualToString:@"请选择生日"]||self.birthBtn.titleLabel.text.length<2) {
            [SVProgressHUD showErrorWithStatus:@"请选择生日"];
            return;
        }
    }
    if (!_isAgree) {
        [SVProgressHUD showErrorWithStatus:@"请同意《投保须知》和《保险条款》"];
        return;
    }

    NSDictionary *man;
    if ([_cardBtn.titleLabel.text isEqualToString:@"护照"]) {
        man = @{  //护照 需要性别和生日
                @"mobile":_phoneNumTextField.text,
                @"policyUserCertNo":_cardNumTextField.text,
                @"policyUserSex":@(1),  //1男 2女
                @"policyUserCertType":@(2),
                @"policyUserName":_name.text,
                @"policyUserBirthday":_birthBtn.titleLabel.text,
                 @"occupation":@(_jobType)
                };
    }else{
        man = @{
                @"mobile":_phoneNumTextField.text,
                @"policyUserCertNo":_cardNumTextField.text,
                @"policyUserCertType":@(1),
                @"policyUserName":_name.text,
                @"occupation":@(_jobType)
                };
    }
                     NSArray *userList = [NSArray arrayWithObject:man];
  
 
//    _insuranceInfo = [NSMutableDictionary new];
//    [_insuranceInfo addEntriesFromDictionary:dic];

    WeakSelf(self);
    NSDictionary *orderNumDic = @{
                                  @"idType":@(0)
                                  };
    //1___先拿到订单号
    [AFWebAPI_JAVA createOrderNumWithArg:orderNumDic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
           NSString *insuranceNum = [object objectForKey:JSON_body][@"id"];
            NSDictionary *dic = @{  @"orderId":insuranceNum,
                                    @"channel":@(1),
                                    @"effectiveTime":self.timeBtn.titleLabel.text,
                                    @"mobile":self.phoneNumTextField.text,
                                    @"planType":self.selectType==1?@(0):@(1),
                                    @"userId":@([[UserInfoManager getUserUID] integerValue]),
                                    @"userList":userList
                                       };
               //2___去支付宝支付
            PayWaysVC *pvc = [PayWaysVC new];
                        pvc.orderids = insuranceNum;
                        pvc.totalPrice = _selectType==1?10:15;
            pvc.insuranceDic = dic;
            pvc.orderType = 1;
                       pvc.hidesBottomBarWhenPushed = YES;
            pvc.insuranceSuccess = ^{
                };
                        [self.navigationController pushViewController:pvc animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    } ];
    
}

#pragma mark - HotelCalendarViewDataSource
- (NSDate *)minimumDateForHotelCalendar {
    NSDate *nowDate = [NSDate new];
    NSDate *lastDate = nowDate;//[NSDate dateWithTimeInterval:-24 * 60 * 60 sinceDate:nowDate];
    return lastDate;
}

- (NSDate *)maximumDateForHotelCalendar {
    return [NSCalendar date:[NSDate new] addMonth:2];
}

- (NSDate *)defaultSelectFromDate {//初始开始是哪一天
    NSDate *nowDate = [NSDate new];
    return [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:nowDate];//[NSDate new];
}
//改初始化持续天数 改selectCollection代码两处
- (NSDate *)defaultSelectToDate {//初始结束是哪一天 一共多少天
    NSDate *nowDate = [NSDate new];
    
    NSDate *nextDate = [NSDate dateWithTimeInterval:24 * 60 * 60*9 sinceDate:[NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:nowDate]];
    return nextDate;
}

#pragma mark - HotelCalendarViewDelegate
- (NSInteger)rangeDaysForHotelCalendar {
    return 365;
}

- (void)selectNSStringFromDate:(NSString *)fromDate toDate:(NSString *)toDate {
    if (!fromDate) {
        NSLog(@"未完成日期选择");
        return;
    }
    NSLog(@"fromDate: %@, toDate: %@", fromDate, toDate);
    self.timeLabel.text = [NSString stringWithFormat:@"保险期间：%@ 至 %@",fromDate,toDate];
    [self.timeBtn setTitle:fromDate forState:0];
}

- (NSInteger)itemWidthForHotelCalendar{
    return 50;
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)cly_verifyIDCardString:(NSString *)idCardString {
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:idCardString];
    if (!isRe) {
        //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [idCardString substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [idCardString.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resign];
    return YES;
}
-(void)tap
{
    [self.name resignFirstResponder];
    [self.cardNumTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
}
-(void)resign
{
    [self.name resignFirstResponder];
    [self.cardNumTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
}
@end
