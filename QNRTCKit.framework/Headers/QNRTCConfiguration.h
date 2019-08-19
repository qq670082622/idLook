//
//  QNRTCConfiguration.h
//  QNRTCKit
//
//  Created by lawder on 2019/4/10.
//  Copyright © 2019 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNTypeDefines.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract 用来配置 RTC 的相关信息
 *
 * @since v2.2.0
 */
@interface QNRTCConfiguration : NSObject

/*!
 * @abstract 媒体流的连接方式，默认为 QNRTCPolicy
 *
 * @since v2.2.0
 */
@property (nonatomic, assign, readonly) QNRTCPolicy policy;

/*!
 * @abstract 是否使用立体声
 *
 * @since v2.3.0
 */
@property (nonatomic, assign, readonly) BOOL isStereo;

/*!
 * @abstract 带宽估计的策略
 *
 * @since v2.3.0
 */
@property (nonatomic, assign, readonly) QNRTCBWEPolicy bwePolicy;

/*!
 * @abstract 用默认参数生成一个对象
 *
 * @since v2.2.0
 */
+ (instancetype)defaultConfiguration;

/*!
 * @abstract 用给定的 policy 生成一个对象
 *
 * @since v2.2.0
 */
- (instancetype)initWithPolicy:(QNRTCPolicy)policy;

/*!
 * @abstract 用指定的参数生成一个对象
 *
 * @since v2.3.0
 */
- (instancetype)initWithPolicy:(QNRTCPolicy)policy stereo:(BOOL)isStereo;

/*!
 * @abstract 用指定的参数生成一个对象
 *
 * @since v2.3.0
 */
- (instancetype)initWithPolicy:(QNRTCPolicy)policy stereo:(BOOL)isStereo bwePolicy:(QNRTCBWEPolicy)bwePolicy;

@end

NS_ASSUME_NONNULL_END
