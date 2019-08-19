//
//  MyOrderTotalPriceView.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/22.
//  Copyright © 2019年 HYH. All rights reserved.
//  cell中总价合计一栏

#import <UIKit/UIKit.h>
#import "OrderProjectModel.h"

@interface MyOrderTotalPriceView : UIView
/**
 评价或查看评价
 */
@property(nonatomic,copy)void(^evaluateOrderBlock)(void);

/**
申请开票
 */
@property(nonatomic,copy)void(^applyforInvoiceBlock)(void);

/**
 删除订单
 */
@property(nonatomic,copy)void(^delectOrderBlock)(void);

-(void)reloadUIWithTotalPrice:(NSInteger)price withProjectModel:(OrderProjectModel*)model;

@end

