//
//  DatePickPopV.h
//  JxyDatePicker
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 fengzixiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatePickPopV : UIView
@property(nonatomic,copy)void(^dateString)(NSString *str);
//仅有年月日
-(void)showWithMinDate:(NSDate*)min maxDate:(NSDate*)max;
//年月日+时分
-(void)showWithMinDate2:(NSDate *)min maxDate2:(NSDate *)max;
@end

NS_ASSUME_NONNULL_END
