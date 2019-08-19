//
//  OrderSchedulePopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/6/12.
//  Copyright © 2019 HYH. All rights reserved.
//   确认档期/无档期弹窗

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderSchedulePopV : UIView
@property(nonatomic,copy)void(^confrimBlock)(void);

/**
 显示弹窗
 @param type  类型  1:无档期。2:有档期。3:传照片
 */
-(void)showPopVWithType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
