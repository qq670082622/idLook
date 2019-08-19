//
//  UIColor+ZYAdd.h
//  idolproject
//
//  Created by Joe on 16/5/7.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hexColors.h"
@interface UIColor (ZYAdd)
+ (UIColor *)colorWithHexString:(NSString *)string;
+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;
@end
