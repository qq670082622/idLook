//
//  PriceDetailPopV.m
//  IDLook
//
//  Created by HYH on 2018/6/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PriceDetailPopV.h"

@interface PriceDetailPopV ()
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,strong)NSDictionary *dic;
@end

@implementation PriceDetailPopV

- (id)init
{
    if(self=[super init])
    {

    }
    return self;
}

- (void)showWithLoad:(BOOL)isLoading withDic:(NSDictionary *)dic
{
    self.dic=dic;
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
    
    //当window上有视图时移除
    for (UIView *view in showWindow.subviews) {
        if ([view isKindOfClass:[PriceDetailPopV class]]) {
            PriceDetailPopV *popV = (PriceDetailPopV*)view;
            [popV hide];
            return;
        }
    }
    
    if (isLoading==NO) {
        return;
    }
    
    self.frame=CGRectMake(0, 0, showWindow.bounds.size.width, showWindow.bounds.size.height-48);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];

    UIView *maskV = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-48,UI_SCREEN_WIDTH, 180)];
    maskV.backgroundColor = [UIColor whiteColor];
    maskV.alpha = 0.f;
    maskV.layer.borderColor=Public_LineGray_Color.CGColor;
    maskV.layer.borderWidth=0.5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    [showWindow addSubview:self];
    [self addSubview:maskV];
    self.clipsToBounds=YES;
    self.maskV=maskV;
    
    [self initUI];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.maskV.frame = CGRectMake(0, UI_SCREEN_HEIGHT-150-48, UI_SCREEN_WIDTH,150);
    
    [UIView commitAnimations];
}


- (void)clearSubV
{
    [self removeFromSuperview];
    [self.maskV removeFromSuperview];
}
- (void)hide
{
//    [self clearSubV];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];

    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.alpha = 0.f;

    self.maskV.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 150);

    [UIView commitAnimations];
}

-(void)initUI
{
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:14.0];
    title.textColor = Public_Text_Color;
    [self.maskV addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV).offset(15);
        make.top.mas_equalTo(self.maskV).offset(12);
    }];
    title.text=@"价格明细";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.maskV addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.maskV).offset(0);
        make.right.equalTo(self.maskV).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self.maskV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV);
        make.right.mas_equalTo(self.maskV);
        make.top.mas_equalTo(self.maskV).offset(40);
        make.height.mas_equalTo(0.5);
    }];
    NSString *fixedprice= [self.dic[@"fixedprice"] floatValue]>0?[NSString stringWithFormat:@"¥%ld",[self.dic[@"fixedprice"]integerValue]]:@"商议价";
    NSArray *titleArr=@[@"定角费",@"定装费",@"跟单员费"];
    NSArray *descArr=@[fixedprice,[NSString stringWithFormat:@"¥%ld",[self.dic[@"makeupprice"]integerValue]],[NSString stringWithFormat:@"¥%ld",[self.dic[@"manageprice"]integerValue]]];

    for (int i =0; i<titleArr.count; i++) {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = [UIFont systemFontOfSize:14.0];
        titleLab.textColor = [UIColor colorWithHexString:@"#666666"];
        [self.maskV addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.maskV).offset(15);
            make.top.mas_equalTo(self.maskV).offset(60+20*i);
        }];
        titleLab.text=titleArr[i];
        
        UILabel *descLab = [[UILabel alloc] init];
        descLab.font = [UIFont systemFontOfSize:14.0];
        descLab.textColor = [UIColor colorWithHexString:@"#666666"];
        [self.maskV addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.maskV).offset(-15);
            make.top.mas_equalTo(self.maskV).offset(60+20*i);
        }];
        descLab.text=descArr[i];
    }
}

@end
