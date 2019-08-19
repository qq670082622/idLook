//
//  ScheduleWayPopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/7.
//  Copyright © 2019年 HYH. All rights reserved.
//   锁档方式弹窗

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"


@interface ScheduleWayPopV : UIView
@property(nonatomic,copy)void(^auditionWayChooseWithModel)(OrderStructM *OrderM);   //试镜方式选择回掉
@property(nonatomic,copy)void(^lookScheduleBlock)(void);   //档期预约金

-(void)showWithOrderM:(OrderStructM*)model withPrice:(NSString*)price;

@end

@interface ScheduleWayPopCell : UIView
-(void)reloadUIWithOrderM:(OrderStructM*)model;
@end
