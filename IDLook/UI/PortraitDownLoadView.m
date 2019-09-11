//
//  PortraitDownLoadView.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "PortraitDownLoadView.h"

@interface PortraitDownLoadView()<UITextFieldDelegate>
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
- (IBAction)cancelAction:(id)sender;
- (IBAction)ensure:(id)sender;
@property(nonatomic,strong) UIButton *closeBtn;
@end
@implementation PortraitDownLoadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PortraitDownLoadView" owner:nil options:nil] lastObject];
    }
    Vheight = self.height;
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.borderColor = Public_Red_Color.CGColor;
    self.cancelBtn.layer.borderWidth = 0.5;
    self.cancelBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
    return self;
}
-(void)show
{
    UIWindow *showWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    if(!showWindow)return;
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    [showWindow addSubview:self];
    self.maskV=maskV;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.alpha = 1.f;
   
    self.frame = CGRectMake((UI_SCREEN_WIDTH-280)/2, 200, 280,250);
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    closeBtm.frame = CGRectMake((UI_SCREEN_WIDTH-34)/2, self.bottom+25, 34, 34);
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    closeBtm.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
    [showWindow addSubview:closeBtm];
    self.closeBtn = closeBtm;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    [UIView commitAnimations];
}

- (IBAction)cancelAction:(id)sender {
    [self hide];
}

- (IBAction)ensure:(id)sender {
    if (_emailField.text.length<8 || ![_emailField.text containsString:@"@"]) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写email"];
        return;
    }
    self.download(_emailField.text);
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    self.maskV.alpha = 0.f;
    [self.maskV removeFromSuperview];
    [self.closeBtn removeFromSuperview];
    [self removeFromSuperview];
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
