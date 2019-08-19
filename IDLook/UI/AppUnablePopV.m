//
//  AppUnablePopV.m
//  IDLook
//
//  Created by HYH on 2018/9/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AppUnablePopV.h"

@implementation AppUnablePopV

- (void)show
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

    [showWindow addSubview:maskV];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    UIImage *image = [UIImage imageNamed:@"upgrade_bg"];
    UIImageView *bg = [[UIImageView alloc]init];
    bg.image=image;
    [maskV addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(maskV);
        make.centerY.mas_equalTo(maskV);
        make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
    }];
    
    MLLabel *desc = [[MLLabel alloc]init];
    desc.font=[UIFont systemFontOfSize:13.0];
    desc.numberOfLines=0;
    desc.lineSpacing=5.0;
    desc.textColor=[[UIColor colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.8];
    desc.textAlignment=NSTextAlignmentCenter;
    desc.text=@"为了让您有更好的使用体验，我们正在对APP进行升级，升级期间APP将无法使用。给您带来的不便，敬请谅解。";
    [maskV addSubview:desc];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(maskV);
        make.left.mas_equalTo(bg).offset(23);
        make.bottom.mas_equalTo(bg).offset(-70);
//        make.height.mas_equalTo(70);
    }];
    
    maskV.alpha = 1.f;
    
    [UIView commitAnimations];
}

@end
