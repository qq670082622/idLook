//
//  OrderDBottomV.h
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

typedef NS_ENUM(NSInteger,OrderBottomActionType)
{
    OrderBottomActionTypeAccept,    //接单
    OrderBottomActionTypePayment,   //付款
    OrderBottomActionTypeUploadVide,  //上传视频
    OrderBottomActionTypeReorder,     //重新下单
    OrderBottomActionTypeFinish,    //完成订单
    
    OrderBottomActionTypePayOne,        //付首款
    OrderBottomActionTypeUploadCerti,   //上传授权书
    OrderBottomActionTypePayTwo,        //付尾款
    OrderBottomActionTypeReAudition,      //重新试镜
};

@protocol OrderDBottomDelegate<NSObject>

//接单,确认档期，上传试镜视频
-(void)acceptOrderWithType:(OrderBottomActionType)type;

//拒单
-(void)rejectOrder;

@end

@interface OrderDBottomV : UIView
@property(nonatomic,weak)id<OrderDBottomDelegate>delegate;
-(void)reloadUIWithModel:(OrderModel*)model;

@end
