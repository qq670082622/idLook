//
//  ShotPriceDPopV.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ShotPriceDPopV.h"

@interface ShotPriceDPopV ()
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,assign)CGFloat vHeight;
@end

@implementation ShotPriceDPopV
- (id)init
{
    if(self=[super init])
    {
        if ([UserInfoManager getUserStatus]>200) {
            self.vHeight=270;
        }
        else
        {
            self.vHeight=270;
        }
    }
    return self;
}

- (void)showWithLoad:(BOOL)isLoading withModel:(OrderStructM *)model withPriceInfo:(nonnull NSDictionary *)dic
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
    
    //当window上有视图时移除
    for (UIView *view in showWindow.subviews) {
        if ([view isKindOfClass:[ShotPriceDPopV class]]) {
            ShotPriceDPopV *popV = (ShotPriceDPopV*)view;
            [popV hide];
            return;
        }
    }
    
    if (isLoading==NO) {
        return;
    }
    
    self.frame=CGRectMake(0, 0, showWindow.bounds.size.width, showWindow.bounds.size.height-60-SafeAreaTabBarHeight_IphoneX);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    
    UIView *maskV = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-60,UI_SCREEN_WIDTH, self.vHeight)];
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
    
    [self initUIWIthModel:model withPriceInfo:dic];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.maskV.frame = CGRectMake(0, UI_SCREEN_HEIGHT-self.vHeight-60-SafeAreaTabBarHeight_IphoneX, UI_SCREEN_WIDTH,self.vHeight);
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
    
    self.maskV.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, self.vHeight);
    
    [UIView commitAnimations];
}

-(void)initUIWIthModel:(OrderStructM*)model withPriceInfo:(NSDictionary*)dic
{
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont boldSystemFontOfSize:16];
    title.textColor = Public_Text_Color;
    [self.maskV addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.maskV).offset(0);
        make.top.mas_equalTo(self.maskV).offset(14);
    }];
    title.text=@"价格明细";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.maskV addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title);
        make.right.equalTo(self.maskV).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UIView *lineV1=[[UIView alloc]init];
    lineV1.backgroundColor=Public_LineGray_Color;
    [self.maskV addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV);
        make.right.mas_equalTo(self.maskV);
        make.top.mas_equalTo(self.maskV).offset(48);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *totalLab = [[UILabel alloc] init];
    totalLab.font = [UIFont systemFontOfSize:15];
    totalLab.textColor = Public_Text_Color;
    [self.maskV addSubview:totalLab];
    [totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV).offset(15);
        make.top.mas_equalTo(self.maskV).offset(70);
    }];
    totalLab.text=@"订单总价";
    
    UILabel *totalPriceLab = [[UILabel alloc] init];
    totalPriceLab.font = [UIFont systemFontOfSize:15];
    totalPriceLab.textColor = Public_Text_Color;
    [self.maskV addSubview:totalPriceLab];
    [totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.maskV).offset(-15);
        make.top.mas_equalTo(self.maskV).offset(70);
    }];

    NSInteger totalPrice=0;    //总价
    NSInteger makeupPrice=0;   //定妆费
    NSInteger showPrice=0;    //演出费
    NSInteger showFreePrice=0;  //演出费优惠
    NSInteger tax=0;         //税费
    NSInteger insuranceFee=0;  //保险费
    NSInteger vipFreePrice=0;         //vip优惠
    if (dic!=nil) {
        totalPrice=[dic[@"totalPrice"]integerValue];
        NSDictionary *orderPriceDetail = dic[@"orderPriceDetail"];
        makeupPrice=[orderPriceDetail[@"makeupPrice"]integerValue];
        showPrice=[orderPriceDetail[@"showPrice"]integerValue];
        showFreePrice=[orderPriceDetail[@"showFreePrice"]integerValue];
        tax=[orderPriceDetail[@"tax"]integerValue];
        insuranceFee=[orderPriceDetail[@"insuranceFee"]integerValue];
        vipFreePrice=[orderPriceDetail[@"vipFreePrice"]integerValue];
    }
    
    totalPriceLab.text=[NSString stringWithFormat:@"¥%ld",totalPrice];
    
    UIView *lineV2=[[UIView alloc]init];
    lineV2.backgroundColor=Public_LineGray_Color;
    [self.maskV addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV).offset(15);
        make.centerX.mas_equalTo(self.maskV);
        make.top.mas_equalTo(self.maskV).offset(102);
        make.height.mas_equalTo(0.5);
    }];
    
    NSArray *array = @[@{@"title":@"定妆费",@"price":[NSString stringWithFormat:@"¥%ld",makeupPrice]},
                       @{@"title":@"演出费",@"price":[NSString stringWithFormat:@"¥%ld",showPrice]},
                       @{@"title":@"演出费优惠",@"price":[NSString stringWithFormat:@"-¥%ld",showFreePrice]},
//                       @{@"title":@"税费",@"price":[NSString stringWithFormat:@"¥%ld",tax]},
                       @{@"title":@"保险费",@"price":@" ¥30  ¥0"}];
    
    //vip用户
    if ([UserInfoManager getUserStatus]>200) {
        array = @[@{@"title":@"定妆费",@"price":[NSString stringWithFormat:@"¥%ld",makeupPrice]},
                  @{@"title":@"演出费",@"price":[NSString stringWithFormat:@"¥%ld",showPrice]},
                  @{@"title":@"演出费优惠",@"price":[NSString stringWithFormat:@"-¥%ld",showFreePrice]},
//                  @{@"title":@"VIP优惠",@"price":[NSString stringWithFormat:@"-¥%ld",vipFreePrice]},
//                  @{@"title":@"税费",@"price":[NSString stringWithFormat:@"¥%ld",tax]},
                  @{@"title":@"保险费",@"price":@" ¥30  ¥0"}];
    }
    
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = Public_Text_Color;
        [self.maskV addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.maskV).offset(15);
            make.top.mas_equalTo(lineV2.mas_bottom).offset(19+27*i);
        }];
        label.text=dic[@"title"];
        
        UILabel *priceLab = [[UILabel alloc] init];
        priceLab.font = [UIFont systemFontOfSize:15.0];
        priceLab.textColor = Public_Text_Color;
        [self.maskV addSubview:priceLab];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.maskV).offset(-15);
            make.centerY.mas_equalTo(label);
        }];
        priceLab.text=dic[@"price"];
        
        if (i==array.count-1) {
            NSString *content = dic[@"price"];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:content];
            [attStr addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
            [attStr addAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,5)];
            priceLab.attributedText=attStr;
        }
    }
    
    UILabel *descLab = [[UILabel alloc] init];
    descLab.font = [UIFont systemFontOfSize:13];
    descLab.textColor = [UIColor colorWithHexString:@"#FF6600"];
    [self.maskV addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV).offset(15);
        make.bottom.mas_equalTo(self.maskV).offset(-21);
    }];
    descLab.text=@"*请在艺人确认档期后，去我的订单支付首款。";

}

@end
