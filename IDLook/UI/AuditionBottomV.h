//
//  AuditionBottomV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuditionBottomV : UIView
@property(nonatomic,copy)void(^placeOrderBlock)(void);   //下单
@property(nonatomic,copy)void(^priceDetailBlock)(void);     //价格明细

/**
 加载底部试图
 @param price 价格
 */
-(void)reloadUIWithPrice:(NSString*)price;

@end

NS_ASSUME_NONNULL_END
