//
//  PriceBottomVB.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PriceBottomVB : UIView
@property(nonatomic,copy)void(^placeOrderBlock)(void);   //下单
@property(nonatomic,copy)void(^praceDetailBlock)(void);     //价格明细

/**
 根据价格加载底部视图
 @param total 总价
 @param sale 优惠金额
 @param score 积分
 */
-(void)reloadUIWithTotalPrice:(NSInteger)total withSale:(NSInteger)sale withScore:(NSInteger)score;

@end

NS_ASSUME_NONNULL_END
