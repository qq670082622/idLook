//
//  MassesOrderViewController.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/1.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MassesOrderViewController.h"
#import "DatePickPopV.h"
static NSString  *const dayAddEnable = @"dayAddEnable";
static NSString  *const dayAddUnable = @"dayAddUnable";
static NSString  *const dayMinusAnable = @"dayMinusAnable";
static NSString  *const dayMinusUnable = @"dayMinusUnable";
@interface MassesOrderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectType;
@property (weak, nonatomic) IBOutlet UILabel *singlePriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *dayMinusBtn;
- (IBAction)dayMinus:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dayAddBtn;
- (IBAction)dayAddAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *day;
- (IBAction)timeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *requireField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *contactField;
- (IBAction)callAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
- (IBAction)ensure:(id)sender;
@property(nonatomic,assign)NSInteger days;
@end

@implementation MassesOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"确认订单"]];
    self.days = 1;
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %ld",_singlePrice]];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]} range:NSMakeRange(0,attStr.length)];
    [self.self.singlePriceLabel setAttributedText:attStr];
    self.totalPrice.text = [NSString stringWithFormat:@"¥ %ld",_singlePrice];
   
}
- (IBAction)dayMinus:(id)sender {
    self.days--;
    self.day.text = [NSString stringWithFormat:@"%ld",(long)_days];
    if (_days==1) {
        [self.dayMinusBtn setImage:[UIImage imageNamed:dayMinusUnable] forState:0];
        self.dayMinusBtn.userInteractionEnabled = NO;
    }
     self.totalPrice.text = [NSString stringWithFormat:@"¥ %ld",_singlePrice*_days];
}
- (IBAction)dayAddAction:(id)sender {
    self.days++;
     self.day.text = [NSString stringWithFormat:@"%ld",(long)_days];
    [self.dayMinusBtn setImage:[UIImage imageNamed:dayMinusAnable] forState:0];
    self.dayMinusBtn.userInteractionEnabled = YES;
      self.totalPrice.text = [NSString stringWithFormat:@"¥ %ld",_singlePrice*_days];
}
- (IBAction)timeAction:(id)sender {
    NSDate *minimumDate = [NSDate date];
    NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
    DatePickPopV *popV = [[DatePickPopV alloc]init];
    [popV showWithMinDate:minimumDate maxDate:maximumDate];
    WeakSelf(self);
    popV.dateString = ^(NSString * _Nonnull str) {
        weakself.timeLabel.text = str;
    };
    
}
- (IBAction)callAction:(id)sender {//联系电话
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:400-833-6969"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (IBAction)ensure:(id)sender {//确定下单
   
}
- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
