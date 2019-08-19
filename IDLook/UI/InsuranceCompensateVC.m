//
//  InsuranceCompensateVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsuranceCompensateVC.h"
#import "UseSelectPopView.h"
#import "DatePickPopV.h"

@interface InsuranceCompensateVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *insuranceNumber;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *reasonBtn;
- (IBAction)reasonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *accidentTimeBtn;
- (IBAction)accidentAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UILabel *remarkNum;
@property (weak, nonatomic) IBOutlet UILabel *remarkTip;
@property (weak, nonatomic) IBOutlet UILabel *name_phone;

@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
- (IBAction)applyAction:(id)sender;

@end

@implementation InsuranceCompensateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"申请理赔"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    self.applyBtn.layer.cornerRadius = 8;
    self.applyBtn.layer.borderColor = Public_Red_Color.CGColor;
    self.applyBtn.layer.borderWidth = 1;
    self.applyBtn.layer.masksToBounds = YES;
}
#pragma mark - textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length>499) {
        if (text.length==0) {//在删除
            return YES;
        }else if (text.length>0) //还想加字，不允许
        {
            return NO;
        }
    }
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>0)
    {
        self.remarkNum.hidden=YES;
    }
    else
    {
        self.remarkNum.hidden=NO;
    }
    self.remarkNum.text = [NSString stringWithFormat:@"%ld/200",textView.text.length];
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)reasonAction:(id)sender {
    WeakSelf(self);
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
    popv.dataSource = [NSArray arrayWithObjects:@"试试",@"驾驶证",@"居住证",@"军人证",@"退伍证",nil];
    popv.title = @"理赔原因";
    popv.selectStr = [_reasonBtn.titleLabel.text isEqualToString:@"请选择理赔原因"]?@"":_reasonBtn.titleLabel.text;
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
        [weakself.reasonBtn setTitle:string forState:0];
    };
}
- (IBAction)accidentAction:(id)sender {//出险时间
    NSDate *minimumDate = [NSDate date];
    NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
    DatePickPopV *popV = [[DatePickPopV alloc]init];
    [popV showWithMinDate:minimumDate maxDate:maximumDate];
    WeakSelf(self);
    popV.dateString = ^(NSString * _Nonnull str) {
        [weakself.accidentTimeBtn setTitle:str forState:0];
    };
}
- (IBAction)applyAction:(id)sender {
    if ([_accidentTimeBtn.titleLabel.text isEqualToString:@"请选择事发时间"] ||_accidentTimeBtn.titleLabel.text.length<2 ) {
        [SVProgressHUD showErrorWithStatus:@"请选择事发时间"];
        return;
    }
    if ([_reasonBtn.titleLabel.text isEqualToString:@"请选择理赔原因"] ||_reasonBtn.titleLabel.text.length<1 ) {
        [SVProgressHUD showErrorWithStatus:@"请选择理赔原因"];
        return;
    }
}
@end
