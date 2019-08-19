//
//  NSDate+ZYAdd.m
//  idolproject
//
//  Created by 刘毅 on 16/3/14.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import "NSDate+ZYAdd.h"

@implementation NSDate (ZYAdd)
- (BOOL)compareWithDate:(NSDate *)date isMoreThanTimeInterval:(NSTimeInterval)timeInterval {
    if (!date) return NO;
    NSTimeInterval nowDate = self.timeIntervalSince1970;
    NSTimeInterval compareDate = date.timeIntervalSince1970;
    return (nowDate - compareDate) > timeInterval;
}

+ (BOOL)isMoreThanTimeInterval:(NSTimeInterval)timeInterval userDefaultsKey:(NSString *)key {
    NSUserDefaults *ZYUserDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastDate = [ZYUserDefaults objectForKey:key];
    NSDate *nowDate = [NSDate date];
    BOOL isMoreThan = lastDate ? NO : YES;
    NSTimeInterval nowDateTime = nowDate.timeIntervalSince1970;
    NSTimeInterval lastDateTime = lastDate.timeIntervalSince1970;
    isMoreThan = nowDateTime - lastDateTime > timeInterval;
    isMoreThan ? [ZYUserDefaults setObject:nowDate forKey:key] : nil;
    [ZYUserDefaults synchronize];
    return isMoreThan;
}
@end
