//
//  AuthPopV.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthPopV.h"

@implementation AuthPopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}

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
    
    
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    [self creatClickLayout];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}

-(void)creatClickLayout
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(284, 227));
    }];
    

    
    UIImageView *topV=[[UIImageView alloc]init];
    [self addSubview:topV];
    topV.image=[UIImage imageNamed:@"auth_promt"];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(bg.mas_top).offset(10);
    }];
    
    MLLabel *titleLab = [[MLLabel alloc] init];
    titleLab.numberOfLines=0;
    titleLab.lineSpacing=10.0;
    titleLab.font = [UIFont systemFontOfSize:15.0];
    titleLab.text=@"您还未完成实名认证。完成认证后 即可接单。";
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(bg).offset(30);
        make.top.mas_equalTo(bg).offset(85);
    }];

    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confrimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confrimBtn setTitle:@"立即去认证" forState:UIControlStateNormal];
    confrimBtn.layer.masksToBounds=YES;
    confrimBtn.layer.cornerRadius=22.0;
    confrimBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
    confrimBtn.backgroundColor=Public_Red_Color;
    [confrimBtn addTarget:self action:@selector(confrimAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confrimBtn];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bg).offset(-25);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(227, 44));
    }];
}

-(void)confrimAction
{
    if (self.goAuthBlock) {
        self.goAuthBlock();
    }
    [self hide];
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
}


@end
