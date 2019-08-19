/*
 @header  NetworkSettPopV.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/29
 @description
 
 */

#import "NetworkSettPopV.h"

@implementation NetworkSettPopV

- (id)init
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
    [UserInfoManager setNetworkSettingFirst:NO];
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
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(270, 310));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(15);
    }];
    titleLab.text=@"网络设置";
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
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
    descLab.font = [UIFont systemFontOfSize:14.0];
    descLab.textColor = [UIColor colorWithHexString:@"#666666"];
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(30);
        make.top.mas_equalTo(bg).offset(60);
    }];
    descLab.text=@"当前处于2G/3G/4G网络，继续播放 视频将消耗较多流量，建议在WIFI环境下使用 。";
    
   
    UIButton *autoPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    [autoPlay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [autoPlay setTitle:@"自动播放" forState:UIControlStateNormal];
    autoPlay.layer.masksToBounds=YES;
    autoPlay.layer.cornerRadius=22.0;
    autoPlay.layer.borderWidth=0.5;
    autoPlay.layer.borderColor =[UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    autoPlay.titleLabel.font=[UIFont systemFontOfSize:15];
    [autoPlay setTitleColor:Public_Red_Color forState:UIControlStateNormal];
    [autoPlay addTarget:self action:@selector(autoPlayAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:autoPlay];
    [autoPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(30);
        make.top.mas_equalTo(descLab.mas_bottom).offset(25);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *askBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [askBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [askBtn setTitle:@"每次播放时询问我" forState:UIControlStateNormal];
    askBtn.layer.masksToBounds=YES;
    askBtn.layer.cornerRadius=22.0;
    askBtn.layer.borderWidth=0.5;
    askBtn.layer.borderColor =[UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    askBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [askBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
    [askBtn addTarget:self action:@selector(askEachTime) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:askBtn];
    [askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(30);
        make.top.mas_equalTo(autoPlay.mas_bottom).offset(15);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.numberOfLines=0;
    lab.font = [UIFont systemFontOfSize:12.0];
    lab.textColor = [UIColor colorWithHexString:@"#999999"];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(askBtn.mas_bottom).offset(12);
    }];
    lab.text=@"（可在设置页面更改）";
}

-(void)autoPlayAction
{
    [UserInfoManager setWWanAuthPlay:YES];
    [self hide];
}

-(void)askEachTime
{
    [UserInfoManager setWWanAuthPlay:NO];
    [self hide];
}

@end
