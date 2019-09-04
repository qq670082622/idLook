//
//  UnAuthLookCountView.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/30.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "UnAuthLookCountView.h"
@interface UnAuthLookCountView()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)authAction:(id)sender;
- (IBAction)lookPrice:(id)sender;

@end
@implementation UnAuthLookCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"UnAuthLookCountView" owner:nil options:nil] lastObject];
    }
    Vheight = self.height;
    return self;
}

-(void)showWithString:(NSString *)tipStr andCanLook:(BOOL)canLook
{
    self.label.text = tipStr;
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
    CGFloat hei = canLook?Vheight:Vheight-48;
    self.frame = CGRectMake((UI_SCREEN_WIDTH-280)/2, 200, 280,hei);
    self.y = 200;//UI_SCREEN_HEIGHT-Vheight/2;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    [UIView commitAnimations];
}
- (IBAction)authAction:(id)sender {
    [self hide];
    self.actionType(@"认证");
}

- (IBAction)lookPrice:(id)sender {
    [self hide];
    self.actionType(@"查看价格");
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    //   [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    self.alpha = 0;
    [UIView commitAnimations];
}
@end
