//
//  DeviceSettingManager.h
//  IDLook
//
//  Created by 吴铭 on 2019/2/28.
//  Copyright © 2019年 HYH. All rights reserved.
//专门处理设备唯一的设置。换账号也不变

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceSettingManager : NSObject
//新消息通知
+ (void)setMsgNotify:(BOOL)notify;
+ (NSInteger)getMsgNotify;


//声音
+ (void)setUserSoundOn:(BOOL)on;
+ (BOOL)getSoundStatus;

//震动
+ (void)setUserVibirateOn:(BOOL)on;
+ (BOOL)getUserVibirateStatus;
@end

NS_ASSUME_NONNULL_END
