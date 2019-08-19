/*
 @header  NetworkNoti.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/30
 @description
     网络监听
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkNoti : NSObject

+(NetworkNoti*)shareInstance;

/**
 获取网络状态
 @return 网络状态
 */
-(AFNetworkReachabilityStatus)getNetworkStatus;

@end

NS_ASSUME_NONNULL_END
