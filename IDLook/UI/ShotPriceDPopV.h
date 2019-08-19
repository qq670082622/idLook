//
//  ShotPriceDPopV.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShotPriceDPopV : UIView


/**
 是否加载视图
 @param isLoading 是否加载
 @param model 模型
 @param dic 订单价格info
 */
-(void)showWithLoad:(BOOL)isLoading withModel:(OrderStructM*)model withPriceInfo:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
