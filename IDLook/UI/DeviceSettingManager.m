//
//  DeviceSettingManager.m
//  IDLook
//
//  Created by 吴铭 on 2019/2/28.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "DeviceSettingManager.h"

@implementation DeviceSettingManager
//新消息通知
+ (void)setMsgNotify:(BOOL)notify
{
    [[NSUserDefaults standardUserDefaults] setBool:notify forKey:[NSString stringWithFormat:@"NewMsg"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getMsgNotify
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"NewMsg"]];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//声音
+ (void)setUserSoundOn:(BOOL)on
{
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:[NSString stringWithFormat:@"sound"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getSoundStatus;
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"sound"]];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//震动
+ (void)setUserVibirateOn:(BOOL)on
{
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:[NSString stringWithFormat:@"vibirate"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getUserVibirateStatus
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"vibirate"]];
    if(obj==nil)return YES;
    return [obj boolValue];
}
@end
