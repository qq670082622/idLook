//
//  PriceDetailBottomV.h
//  IDLook
//
//  Created by HYH on 2018/6/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceDetailBottomV : UIView
@property(nonatomic,copy)void(^placeOrderBlock)(void);   //下单
@property(nonatomic,copy)void(^praceDetailBlock)(void);     //价格明细


/**
 根据价格加载底部视图
 @param price 价格
 @param type 类型   0:试镜  1:拍摄
 */
-(void)reloadUIWithPrice:(NSString*)price WithType:(NSInteger)type;

@end
