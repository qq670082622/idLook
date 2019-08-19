//
//  AcceptPricePopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/30.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AcceptPricePopV.h"

@interface AcceptPricePopV ()

@end

@implementation AcceptPricePopV

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

- (void)showWithBuyPrice:(NSInteger)buyprice withActorPrice:(NSInteger)actorprice
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
    
    [self initUIWithBuyPrice:buyprice withActorPrice:actorprice];
    
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

-(void)initUIWithBuyPrice:(NSInteger)buyprice withActorPrice:(NSInteger)actorprice
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(280,220));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:17];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(15);
    }];
    titleLab.text=@"接受价格";
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#E7E7E7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(53);
        make.height.mas_equalTo(0.5);
    }];
    
    MLLabel *descLab = [[MLLabel alloc] init];
    descLab.numberOfLines=0;
    descLab.lineSpacing=5.0;
    descLab.font=[UIFont systemFontOfSize:14.0];
    descLab.textColor=Public_Text_Color;
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg).offset(-20);
        make.left.mas_equalTo(bg).offset(20);
        make.top.mas_equalTo(bg).offset(65);
    }];
    
    NSString *price1Str = [NSString stringWithFormat:@"￥%ld",buyprice];
    NSString *price2Str = [NSString stringWithFormat:@"￥%ld",actorprice];

    NSString *str=[NSString stringWithFormat:@"该演员已拒绝您%@的报价，并给出心理价位%@，您是否接受该价格？",price1Str,price2Str];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FF6E0C"],} range:NSMakeRange(7,price1Str.length)];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FF6E0C"],} range:NSMakeRange(18+price1Str.length,price2Str.length)];

    descLab.attributedText=attStr;
    
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(20);
    }];
    
    UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [acceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [acceptBtn setTitle:@"接受" forState:UIControlStateNormal];
    acceptBtn.layer.masksToBounds=YES;
    acceptBtn.layer.cornerRadius=4;
    acceptBtn.backgroundColor=Public_Red_Color;
    acceptBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [acceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [acceptBtn addTarget:self action:@selector(acceptAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:acceptBtn];
    [acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_centerX).offset(5);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    
    UIButton *rejectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rejectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rejectBtn setTitle:@"不接受" forState:UIControlStateNormal];
    rejectBtn.layer.masksToBounds=YES;
    rejectBtn.layer.cornerRadius=4;
    rejectBtn.backgroundColor=Public_Red_Color;
    rejectBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [rejectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rejectBtn addTarget:self action:@selector(rejectAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rejectBtn];
    [rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg.mas_centerX).offset(-5);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    
}

-(void)acceptAction
{
    [self hide];
    if (self.AcceptPricePopVBlock) {
        self.AcceptPricePopVBlock(1);
    }
}

-(void)rejectAction
{
    [self hide];
    if (self.AcceptPricePopVBlock) {
        self.AcceptPricePopVBlock(2);
    }
}

@end
