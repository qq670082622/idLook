//
//  CouponPopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponPopV : UIView
@property(nonatomic,copy)void(^convertBlock)(void);
-(void)show;
@end

NS_ASSUME_NONNULL_END
