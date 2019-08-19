//
//  ServiceExplainPopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ServiceExplainPopV.h"

@interface ServiceExplainPopV ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIView *maskV;
@end

@implementation ServiceExplainPopV

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 175+SafeAreaTabBarHeight_IphoneX)];
    if(self){
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return self;
}


- (void)showWithDay:(NSInteger)day withFreePrice:(NSInteger)price
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
    self.maskV=maskV;
    
    [showWindow addSubview:self];
    
    [self initUIWithDay:day withFreePrice:price];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-175-SafeAreaTabBarHeight_IphoneX, UI_SCREEN_WIDTH, 175+SafeAreaTabBarHeight_IphoneX);
    
    [UIView commitAnimations];
}


- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 175+SafeAreaTabBarHeight_IphoneX);
    [UIView commitAnimations];
}

- (void)initUIWithDay:(NSInteger)day withFreePrice:(NSInteger)price
{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = Public_Text_Color;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(12);
    }];
    titleLabel.text = @"项目服务费说明";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(48, 48));
        make.right.equalTo(self).offset(-5);
    }];
    
    MLLabel *descLabel = [[MLLabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:14];
    descLabel.numberOfLines=0;
    descLabel.lineSpacing=5.0;
    descLabel.textColor = Public_DetailTextLabelColor;
    [self addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(60);
    }];
    descLabel.text = [NSString stringWithFormat:@"项目服务费为拍摄日脸探肖像员工现场跟单服务的费用，每天的服务费为：￥%ld/人。",price];
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=Public_Background_Color;
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(115);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = [UIFont systemFontOfSize:14];
    titleLabel2.textColor = Public_Text_Color;
    [self addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(lineV).offset(15);
    }];
    titleLabel2.text = @"本次服务费用";
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = Public_Text_Color;
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(titleLabel2);
    }];
    priceLabel.text = [NSString stringWithFormat:@"￥%ld×%ld天",price,day];
    
}


- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}


@end
