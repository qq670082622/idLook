//
//  PricePopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/28.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "PricePopV.h"
#import "WWSliderView.h"
@interface PricePopV()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,assign)NSInteger price_High;
@property(nonatomic,assign)NSInteger price_Low;
@property(nonatomic, strong)WWSliderView *rangeSlider;
@property(nonatomic,assign)NSInteger reset_low;
@property(nonatomic,assign)NSInteger reset_high;
@end
@implementation PricePopV
- (id)init
{
    if(self=[super init])
    {
        Vheight = 261;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}
-(void)showTypeWithSelectLowPrice:(NSInteger)lowPrice andHighPrice:(NSInteger)highPrice
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
   _price_Low = lowPrice;
    _price_High = highPrice;
    if (lowPrice==0&&highPrice==0) {
        _price_Low = 3000;
        _price_High = 5000;
    }
    _reset_low = _price_Low;
    _reset_high = _price_High;
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
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
    
    [UIView commitAnimations];
}
- (void)initUI
{
    UILabel *piceLabel = [UILabel new];
    piceLabel.frame = CGRectMake(15, 20, 35, 23);
    piceLabel.textColor = [UIColor colorWithHexString:@"464646"];
    piceLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    piceLabel.text = @"价格";
    [self addSubview:piceLabel];
    
    CGRect sliderFrame = CGRectMake(-15, 54,UI_SCREEN_WIDTH+30, 50);
    UIColor *color1 = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    UIColor *color2 = [UIColor whiteColor];//[UIColor colorWithRed:22/255.0 green:145/255.0 blue:153/255.0 alpha:1];
    UIColor *color3 = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:87/255.0 alpha:1];
    UIColor *color4 = [UIColor whiteColor];//[UIColor colorWithRed:244/255.0 green:77/255.0 blue:84/255.0 alpha:1];
    UIColor *color5 = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:87/255.0 alpha:1];
    
    
    _rangeSlider = [[WWSliderView alloc] initWithFrame:sliderFrame
                                           sliderColor:color1
                                        leftSmallColor:color2
                                          leftBigColor:color3
                                       rightSmallColor:color4
                                         rightBigColor:color5];
    
    //1.先设置最左边数值、最右边数值（0-24）
    _rangeSlider.minimumValue = 0;
    _rangeSlider.maximumValue = 30000;
    _rangeSlider.type = @"元";
    
    //2.再设置两个滑块位置
    [_rangeSlider resetLeftValue:_price_Low rightValue:_price_High];
    [self addSubview:_rangeSlider];
      [_rangeSlider resetLeftAndRightLabel];
    
    NSArray *priceArr= @[@"0-2000",@"2000-4000",@"4000-6000",@"6000-8000",@"8000-15000",@"15000-30000"];
    CGFloat wid = (UI_SCREEN_WIDTH-48)/3;
    for(int i =0;i<priceArr.count;i++){
        CGFloat y = 109;
        if(i>2){
            y = 166;
        }
        CGFloat i2 = i>2?(i-3):i;
        CGFloat x = 15+i2*(wid+9);
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 36);;
        NSString *title = priceArr[i];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+50];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    UIButton *resetBtn = [UIButton buttonWithType:0];
    [resetBtn setTitle:@"重置" forState:0];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
    resetBtn.frame = CGRectMake(0, Vheight-48, 133, 48);
    resetBtn.layer.borderColor = [UIColor colorWithHexString:@"f2f2f2"].CGColor;
    resetBtn.layer.borderWidth = 0.5;
     [resetBtn addTarget:self action:@selector(resetRangeValue) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resetBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:0];
    [sureBtn setTitle:@"确定" forState:0];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    sureBtn.titleLabel.textColor = [UIColor whiteColor];
    sureBtn.frame = CGRectMake(133, Vheight-48, UI_SCREEN_WIDTH-133, 48);
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"ff4a57"];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
}

-(void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    NSArray *priceArr= @[@"0-2000",@"2000-4000",@"4000-6000",@"6000-8000",@"8000-15000",@"15000-30000"];
        NSString *num = priceArr[tag-50];
        NSArray *numArr = [num componentsSeparatedByString:@"-"];
        _price_Low = [numArr[0] integerValue];
        _price_High = [numArr[1] integerValue];
        [_rangeSlider resetLeftValue:_price_Low rightValue:_price_High];
        [_rangeSlider resetLeftAndRightLabel];
    
}
-(void)sureAction
{
    _price_Low = _rangeSlider.lowerValue;
    _price_High = _rangeSlider.upperValue;
    self.selectNum(_price_Low,_price_High);
    [self hide];
}
-(void)resetRangeValue
{
    _price_Low =  self.reset_low;
    _price_High = self.reset_high;
  [_rangeSlider resetLeftValue:_price_Low rightValue:_price_High];
    [_rangeSlider resetLeftAndRightLabel];
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    //   [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    [UIView commitAnimations];
}
@end
