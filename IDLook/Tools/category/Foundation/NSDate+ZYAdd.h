//
//  NSDate+ZYAdd.h
//  idolproject
//
//  Created by 刘毅 on 16/3/14.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZYAdd)
- (BOOL)compareWithDate:(NSDate *)date isMoreThanTimeInterval:(NSTimeInterval)timeInterval;
+ (BOOL)isMoreThanTimeInterval:(NSTimeInterval)timeInterval userDefaultsKey:(NSString *)key;
@end
