//
//  RoleServiceModel.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/12.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RoleServiceModel : NSObject

/**
 服务类型名称
 */
@property(nonatomic,copy)NSString *serviceTypeName;

/**
服务类型1:标准选角; 2:高端选角
 */
@property(nonatomic,assign)NSInteger serviceType;

/**
 人数
 */
@property(nonatomic,assign)NSInteger count;

/**
 订单ID
 */
@property(nonatomic,copy)NSString *orderId;

/**
 下单时间
 */
@property(nonatomic,copy)NSString *orderTime;

/**
 备注
 */
@property(nonatomic,copy)NSString *remark;

/**
 状态 0:新建; 1:已支付; 2:已完成; 3:已取消
 */
@property(nonatomic,assign)NSInteger status;

/**
 总价
 */
@property(nonatomic,assign)CGFloat totalPrice;

/**
 单价
 */
@property(nonatomic,assign)CGFloat unitPrice;

@end


