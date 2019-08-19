//
//  SiliderView.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "SiliderView.h"
#import "WWSliderView.h"
@interface SiliderView()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,assign)NSInteger num_low;
@property(nonatomic,assign)NSInteger num_high;
@property(nonatomic, strong)WWSliderView *rangeSlider;
@end
@implementation SiliderView
- (id)init
{
    if(self=[super init])
    {
        Vheight = UI_SCREEN_HEIGHT-200;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }
    return self;
}

-(void)showTypeWithSelectLow:(NSInteger)low andHigh:(NSInteger)high
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
    _num_low = low;
    _num_high = high;
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
-(void)initUI
{
    UILabel *typeLabel = [UILabel new];
    typeLabel.frame = CGRectMake(15, 20, 35, 23);
    typeLabel.textColor = [UIColor colorWithHexString:@"464646"];
    typeLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    typeLabel.text = _typeStr;
    [self addSubview:typeLabel];
    
    UILabel *numMinLabel = [UILabel new];
    numMinLabel.frame =  CGRectMake(15,54, 50, 20);
    numMinLabel.font = [UIFont systemFontOfSize:13];
    numMinLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
    
    UILabel *numMaxLabel = [UILabel new];
    numMaxLabel.frame =  CGRectMake(UI_SCREEN_WIDTH-15-50,54, 50, 20);
    numMaxLabel.font = [UIFont systemFontOfSize:13];
    numMaxLabel.textAlignment = NSTextAlignmentRight;
    numMaxLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
    if ([_typeStr isEqualToString:@"身高"]) {
        numMinLabel.text = @"80cm";
        numMaxLabel.text = @"200cm";
    }else if ([_typeStr isEqualToString:@"年龄"]){
        numMinLabel.text = @"0岁";
        numMaxLabel.text = @"99岁";
    }
    [self addSubview:numMinLabel];
    [self addSubview:numMaxLabel];
    
    CGRect sliderFrame = CGRectMake(15, 86,UI_SCREEN_WIDTH-130, 160);
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
    if ([_typeStr isEqualToString:@"身高"]) {
        //1.先设置最左边数值、最右边数值（0-24）
        _rangeSlider.minimumValue = 80;
        _rangeSlider.maximumValue = 200;
        _rangeSlider.type = @"cm";
      }else if ([_typeStr isEqualToString:@"年龄"]){
        _rangeSlider.minimumValue = 0;
        _rangeSlider.maximumValue = 99;
        _rangeSlider.type = @"岁";
    }
    //2.再设置两个滑块位置
    [_rangeSlider resetLeftValue:_num_low rightValue:_num_high>0?_num_high:_rangeSlider.maximumValue];
    [self addSubview:_rangeSlider];

    NSArray *ageArr = @[@"婴儿",@"儿童",@"青少年",@"青年",@"中年",@"老年"];
    NSArray *heightArr= @[@"120cm以下",@"120-140cm",@"140-160cm",@"160-170cm",@"170-180cm",@"180cm以上"];
    CGFloat wid = (UI_SCREEN_WIDTH-48)/3;
    for(int i =0;i<6;i++){
        CGFloat y = 129;
        if(i>2){
            i-=3;
            y = 174;
        }
        CGFloat x = 15+i*(wid+9);
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 36);
        NSString *title;
        if ([_typeStr isEqualToString:@"身高"]) {
            title = heightArr[i];
        }else{
            title = ageArr[i];
        }
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
        btn.layer.borderWidth = 0.5;
        [btn setTag:i+100];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    UIButton *resetBtn = [UIButton buttonWithType:0];
    [resetBtn setTitle:@"重置" forState:0];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    resetBtn.titleLabel.textColor = [UIColor colorWithHexString:@"464646"];
    resetBtn.frame = CGRectMake(0, 240, 133, 48);
    [self addSubview:resetBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:0];
    [sureBtn setTitle:@"确定" forState:0];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    sureBtn.titleLabel.textColor = [UIColor whiteColor];
    sureBtn.frame = CGRectMake(133, 240, UI_SCREEN_WIDTH-133, 48);
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"ff4a57"];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
}
-(void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    if ([_typeStr isEqualToString:@"年龄"]) {
        NSArray *ageArr = @[@"0-3",@"4-12",@"12-18",@"18-26",@"26-50",@"50-99"];
        NSString *num = ageArr[tag];
        NSArray *numArr = [num componentsSeparatedByString:@"-"];
        _num_low = [numArr[0] integerValue];
        _num_high = [numArr[1] integerValue];
    }else if ([_typeStr isEqualToString:@"身高"]){
         NSArray *heightArr= @[@"80-120",@"120-140",@"140-160",@"160-170",@"170-180",@"180-200"];
        NSString *num = heightArr[tag];
        NSArray *numArr = [num componentsSeparatedByString:@"-"];
        _num_low = [numArr[0] integerValue];
        _num_high = [numArr[1] integerValue];
    }
    
     [_rangeSlider resetLeftValue:_num_low rightValue:_num_high];
}
-(void)sureAction
{
    self.selectNum(_num_low, _num_high);
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
-(void)setTypeStr:(NSString *)typeStr
{
    _typeStr = typeStr;
}
@end
