//
//  OrderSchedulePopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/12.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "OrderSchedulePopV.h"

@interface OrderSchedulePopV ()

@end

@implementation OrderSchedulePopV

-(id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        
    }
    return self;
}

- (void)showPopVWithType:(NSInteger)type
{
    
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    [self initUIWithType:type];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}


- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
}

-(void)initUIWithType:(NSInteger)type
{
    NSString *title;
    NSString *desc;
    NSString *confrimTitle;
    CGFloat height=0;
    if (type==0) {  //无档期
        title=@"无档期";
        desc=@"您确认无档期后，系统将直接回复给买家，订单立即失效，确定要按此选择回复买家么？";
        height=220;
        confrimTitle=@"确认";
    }
    else if (type==1)  //确认档期
    {
        title=@"确认档期";
        desc=@"您确认档期后，系统将直接回复给买家，订单立即生效，确定要按此选择回复买家么？";
        height=220;
        confrimTitle=@"确认";
    }
    else if (type==2) //传照片
    {
        title=@"确认档期";
        desc=@"买家需要查看您的近照，请在上传近照后再点击确认档期。";
        height=196;
        confrimTitle=@"去上传";
    }
    
    
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(280,height));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(15);
    }];
    titleLab.text=title;
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(45);
        make.height.mas_equalTo(0.5);
    }];
    
    MLLabel *descLab = [[MLLabel alloc] init];
    descLab.numberOfLines=0;
    descLab.lineSpacing=5.0;
    descLab.font=[UIFont systemFontOfSize:14.0];
    descLab.textColor=Public_Text_Color;
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg).offset(-18);
        make.left.mas_equalTo(bg).offset(18);
        make.top.mas_equalTo(bg).offset(65);
    }];
    descLab.text=desc;
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.layer.masksToBounds=YES;
    cancleBtn.layer.cornerRadius=4;
    cancleBtn.backgroundColor=[UIColor whiteColor];
    cancleBtn.layer.borderColor=Public_Red_Color.CGColor;
    cancleBtn.layer.borderWidth=1.0;
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [cancleBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg.mas_centerX).offset(-5);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];

    
    UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confrimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confrimBtn setTitle:confrimTitle forState:UIControlStateNormal];
    confrimBtn.layer.masksToBounds=YES;
    confrimBtn.layer.cornerRadius=4;
    confrimBtn.backgroundColor=Public_Red_Color;
    confrimBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [confrimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confrimBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confrimBtn];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_centerX).offset(5);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
}

-(void)agreeAction
{
    [self hide];
    if (self.confrimBlock) {
        self.confrimBlock();
    }
}

@end
