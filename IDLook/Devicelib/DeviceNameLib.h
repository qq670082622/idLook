//
//  DeviceNameLib.h
//  DeviceNameLib
//
//  Created by zhangcong on 2017/10/12.
//  Copyright © 2017年 zhangcong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceNameLib : NSObject

/**
 生成一串用于标识设备唯一的deviceId

 @return 设备id
 */
+ (NSString *)deviceId;


/**
 重置当前设备deviceId
 */
+ (void)removeDeviceId;


/**
 设备名称

 @return 设备名称 （iPhone 6 ，iPhone 7等等）
 */
+ (NSString *)deviceName;

@end
