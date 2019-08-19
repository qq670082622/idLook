//
//  OrderDetialVCViewController.h
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "OrderProjectModel.h"

@interface OrderDetialVC : UIViewController
@property (nonatomic,copy)void(^isRefreshData)(void);

/**
 用户订单model
 */
@property(nonatomic,strong)OrderModel *orderModel;

/**
 项目订单model
 */
@property(nonatomic,strong)OrderProjectModel *projectModel;  

@end
