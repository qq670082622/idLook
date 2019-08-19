//
//  DatePickPopV.m
//  JxyDatePicker
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 fengzixiao. All rights reserved.
//

#import "DatePickPopV.h"
#import "JXYDatePicker.h"
#import "LJYDatePicker.h"
@interface DatePickPopV ()<JXYDatePickerDelegate,LJYDatePickerDelegate>
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)JXYDatePicker *JDatepicker;
@property(nonatomic,strong)LJYDatePicker *LJYDatePicker;
@end
@implementation DatePickPopV

- (void)showWithMinDate:(NSDate *)min maxDate:(NSDate *)max
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
    
    self.frame=CGRectMake(0, 0, showWindow.bounds.size.width, showWindow.bounds.size.height);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    
    UIView *maskV = [[UIView alloc] initWithFrame:CGRectMake(0,UI_SCREEN_HEIGHT,UI_SCREEN_WIDTH, 250)];
    maskV.backgroundColor = [UIColor whiteColor];
    maskV.alpha = 0.f;
    maskV.layer.borderColor=[UIColor grayColor].CGColor;
    maskV.layer.borderWidth=0.5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    [showWindow addSubview:self];
    [self addSubview:maskV];
    self.clipsToBounds=YES;
    self.maskV=maskV;
    
  
    _JDatepicker = [[JXYDatePicker alloc]initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, 250)WithMinimumDate:min maximumDate:max];
    _JDatepicker.delegate = self;
    [self.maskV addSubview:_JDatepicker];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.maskV.frame = CGRectMake(0,UI_SCREEN_HEIGHT-250,UI_SCREEN_WIDTH,250);
    
    [UIView commitAnimations];
}
-(void)showWithMinDate2:(NSDate *)min maxDate2:(NSDate *)max
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
    
    self.frame=CGRectMake(0, 0, showWindow.bounds.size.width, showWindow.bounds.size.height);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    
    UIView *maskV = [[UIView alloc] initWithFrame:CGRectMake(0,UI_SCREEN_HEIGHT,UI_SCREEN_WIDTH, 250)];
    maskV.backgroundColor = [UIColor whiteColor];
    maskV.alpha = 0.f;
    maskV.layer.borderColor=[UIColor grayColor].CGColor;
    maskV.layer.borderWidth=0.5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    [showWindow addSubview:self];
    [self addSubview:maskV];
    self.clipsToBounds=YES;
    self.maskV=maskV;

    _LJYDatePicker = [[LJYDatePicker alloc] initWithDatePicker:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width, 250) MinDate:min MaxDate:max];
    _LJYDatePicker.delegate = self;
    [self.maskV addSubview:_LJYDatePicker];
    _LJYDatePicker.layer.borderColor = [UIColor blackColor].CGColor;
    _LJYDatePicker.layer.borderWidth = 0.2;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.maskV.frame = CGRectMake(0,UI_SCREEN_HEIGHT-250,UI_SCREEN_WIDTH,250);
    
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
    
    self.maskV.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 180);
    
    [UIView commitAnimations];
}


#pragma mark --- JXYDatePickerDelegate
-(void)didSelectedDateString:(NSString *)dateString{
    NSLog(@"你点击了%@",dateString);
    if (self.dateString) {
        self.dateString(dateString);
    }
    [self hide];
}
-(void)cancelDatePicker{//两个picker公用这个返回方法
    NSLog(@"你点击了取消");
    [self hide];
}
#pragma mark ---LJYDelegate
-(void)selectsomedate:(NSDate*)currentdate andstring:(NSString*)datestring{
    
    NSLog(@"datestring:%@",datestring);
}
@end
