//
//  ApplyInvoicePopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ApplyInvoicePopV.h"

@implementation ApplyInvoicePopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)show
{
    
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    
    if(!showWindow)return;
    [showWindow addSubview:self];
    self.frame = showWindow.frame;
    self.hidden = NO;
    
    UIView *bg = [UIView new];
    bg.backgroundColor = [UIColor whiteColor];
    bg.layer.cornerRadius = 8;
    bg.layer.masksToBounds = YES;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(280, 200));
    }];
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"申请开票";
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = Public_Text_Color;
    title.textAlignment = NSTextAlignmentCenter;
    [bg addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(15);
    }];
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [bg addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(53);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *tips = [[UILabel alloc] init];
    tips.text = @"您可拨打400-833-6969，和脸探客服申请开票，谢谢！";
    tips.numberOfLines = 0;
    tips.font = [UIFont systemFontOfSize:14];
    tips.textColor = Public_Text_Color;
    tips.textAlignment = NSTextAlignmentLeft;
    [tips sizeToFit];
    [bg addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(20);
        make.top.mas_equalTo(bg).offset(66);
    }];
    
    UIButton *cancel = [UIButton buttonWithType:0];
    [cancel setTitle:@"取消" forState:0];
    cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancel setTitleColor:Public_Red_Color forState:0];
    cancel.layer.borderColor = Public_Red_Color.CGColor;
    cancel.layer.borderWidth = 1;
    cancel.layer.cornerRadius = 6;
    cancel.layer.masksToBounds = YES;
    [bg addSubview:cancel];
    [cancel addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg.mas_centerX).offset(-5);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    
    UIButton *call = [UIButton buttonWithType:0];
    [call setTitle:@"立即拨打" forState:0];
    call.titleLabel.font = [UIFont systemFontOfSize:16];
    [call setTitleColor:[UIColor whiteColor] forState:0];
    [call setBackgroundColor:Public_Red_Color];
    call.layer.cornerRadius = 6;
    call.layer.masksToBounds = YES;
    [bg addSubview:call];
    [call addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    [call mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_centerX).offset(5);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}
-(void)call
{
    [self hide];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
    
    [UIView commitAnimations];
}


@end
