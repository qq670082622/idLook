//
//  CalenderPopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CalenderPopV.h"
#import "CalendarView.h"

@interface CalenderPopV ()<CalenderViewDelete>
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,strong)UILabel *dateLab;

@property (nonatomic, copy) NSString *startDay;
@property (nonatomic, copy) NSString *endDay;
@property (nonatomic,assign)NSInteger type;
@end

@implementation CalenderPopV

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight)];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showWithType:(NSInteger)type withStart:(NSString *)start withEnd:(NSString *)end withSelectStart:(NSString *)selectStart withSelectEnd:(NSString *)selectEnd
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
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    self.maskV=maskV;
    
    [showWindow addSubview:self];
    
    [self initUIWithType:type withStart:start withEnd:end withSelectStart:selectStart withSelectEnd:selectEnd];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0,SafeAreaTopHeight, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight);
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
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight);
    [UIView commitAnimations];
}

- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}


-(void)initUIWithType:(NSInteger)type withStart:(NSString *)start withEnd:(NSString *)end withSelectStart:(NSString *)selectStart withSelectEnd:(NSString *)selectEnd
{
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(13);
    }];
    title.text=@"选择拍摄日期";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title).offset(0);
        make.right.equalTo(self).offset(-15);
    }];
    
    CalendarView *calenderV = [[CalendarView alloc]init];
    calenderV.startDay=start;
    calenderV.endDay=end;
    calenderV.type=type;
    calenderV.selectedStartDate=selectStart;
    calenderV.selectedEndDate=selectEnd;
    calenderV.delegate=self;
    [self addSubview:calenderV];
    [calenderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(48);
        make.bottom.mas_equalTo(self).offset(-116-SafeAreaTabBarHeight_IphoneX);
    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    confirmBtn.backgroundColor=Public_Red_Color;
    confirmBtn.layer.masksToBounds=YES;
    confirmBtn.layer.cornerRadius=5.0;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-SafeAreaTabBarHeight_IphoneX-30);
        make.left.mas_equalTo(self).offset(15);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(48);
    }];
    
    UILabel *dateLab = [[UILabel alloc] init];
    dateLab.font = [UIFont systemFontOfSize:14.0];
    dateLab.textColor = Public_Red_Color;
    dateLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).offset(-125);
        make.bottom.mas_equalTo(confirmBtn.mas_top).offset(-10);
    }];
    dateLab.text=@"拍摄日期：请选择拍摄日期";
    self.dateLab=dateLab;
}

-(void)confirmAction
{
    if (self.startDay.length==0&&self.endDay.length==0) {
        [SVProgressHUD showImage:nil status:@"请选择日期"];
        return;
    }
    
    if (self.CalenderPopVBlock) {
        self.CalenderPopVBlock(self.startDay, self.endDay);
    }
    
    [self hide];
}

#pragma mark--CalenderViewDelete
-(void)calenderViewStartDateString:(NSString *)startDate withEndDateString:(NSString *)endDate
{
    self.startDay=startDate;
    self.endDay=endDate;
    if (self.type==0) {
        self.dateLab.text=[NSString stringWithFormat:@"拍摄日期：%@",startDate.length>0?startDate:@"请选择拍摄日期"];
    }
    else
    {
        if (startDate.length==0&& endDate.length==0) {
            self.dateLab.text =@"拍摄日期：请选择拍摄日期";
        }
        else
        {
            self.dateLab.text = [NSString stringWithFormat:@"拍摄日期：%@至%@",startDate,endDate];
        }
    }
}

@end
