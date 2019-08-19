//
//  CouponTopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponTopV : UIView

@property(nonatomic,copy)void(^convertBlock)(NSString *text);//兑换
@property(nonatomic,copy)void(^explainBlock)(void);//说明

@end

NS_ASSUME_NONNULL_END
