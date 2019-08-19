//
//  CouponGetPopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponGetPopV : UIView
@property(nonatomic,copy)void(^goUserBlock)(void);

- (void)showWithModel:(CouponModel*)model;
@end

NS_ASSUME_NONNULL_END
