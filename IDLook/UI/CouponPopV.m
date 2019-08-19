//
//  CouponPopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CouponPopV.h"

@implementation CouponPopV

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

- (void)show
{
    [UserInfoManager setPopupCoupon:NO];
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
    
    [self initUI];
    
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

-(void)initUI
{
    UIImage *image =[UIImage imageNamed:@"coupon_pop_bg"];
    UIImageView *bg=[[UIImageView alloc]init];
    [self addSubview:bg];
    bg.image=image;
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.textColor = [UIColor whiteColor];
    [bg addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(133);
    }];
    titleLab.text=@"返现券兑换说明";
    
    UIImageView *icon1=[[UIImageView alloc]init];
    [bg addSubview:icon1];
    icon1.image=[UIImage imageNamed:@"coupon_pop_01"];
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(titleLab.mas_left).offset(-5);
        make.centerY.mas_equalTo(titleLab);
    }];
    
    UIImageView *icon2=[[UIImageView alloc]init];
    [bg addSubview:icon2];
    icon2.image=[UIImage imageNamed:@"coupon_pop_01"];
    [icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab.mas_right).offset(5);
        make.centerY.mas_equalTo(titleLab);
    }];
    
    UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confrimBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    confrimBtn.layer.masksToBounds=YES;
    confrimBtn.layer.cornerRadius=22;
    confrimBtn.backgroundColor=[UIColor colorWithHexString:@"#FFF4C5"];
    confrimBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [confrimBtn setTitleColor:[UIColor colorWithHexString:@"#FF8919"] forState:UIControlStateNormal];
    [confrimBtn addTarget:self action:@selector(convertAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confrimBtn];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.bottom.mas_equalTo(bg).offset(-20);
        make.size.mas_equalTo(CGSizeMake(180, 44));
    }];
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    NSArray *array = @[@"在脸探肖像APP-我的-优惠券页面，输入返现码兑换「下单20%返现券」。",
                       @"返现码也可多次转赠他人使用，则您返5%，下单人返15%。",
                       @"每个返现码仅可被同一账号兑换一次，但同一返现码可被多个账号兑换。",
                       @"当返现码兑换出的返现券被使用（即订单尾款 支付完成），两个工作日内，返现金额将统一 返至由您手机号注册为买家身份的脸探肖像APP账户内，可随时提现。",
                       @"兑换有效期为2019-07-31前，过期将无法兑换。"];
    
    CGFloat totalHeight=168;
    for (int i=0; i<array.count; i++) {
        
        MLLabel *numberLab = [[MLLabel alloc]init];
        numberLab.text=[NSString stringWithFormat:@"%d",i+1];
        numberLab.layer.cornerRadius=7;
        numberLab.lineSpacing=3;
        numberLab.layer.masksToBounds=YES;
        numberLab.textAlignment=NSTextAlignmentCenter;
        numberLab.backgroundColor=[UIColor whiteColor];
        numberLab.textColor=[UIColor colorWithHexString:@"#FF8A19"];
        numberLab.font=[UIFont boldSystemFontOfSize:11];
        [bg addSubview:numberLab];
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bg).offset(15);
            make.top.mas_equalTo(bg).offset(totalHeight);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        MLLabel *descLab = [[MLLabel alloc]init];
        descLab.font=[UIFont systemFontOfSize:12];
        descLab.numberOfLines=0;
        descLab.lineSpacing=3;
        descLab.textAlignment=NSTextAlignmentLeft;
        descLab.textColor=[UIColor whiteColor];
        descLab.text=array[i];
        [bg addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bg).offset(35);
            make.right.mas_equalTo(bg).offset(-15);
            make.top.mas_equalTo(bg).offset(totalHeight);
        }];
        
        //高度计算
        totalHeight=totalHeight+[self heighOfString:array[i] font:[UIFont systemFontOfSize:12] width:image.size.width-50]+7;
    }
}

//立即兑换
-(void)convertAction
{
    [self hide];
    if (self.convertBlock) {
        self.convertBlock();
    }
}

//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 3;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<20?20:ceilf(size.height);
}

@end
