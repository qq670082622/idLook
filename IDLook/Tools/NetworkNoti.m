/*
 @header  NetworkNoti.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/30
 @description
 
 */

#import "NetworkNoti.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

static NetworkNoti *theNWNoti = nil;

@interface NetworkNoti ()
@property(nonatomic,assign)AFNetworkReachabilityStatus status;
@end

@implementation NetworkNoti

+(NetworkNoti*)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        theNWNoti = [[NetworkNoti alloc] init];
    });
    return theNWNoti;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        [self registryNetworkMonitoring];
    }
    
    return self;
}

- (void)registryNetworkMonitoring
{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.status=status;
        
        if(status==AFNetworkReachabilityStatusNotReachable)
        {
            NSLog(@"丢失网络信号");
        }
        else{
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"HomeVCReload" object:nil userInfo:nil];
            if(status==AFNetworkReachabilityStatusReachableViaWWAN)
            {
                NSString * netType=[self getMobileNetType];
                NSLog(@"%@",netType);
            }
            else if(status==AFNetworkReachabilityStatusReachableViaWiFi)
            {
                NSLog(@"wifi信号");
            }
            else if(status==AFNetworkReachabilityStatusUnknown)
            {
                NSLog(@"未知网络");
            }
        }
    }];
}

- (NSString *) getMobileNetType
{
    NSString *netconnType;
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
        netconnType = @"GPRS";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
        netconnType = @"2.75G EDGE";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
        netconnType = @"3.5G HSDPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
        netconnType = @"3.5G HSUPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
        netconnType = @"2G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
        netconnType = @"HRPD";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
        netconnType = @"4G";
    }
    return netconnType;
}

-(AFNetworkReachabilityStatus)getNetworkStatus
{
    return self.status;
}

@end
