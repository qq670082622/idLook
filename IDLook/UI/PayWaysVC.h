//
//  PayWaysVC.h
//  IDLook
//
//  Created by HYH on 2018/7/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface PayWaysVC : UIViewController
@property (nonatomic,copy)void(^refreshData)(void);

/**
 总价格
 */
@property(nonatomic,assign)NSInteger totalPrice;

/**
 订单号，多个订单号用逗号拼接
 */
@property(nonatomic,copy)NSString *orderids;

@property(nonatomic,assign)NSInteger orderType; //1是保险
@property(nonatomic,strong)NSDictionary *insuranceDic;
@property(nonatomic,copy)void(^insuranceSuccess)(void);
@end
