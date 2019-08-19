//
//  BirthSelectV.m
//  VoiceGame
//
//  Created by wsz on 15/5/29.
//  Copyright (c) 2015年 VoiceGame. All rights reserved.
//

#import "BirthSelectV.h"

#define BirthSelectV_Height 255.0

@interface BirthSelectV ()
{
    UIView *maskV;
}

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,assign)DateType type;
@end

@implementation BirthSelectV

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, BirthSelectV_Height)];
    if(self){self.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];}
    return self;
}

- (UIDatePicker *)datePicker
{
    if(!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.frame = CGRectMake(0, 40, UI_SCREEN_WIDTH, 255-40+20);
        _datePicker.backgroundColor= [UIColor whiteColor];
        [_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];

        
        [_datePicker setDatePickerMode:UIDatePickerModeDate];        
        
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_datePicker];
    }
    return _datePicker;
}

- (void)showWithString:(NSString *)str withType:(DateType)type
{
    self.type=type;
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
    
    
    maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    
    [showWindow addSubview:self];
    
    [self initUI];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-BirthSelectV_Height, UI_SCREEN_WIDTH, BirthSelectV_Height);
    
    [UIView commitAnimations];
    
    if (str.length) {
        if (self.type==DateTypeDay) {
            NSDate *showDate = [PublicManager dateFromString1:str];
            if (showDate) {
                [self.datePicker setDate:showDate animated:YES];
            }
        }
        else
        {
            NSDate *showDate = [PublicManager dateFromString2:str];
            if (showDate) {
                [self.datePicker setDate:showDate animated:YES];
            }
        }
    }

}

- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, BirthSelectV_Height);
    [UIView commitAnimations];
}

- (void)initUI
{
    if (self.type==DateTypeDay) {
        [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    }
    else
    {
        [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    }
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [btn addTarget:self action:@selector(dateSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.right.equalTo(self).offset(-10);
    }];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.left.equalTo(self).offset(10);
    }];
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(40);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont boldSystemFontOfSize:16.0];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(btn);
    }];
    
    title.text = @"选择日期";
}

- (void)clearSubV
{
    [maskV removeFromSuperview];
    [self removeFromSuperview];
}

- (void)datePickerValueChanged:(UIDatePicker *)picker
{
//    self.didSelectDate([PublicManager stringFromDate:picker.date]);
}

- (void)dateSelected
{
    [self hide];
    
    NSString *str=@"";
    if (self.type==DateTypeDay) {
        str=[PublicManager string1FromDate:self.datePicker.date];
    }
    else
    {
        str=[PublicManager string2FromDate:self.datePicker.date];
    }
    
    self.didSelectDate(str);
}

@end
