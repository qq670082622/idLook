//
//  UIButton+badgeNum.h
//  mvvm
//
//  Created by 吴铭 on 2018/12/27.
//  Copyright © 2018年 吴铭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (badgeNum)
- (void)setBadge:(NSString *)number andFont:(int)font;
@end

NS_ASSUME_NONNULL_END
