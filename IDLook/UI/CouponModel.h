//
//  CouponModel.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponModel : NSObject

/**
 券号
 */
@property(nonatomic,copy)NSString *couponCode;

/**
 券ID
 */
@property(nonatomic,assign)NSInteger couponId;

/**
 券类型   1:按比例返现
 */
@property(nonatomic,assign)NSInteger couponType;

/**
 是否优先使用
 */
@property(nonatomic,assign)BOOL firstPriority;

/**
 买家获取折扣
 */
@property(nonatomic,strong)NSNumber *rate;

/**
 分享人手机号
 */
@property(nonatomic,copy)NSString *sharePhone;

/**
  状态类型 1=可使用; 2=已使用; 5:未到使用时间; 10=已失效
 */
@property(nonatomic,assign)NSInteger status;

/**
 结束使用日期。空为不限。
 */
@property(nonatomic,copy)NSString *useEndDate;

/**
 开始使用日期。空为不限。
 */
@property(nonatomic,copy)NSString *useStartDate;

@end

NS_ASSUME_NONNULL_END
