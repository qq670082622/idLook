//
//  VerffyCodeBtn.h
//  IDLook
//
//  Created by HYH on 2018/7/6.
//  Copyright © 2018年 HYH. All rights reserved.
//  验证码倒计时button

#import <UIKit/UIKit.h>

@interface VerffyCodeBtn : UIButton

/**
 语音验证
 */
@property(nonatomic,copy)void(^voiceCodeRefreshUI)(void);

/**
 开始倒计时
 @param timeCount 倒计时秒数
 */
- (void)timeFailBeginFrom:(NSInteger)timeCount;

@end
