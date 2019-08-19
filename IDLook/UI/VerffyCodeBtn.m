//
//  VerffyCodeBtn.m
//  IDLook
//
//  Created by HYH on 2018/7/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VerffyCodeBtn.h"

@interface VerffyCodeBtn()

@property(strong,nonatomic) NSTimer *timer;

@property(assign,nonatomic) NSInteger count;


@end

@implementation VerffyCodeBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 配置
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self setTitleColor:Public_Red_Color forState:UIControlStateNormal];

}
#pragma mark - 添加定时器
- (void)timeFailBeginFrom:(NSInteger)timeCount
{
    self.count = timeCount;
    self.enabled = NO;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];

}

#pragma mark - 定时器事件
- (void)timeDown
{
    if (self.count != 1){
        self.count -=1;
        self.enabled = NO;
        [self setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [self setTitle:[NSString stringWithFormat:@"%ld秒", self.count] forState:UIControlStateNormal];
    }
    else {
        self.enabled = YES;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        [self.timer invalidate];
        self.voiceCodeRefreshUI();
    }
}



@end