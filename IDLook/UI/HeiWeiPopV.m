//
//  HeiWeiPopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/26.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "HeiWeiPopV.h"
#import "WWSliderView.h"
@interface HeiWeiPopV()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,assign)NSInteger hei_low;
@property(nonatomic,assign)NSInteger hei_high;
@property(nonatomic,assign)NSInteger wei_low;
@property(nonatomic,assign)NSInteger wei_high;
@property(nonatomic, strong)WWSliderView *hei_rangeSlider;
@property(nonatomic, strong)WWSliderView *wei_rangeSlider;
@property(nonatomic,assign)NSInteger resetHei_low;
@property(nonatomic,assign)NSInteger resetHei_high;
@property(nonatomic,assign)NSInteger resetwei_low;
@property(nonatomic,assign)NSInteger resetwei_high;
@end
@implementation HeiWeiPopV
- (id)init
{
    if(self=[super init])
    {
        Vheight = 463;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }
    return self;
}
-(void)showTypeWithSelectLowHei:(NSInteger)lowHei andHighHei:(NSInteger)highHei andLowWei:(NSInteger)lowWei andiHighWei:(NSInteger)highWei
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
    self.hei_low = lowHei==0?80:lowHei;
    self.hei_high = highHei==0?200:highHei;
    self.wei_low = lowWei;
    self.wei_high = highWei==0?120:highWei;
    self.resetHei_low = _hei_low;
    self.resetHei_high = _hei_high;
    self.resetwei_low = _wei_low;
    self.resetwei_high = _wei_high;
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    [showWindow addSubview:self];
    self.maskV=maskV;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
    [self initUI];
    [UIView commitAnimations];
}
- (void)initUI
{
 // ***************************身高**************************************
    UILabel *heiLabel = [UILabel new];
    heiLabel.frame = CGRectMake(15, 20, 35, 23);
    heiLabel.textColor = [UIColor colorWithHexString:@"464646"];
    heiLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    heiLabel.text = @"身高";
    [self addSubview:heiLabel];
    
//    UILabel *heiMinLabel = [UILabel new];
//    heiMinLabel.frame =  CGRectMake(15,54, 50, 20);
//    heiMinLabel.font = [UIFont systemFontOfSize:13];
//    heiMinLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//
//    UILabel *heiMaxLabel = [UILabel new];
//    heiMaxLabel.frame =  CGRectMake(UI_SCREEN_WIDTH-15-50,54, 50, 20);
//    heiMaxLabel.font = [UIFont systemFontOfSize:13];
//    heiMaxLabel.textAlignment = NSTextAlignmentRight;
//    heiMaxLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//
//        heiMinLabel.text = @"80cm";
//        heiMaxLabel.text = @"200cm";
//
//    [self addSubview:heiMinLabel];
//    [self addSubview:heiMaxLabel];

    CGRect sliderFrame = CGRectMake(-15, 54,UI_SCREEN_WIDTH+30, 50);
    UIColor *color1 = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    UIColor *color2 = [UIColor whiteColor];//[UIColor colorWithRed:22/255.0 green:145/255.0 blue:153/255.0 alpha:1];
    UIColor *color3 = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:87/255.0 alpha:1];
    UIColor *color4 = [UIColor whiteColor];//[UIColor colorWithRed:244/255.0 green:77/255.0 blue:84/255.0 alpha:1];
    UIColor *color5 = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:87/255.0 alpha:1];


    _hei_rangeSlider = [[WWSliderView alloc] initWithFrame:sliderFrame
                                           sliderColor:color1
                                        leftSmallColor:color2
                                          leftBigColor:color3
                                       rightSmallColor:color4
                                         rightBigColor:color5];

        //1.先设置最左边数值、最右边数值（0-24）
        _hei_rangeSlider.minimumValue = 0;
        _hei_rangeSlider.maximumValue = 200;
        _hei_rangeSlider.type = @"cm";

    //2.再设置两个滑块位置
    [_hei_rangeSlider resetLeftValue:_hei_low rightValue:_hei_high];
    [self addSubview:_hei_rangeSlider];

  NSArray *heightArr= @[@"100cm以下",@"100-120cm",@"120-140cm",@"140-160cm",@"160-180cm",@"180cm以上"];
    CGFloat wid = (UI_SCREEN_WIDTH-48)/3;
    for(int i =0;i<6;i++){
        CGFloat y = 104;
        if(i>2){
           y = 152;
        }
        CGFloat i2 = i>2?(i-3):i;
        CGFloat x = 15+i2*(wid+9);
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 36);
        NSString *title = heightArr[i];
       [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }

// // ***************************体重**************************************
    UIView *weiView = [UIView new];
    weiView.frame = CGRectMake(0, (Vheight-48)/2, UI_SCREEN_WIDTH, (Vheight-48)/2);
    UILabel *weiLabel = [UILabel new];
    weiLabel.frame = CGRectMake(15, 20, 35, 23);
    weiLabel.textColor = [UIColor colorWithHexString:@"464646"];
    weiLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    weiLabel.text = @"体重";
    [weiView addSubview:weiLabel];
//
//    UILabel *weiMinLabel = [UILabel new];
//    weiMinLabel.frame =  CGRectMake(15,54, 50, 20);
//    weiMinLabel.font = [UIFont systemFontOfSize:13];
//    weiMinLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//
//    UILabel *weiMaxLabel = [UILabel new];
//    weiMaxLabel.frame =  CGRectMake(UI_SCREEN_WIDTH-15-50,54, 50, 20);
//    weiMaxLabel.font = [UIFont systemFontOfSize:13];
//    weiMaxLabel.textAlignment = NSTextAlignmentRight;
//    weiMaxLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//
//    weiMinLabel.text = @"0kg";
//    weiMaxLabel.text = @"120kg";
//
//    [weiView addSubview:heiMinLabel];
//    [weiView addSubview:heiMaxLabel];
//
_wei_rangeSlider = [[WWSliderView alloc] initWithFrame:sliderFrame
                                               sliderColor:color1
                                            leftSmallColor:color2
                                              leftBigColor:color3
                                           rightSmallColor:color4
                                             rightBigColor:color5];

    //1.先设置最左边数值、最右边数值（0-24）
    _wei_rangeSlider.minimumValue = 0;
    _wei_rangeSlider.maximumValue = 120;
    _wei_rangeSlider.type = @"kg";

    //2.再设置两个滑块位置
    [_wei_rangeSlider resetLeftValue:_wei_low rightValue:_wei_high];
    [weiView addSubview:_wei_rangeSlider];

    NSArray *weightArr= @[@"30kg以下",@"30-40kg",@"40-50kg",@"50-60kg",@"60-70kg",@"70kg以上"];
  //  CGFloat wid = (UI_SCREEN_WIDTH-48)/3;
    for(int i =0;i<6;i++){
        CGFloat y = 109;
        if(i>2){
        y = 154;
        }
          CGFloat i2 = i>2?(i-3):i;
        CGFloat x = 15+i2*(wid+9);
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 36);
        NSString *title = weightArr[i];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        btn.layer.borderWidth = 0.5;
        [btn setTag:i+100];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [weiView addSubview:btn];
    }

    [self addSubview:weiView];

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
    if (tag<100) {//身高
        NSArray *heightArr= @[@"0-100",@"100-120",@"120-140",@"140-160",@"160-180",@"180-200"];
        NSString *num = heightArr[tag];
        NSArray *numArr = [num componentsSeparatedByString:@"-"];
        _hei_low = [numArr[0] integerValue];
        _hei_high = [numArr[1] integerValue];
          [_hei_rangeSlider resetLeftValue:_hei_low rightValue:_hei_high];
        [_hei_rangeSlider resetLeftAndRightLabel];
    }else if (tag>99){//体重
        NSArray *weightArr= @[@"0-30",@"30-40",@"40-50",@"50-60",@"60-70",@"70-120"];
        NSString *num = weightArr[tag-100];
        NSArray *numArr = [num componentsSeparatedByString:@"-"];
        _wei_low = [numArr[0] integerValue];
        _wei_high = [numArr[1] integerValue];
          [_wei_rangeSlider resetLeftValue:_wei_low rightValue:_wei_high];
           [_wei_rangeSlider resetLeftAndRightLabel];
    }
}

-(void)sureAction
{
    _hei_low = _hei_rangeSlider.lowerValue;
    _hei_high = _hei_rangeSlider.upperValue;
    _wei_low = _wei_rangeSlider.lowerValue;
    _wei_high = _wei_rangeSlider.upperValue;
    self.selectNum(_hei_low, _hei_high, _wei_low, _wei_high);
    [self hide];
}
-(void)resetRangeValue
{
    _hei_low =  self.resetHei_low;
 _hei_high = self.resetHei_high;
   _wei_low = self.resetwei_low;
     _wei_high = self.resetwei_high;
    [_hei_rangeSlider resetLeftValue:_hei_low rightValue:_hei_high];
    [_hei_rangeSlider resetLeftAndRightLabel];
    [_wei_rangeSlider resetLeftValue:_wei_low rightValue:_wei_high];
    [_wei_rangeSlider resetLeftAndRightLabel];
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
