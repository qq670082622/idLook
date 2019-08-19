//
//  CoupomGetPopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CouponGetPopV.h"

@implementation CouponGetPopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        
    }
    return self;
}

- (void)showWithModel:(CouponModel *)model
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
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    [self initUIWithModel:model];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
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

-(void)initUIWithModel:(CouponModel*)model
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(280,290));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:17];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(20);
    }];
    titleLab.text=@"恭喜您获得返现优惠券";
    
    UILabel *descLab = [[UILabel alloc] init];
    descLab.font=[UIFont systemFontOfSize:14.0];
    descLab.textColor=Public_DetailTextLabelColor;
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(2);
    }];
    descLab.text=@"赶快下单使用吧！";
    
    UIImageView *icon = [[UIImageView alloc]init];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(65);
    }];
    icon.image=[UIImage imageNamed:@"me_coupon_convert_pop"];

    NSString *rate = [NSString stringWithFormat:@"%ld%%",(NSInteger)([model.rate floatValue]*100)];
    UILabel *rateLab = [[UILabel alloc] init];
    rateLab.font=[UIFont boldSystemFontOfSize:35.0];
    rateLab.textColor=[UIColor whiteColor];
    [self addSubview:rateLab];
    [rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon).offset(65);
        make.top.mas_equalTo(icon).offset(26);
    }];
    rateLab.text=rate;
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.font=[UIFont boldSystemFontOfSize:18];
    lab1.textColor=[UIColor whiteColor];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rateLab);
        make.bottom.mas_equalTo(icon).offset(-40);
    }];
    lab1.text=@"返现优惠券";
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    UIButton *useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [useBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [useBtn setTitle:@"去使用" forState:UIControlStateNormal];
    useBtn.layer.masksToBounds=YES;
    useBtn.layer.cornerRadius=22;
    useBtn.backgroundColor=Public_Red_Color;
    useBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [useBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [useBtn addTarget:self action:@selector(goUseAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:useBtn];
    [useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(128, 44));
    }];
    
}

-(void)goUseAction
{
    if (self.goUserBlock) {
        self.goUserBlock();
    }
    [self hide];
}


@end
