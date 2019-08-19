//
//  BirthSelectV.h
//  VoiceGame
//
//  Created by wsz on 15/5/29.
//  Copyright (c) 2015年 VoiceGame. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DateType)
{
    DateTypeDay,     //到天
    DateTypeMinute   //到分钟
};

@interface BirthSelectV : UIView

@property (nonatomic,copy)void(^didSelectDate)(NSString *dateStr);


/**
 根据类型显示日期选择骑
 @param str 日期
 @param type 类型
 */
- (void)showWithString:(NSString*)str withType:(DateType)type;

@end

