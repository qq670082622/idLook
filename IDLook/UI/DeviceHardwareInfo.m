//
//  DeviceHardwareInfo.m
//  Ailiao
//
//  Created by Ailiao04 on 13-2-21.
//
//

#import "DeviceHardwareInfo.h"
#include <sys/utsname.h>

@implementation DeviceHardwareInfo

+ (NSString*)deviceString
{
    
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([deviceString isEqualToString:@"iPhone8,1"])   return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])   return @"iPhone 6S Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([deviceString isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([deviceString isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([deviceString isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([deviceString isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([deviceString isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([deviceString isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([deviceString isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([deviceString isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([deviceString isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([deviceString isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([deviceString isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([deviceString isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([deviceString isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([deviceString isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([deviceString isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([deviceString isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([deviceString isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([deviceString isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([deviceString isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([deviceString isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([deviceString isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([deviceString isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return deviceString;
}


static const char* jailbreak_apps[] =
{
    "/Applications/Cydia.app",
    "/Applications/limera1n.app",
    "/Applications/greenpois0n.app",
    "/Applications/blackra1n.app",
    "/Applications/blacksn0w.app",
    "/Applications/redsn0w.app",
    "/Applications/Absinthe.app",
    NULL,
};

+ (NSString *)isJailBroken
{
    NSString *isJail;
    isJail = @"UNPB";//非越狱
    for (int i = 0; jailbreak_apps[i] != NULL; ++i)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_apps[i]]])
        {
            isJail = @"PB";//越狱
        }
    }
    return isJail;
}

+ (BOOL)isJailBrokenBool
{
    if([[DeviceHardwareInfo isJailBroken] isEqualToString:@"PB"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isVersionPB
{
    BOOL retBool=NO;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSArray *subStr=[app_build componentsSeparatedByString:@"."];
    if ([subStr count]>=3)
    {
        int num3=[[subStr objectAtIndex:2] intValue];
        if (num3%2!=0)
        {
            retBool=YES;
        }
        else
        {
            retBool=NO;
        }
    }
    
    return retBool;
}

+ (BOOL)isGetSystemCallLog
{
    BOOL retBool=NO;
    if ([DeviceHardwareInfo isVersionPB]==YES && [DeviceHardwareInfo isJailBrokenBool]==YES)
    {
        retBool=YES;
    }
    else
    {
        retBool=NO;
    }
    
    return retBool;
}

+ (BOOL)isIpad
{
    NSString *str = [DeviceHardwareInfo deviceString];
    NSRange rangeIpad = [str rangeOfString:@"iPad"];
    if(rangeIpad.length)
        return YES;
    return NO;
}

+ (BOOL)isIphone4
{
    NSString *str = [DeviceHardwareInfo deviceString];
    NSRange rangeIph4 = [str rangeOfString:@"iPhone 4"];
    if(rangeIph4.length)
        return YES;
    return NO;
}

+ (BOOL)isIphone4s
{
    NSString *str = [DeviceHardwareInfo deviceString];
    NSRange rangeIph4 = [str rangeOfString:@"iPhone 4s"];
    if(rangeIph4.length)
        return YES;
    return NO;
}

+ (BOOL)isIphone5
{
    NSString *str = [DeviceHardwareInfo deviceString];
    NSRange rangeIph5 = [str rangeOfString:@"iPhone 5"];
    if(rangeIph5.length)
        return YES;
    return NO;
}

+ (BOOL)gameHallShouldHideKeyBoard
{
    if([DeviceHardwareInfo isIpad]||[DeviceHardwareInfo isIphone4]||[DeviceHardwareInfo isIphone4s])
    {
        return YES;
    }
    return NO;
}



@end