//
//  MyOrderCustomView.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "OrderProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderCustomView : UIView

/**
 选中订单
 */
@property(nonatomic,copy)void(^clickOrderBlock)(BOOL select);

/**
 查看订单详情回掉
 */
@property(nonatomic,copy)void(^MyOrderCustomViewlookOrderDetialBlock)(void);

/**
 取消订单
 */
@property(nonatomic,copy)void(^CancleOrderBlock)(void);

/**
 确认完成订单
 */
@property(nonatomic,copy)void(^finishedOrderBlock)(void);

/**
确认档期
*/
@property(nonatomic,copy)void(^confrimSchedBlock)(void);

/**
 筛选cell数据
 @param projectMdeol 项目数据模型
 @param orderModel 订单数据模型
 */
-(void)reloadUIWithProjectModel:(OrderProjectModel*)projectMdeol withOrderModel:(OrderModel*)orderModel;

@end

NS_ASSUME_NONNULL_END
