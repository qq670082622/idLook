/*
 @header  PlayContinuePopV.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/29
 @description
 
 */

#import "PlayContinuePopV.h"

@implementation PlayContinuePopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)show
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
    
    [self initUI];
    
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

-(void)initUI
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH-40, 90));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.numberOfLines=0;
    titleLab.font = [UIFont systemFontOfSize:15.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(bg).offset(20);
        make.top.mas_equalTo(bg).offset(20);
    }];
    titleLab.text=@"您正在使用移动数据，是否要继续播放？";
    
    UIButton *Continue = [UIButton buttonWithType:UIButtonTypeCustom];
    [Continue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Continue setTitle:@"继续播放" forState:UIControlStateNormal];
    Continue.titleLabel.font=[UIFont systemFontOfSize:15];
    [Continue setTitleColor:Public_Red_Color forState:UIControlStateNormal];
    [Continue addTarget:self action:@selector(ContinueAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Continue];
    [Continue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg).offset(-20);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
    }];
    
    UIButton *StopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [StopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [StopBtn setTitle:@"停止播放" forState:UIControlStateNormal];
    StopBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [StopBtn setTitleColor:Public_DetailTextLabelColor forState:UIControlStateNormal];
    [StopBtn addTarget:self action:@selector(askEachTime) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:StopBtn];
    [StopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(Continue.mas_left).offset(-20);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
    }];
    
}

-(void)ContinueAction
{
    if (self.ContinueBlock) {
        self.ContinueBlock();
    }
    [UserInfoManager setAskEachTime:NO];
    [self hide];
}

-(void)askEachTime
{
    [self hide];
}


@end