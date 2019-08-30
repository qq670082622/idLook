//
//  SexAgePopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/27.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "SexAgePopV.h"
#import "WWSliderView.h"
@interface SexAgePopV()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,assign)NSInteger sex;
@property(nonatomic,assign)NSInteger age_High;
@property(nonatomic,assign)NSInteger age_Low;
@property(nonatomic, strong)WWSliderView *rangeSlider;
@end
@implementation SexAgePopV
- (id)init
{
    if(self=[super init])
    {
        Vheight = 357;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }
    return self;
}
-(void)showTypeWithSelectSex:(NSInteger)sex andAgeHigh:(NSInteger)ageHigh andAgeLow:(NSInteger)ageLow
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
    _sex = sex;
    _age_High = ageHigh;
    _age_Low = ageLow;
    if (ageHigh==0&&ageLow==0) {
        _age_Low = 20;
        _age_High = 40;
    }
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
    UILabel *sexLabel = [UILabel new];
    sexLabel.frame = CGRectMake(15, 20, 35, 23);
    sexLabel.textColor = [UIColor colorWithHexString:@"464646"];
    sexLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    sexLabel.text = @"性别";
    [self addSubview:sexLabel];
    
    NSArray *heightArr= @[@"男",@"女",@"不限"];
    CGFloat wid = (UI_SCREEN_WIDTH-48)/3;
    for(int i =0;i<3;i++){
        CGFloat y = 54;
        CGFloat x = 15+i*(wid+9);
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 36);
        NSString *title = heightArr[i];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+50];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    UILabel *ageLabel = [UILabel new];
    ageLabel.frame = CGRectMake(15, 116, 35, 23);
    ageLabel.textColor = [UIColor colorWithHexString:@"464646"];
    ageLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    ageLabel.text = @"年龄";
    [self addSubview:ageLabel];
    
    CGRect sliderFrame = CGRectMake(-15, 151,UI_SCREEN_WIDTH+30, 50);
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
    _rangeSlider.maximumValue = 100;
    _rangeSlider.type = @"岁";
    
    //2.再设置两个滑块位置
    [_rangeSlider resetLeftValue:_age_Low rightValue:_age_High];
    [self addSubview:_rangeSlider];
    
    NSArray *ageArr= @[@"10岁以下",@"10-20岁",@"20-40岁",@"40-60岁",@"60-80岁",@"80岁以上"];
    
    for(int i =0;i<6;i++){
        CGFloat y = 216;
        if(i>2){
            y = 257;
        }
        CGFloat i2 = i>2?(i-3):i;
        CGFloat x = 15+i2*(wid+9);
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 36);
        NSString *title = ageArr[i];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+100];
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
    if (tag<100) {//性别
    
       self.sex = tag-49;
        UIButton *man = [self viewWithTag:50];
        man.layer.borderColor = Public_Text_Color.CGColor;
        [man setTitleColor:Public_Text_Color forState:0];
        UIButton *woman = [self viewWithTag:51];
        woman.layer.borderColor = Public_Text_Color.CGColor;
          [woman setTitleColor:Public_Text_Color forState:0];
        UIButton *any = [self viewWithTag:52];
        any.layer.borderColor = Public_Text_Color.CGColor;
        [any setTitleColor:Public_Text_Color forState:0];
       
        UIButton *btn = (UIButton *)sender;
          [btn setTitleColor:Public_Red_Color forState:0];
        btn.layer.borderColor = Public_Red_Color.CGColor;
    }else if (tag>100){//年龄
        NSArray *weightArr= @[@"0-10",@"10-20",@"20-40",@"40-60",@"60-80",@"80-100"];
        NSString *num = weightArr[tag-100];
        NSArray *numArr = [num componentsSeparatedByString:@"-"];
        _age_Low = [numArr[0] integerValue];
        _age_High = [numArr[1] integerValue];
        [_rangeSlider resetLeftValue:_age_Low rightValue:_age_High];
        [_rangeSlider resetLeftAndRightLabel];
    }
}

-(void)sureAction
{
    self.selectNum(_sex,_age_High,_age_Low);
    [self hide];
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
