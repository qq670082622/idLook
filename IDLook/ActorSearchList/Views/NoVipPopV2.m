//
//  NoVipPopV2.m
//  IDLook
//
//  Created by 吴铭 on 2019/10/11.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "NoVipPopV2.h"
#import "VipApplyView.h"
@interface NoVipPopV2()
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)UIButton *closeBtn;
@end
@implementation NoVipPopV2
- (id)init
{
    if(self=[super init])
    {
      self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake((UI_SCREEN_WIDTH-280)/2, -UI_SCREEN_HEIGHT, 280,549);
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
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
       [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    closeBtm.frame = CGRectMake((280-34)/2, 515, 34, 34);
       [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [self addSubview:closeBtm];
    self.closeBtn = closeBtm;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.15];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake((UI_SCREEN_WIDTH-280)/2, 50, 280,549);
    
    [UIView commitAnimations];
}

- (void)initUI
{
    WeakSelf(self);
    VipApplyView *av = [[VipApplyView alloc] initWithFrame:CGRectMake(0, 0, 280, 495)];
    [self addSubview:av];
    av.reply = ^(NSString * _Nonnull name, NSString * _Nonnull phone, NSString * _Nonnull remark) {
       // weakself.apply(name, phone, remark);
        NSDictionary *arg = @{
            @"mobile": name,
            @"name": phone,
            @"remark": remark,
            @"userId":@([[UserInfoManager getUserUID] integerValue])
        };
        [AFWebAPI_JAVA applyEBusinessVipWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                [SVProgressHUD showImage:nil status:@"已经提交申请"];
            }else{
                [SVProgressHUD showErrorWithStatus:object];
            }
        }];
        [weakself hide];
    };
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
    [self.closeBtn removeFromSuperview];
    [self removeFromSuperview];
    [UIView commitAnimations];
}

@end
