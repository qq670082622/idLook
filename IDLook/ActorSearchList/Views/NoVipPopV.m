//
//  NoVipPopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "NoVipPopV.h"
@interface NoVipPopV()
@property (nonatomic,strong)UIView *maskV;
@end
@implementation NoVipPopV
- (id)init
{
    if(self=[super init])
    {
      self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake((UI_SCREEN_WIDTH-280)/2, -UI_SCREEN_HEIGHT, 280,353);
    }
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
    [self initUI];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.15];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake((UI_SCREEN_WIDTH-280)/2, 180, 280,353);
    
    [UIView commitAnimations];
}

- (void)initUI
{
    UIImageView *img = [UIImageView new];
    img.frame = CGRectMake(0, 0, 280, 353);
    img.image = [UIImage imageNamed:@"search_popup_vip_bg"];
    [self addSubview:img];
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 6;
    backView.layer.masksToBounds = YES;
    backView.frame = CGRectMake(10, 120, 260, 105);
    [self addSubview:backView];
    
    UILabel *tip = [UILabel new];
    tip.text = @"亲爱的用户，您要查看的内容为VIP 专享。您可联系脸探客服了解具体 明细。";
    tip.backgroundColor = [UIColor whiteColor];
    tip.layer.cornerRadius = 8;
    tip.numberOfLines = 0;
    tip.textColor = Public_Text_Color;
    tip.font = [UIFont systemFontOfSize:15];
    tip.layer.masksToBounds = YES;
    tip.frame = CGRectMake(24, 120, 233, 105);
    [self addSubview:tip];
    
  
    UIButton *contacrBtn = [UIButton buttonWithType:0];
    contacrBtn.frame = CGRectMake(20, 250, 240, 45);
    [contacrBtn setBackgroundImage:[UIImage imageNamed:@"search_popup_vip_btn"] forState:0];
    [contacrBtn setTitle:@"立即联系客服" forState:0];
    [contacrBtn setTitleColor:[UIColor whiteColor] forState:0];
    contacrBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [contacrBtn addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contacrBtn];
    
    UIButton *refuseBtn = [UIButton buttonWithType:0];
    refuseBtn.frame = CGRectMake(90, 310, 100, 23);
    [refuseBtn setTitleColor:[UIColor colorWithHexString:@"#444045"] forState:0];
    [refuseBtn setTitle:@"继续逛逛" forState:0];
    refuseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    refuseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [refuseBtn addTarget:self action:@selector(refuse) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:refuseBtn];
}
-(void)contact
{
    self.selectType(@"contact");
    [self hide];
}
-(void)refuse
{
     self.selectType(@"refuse");
     [self hide];
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    //   [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    [self.maskV removeFromSuperview];
  
    [self removeFromSuperview];
    [UIView commitAnimations];
}
@end
