//
//  AskPriceView.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/15.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "AskPriceView.h"

@implementation AskPriceView

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)showWithTitle:(NSString *)title desc:(NSString *)desc leftBtn:(NSString *)left rightBtn:(NSString *)right phoneNum:(NSString *)num
{
    
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    
    if(!showWindow)return;
    //当window上有视图时移除
    for (UIView *view in showWindow.subviews) {
        if ([view isKindOfClass:[AskPriceView class]]) {
            return;
        }
    }
    
    [showWindow addSubview:self];
    
    self.frame = showWindow.frame;
    
    self.hidden = NO;
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    CGFloat y = (UI_SCREEN_HEIGHT-228)/2;
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(48,y, UI_SCREEN_WIDTH-96, 228);
    backView.layer.cornerRadius = 8;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;//@"咨询价格";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor colorWithHexString:@"#464646"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 16, backView.width, 24);
    [backView addSubview:titleLabel];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    line.frame = CGRectMake(0, 53, backView.width, 1);
    [backView addSubview:line];
    
    UILabel *tips = [[UILabel alloc] init];
    tips.text = desc;//@"此演员价格受拍摄日期，脚本影响较大，无固定价格。具体价格请拨打400-833-6969咨询脸探副导。";
    tips.numberOfLines = 0;
    tips.font = [UIFont systemFontOfSize:14];
    tips.textColor = [UIColor colorWithHexString:@"#464646"];
    tips.textAlignment = NSTextAlignmentLeft;
    tips.frame = CGRectMake(20, 66, backView.width-40, 67);
    [tips sizeToFit];
    [backView addSubview:tips];
    
    UIButton *cancel = [UIButton buttonWithType:0];
    [cancel setTitle:@"取消" forState:0];
    cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancel setTitleColor:Public_Red_Color forState:0];
    cancel.layer.borderColor = Public_Red_Color.CGColor;
    cancel.layer.borderWidth = 1;
    cancel.layer.cornerRadius = 6;
    cancel.layer.masksToBounds = YES;
    cancel.frame = CGRectMake((backView.width/2)-125, tips.bottom+30, 110, 44);
    [backView addSubview:cancel];
    [cancel addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *call = [UIButton buttonWithType:0];
    [call setTitle:@"立即拨打" forState:0];
    call.titleLabel.font = [UIFont systemFontOfSize:16];
    [call setTitleColor:[UIColor whiteColor] forState:0];
     [call setBackgroundColor:Public_Red_Color];
    call.layer.cornerRadius = 6;
    call.layer.masksToBounds = YES;
    call.frame = CGRectMake((backView.width/2)+15, tips.bottom+30, 110, 44);
    [backView addSubview:call];
        [call addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];

    CGFloat btnX = (UI_SCREEN_WIDTH-34)/2;
    CGFloat btnY = backView.bottom+20;
    closeBtm.frame = CGRectMake(btnX, btnY, 34, 34);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
    
    _phoneNum = num;
}
-(void)call
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"telprompt://%@",_phoneNum]]];
    //telprompt://4008336969
}

- (void)hide
{
    //    [self clearSubV];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
    
    [UIView commitAnimations];
}


@end
