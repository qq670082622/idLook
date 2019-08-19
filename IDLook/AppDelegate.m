//
//  AppDelegate.m
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AlipaySDK/AlipaySDK.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <Bugly/Bugly.h>
#import "WXApi.h"
#import "WXApiManager.h"
#import "JPUSHService.h"
#import "OpenInstallSDK.h"
//#import <LinkedME_iOS/LinkedME.h>
#import "RootTabbarVC.h"
#import "WriteFileManager.h"
@interface AppDelegate ()<JPUSHRegisterDelegate,OpenInstallDelegate>//
@property(nonatomic,assign)NSInteger annuciateId_push;
@property(nonatomic,strong)NSString *bannerUrl;
@end

static NSString *channel = @"Publish channel";
static BOOL isProduction = TRUE;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    // 启动图片延时: 3秒
//    [NSThread sleepForTimeInterval:3];
    self.window.backgroundColor = [UIColor whiteColor];

    [self initializeUI];
    [NetworkNoti shareInstance];
 
//    //极光远推
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];

    //如不需要使用IDFA，advertisingIdentifier 可为nil0
    NSString * advertisingId=nil;
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    //bugly 崩溃分析
     [Bugly startWithAppId:BuglyAppKey];
    
    [UMConfigure initWithAppkey:UMAppKey channel:@"App Store"];

    [MobClick setScenarioType:E_UM_NORMAL];
    
    //向微信注册
    [WXApi registerApp:WXAppKey];
    
    [self configUSharePlatforms];
    
    //deeplink 唤醒
   [OpenInstallSDK initWithDelegate:self];
    //带参数安装启动回调
    [[OpenInstallSDK defaultManager] getInstallParmsCompleted:^(OpeninstallData*_Nullable appData) {
        if ([UserInfoManager getFirstLauch]) {
            NSString *uid = [appData.data objectForKey:@"artistid"];
            if (uid.length>0) {
                [self postNotifacationWithUID:[appData.data objectForKey:@"artistid"]];
            }
 
            NSString *type = [appData.data objectForKey:@"type"];
            if ([type isEqualToString:@"returnCode"]) {
                NSString *returnCode = appData.data[@"returnCode"];
                [self postNotifacationWithUID:[NSString stringWithFormat:@"returnCode=%@",returnCode]];
            }
        
            if ([type isEqualToString:@"annunciateList"]) {
                [self postNotifacationWithUID:@"annunciateId="];
            }else if ([type isEqualToString:@"annunciateDetail"]){
                NSString *annunciateId = [appData.data objectForKey:@"annunciateId"];
                [self postNotifacationWithUID:[NSString stringWithFormat:@"annunciateId=%@",annunciateId]];
            }
            if ([type containsString:@"banner"]) {
                [self postNotifacationWithUID:[appData.data objectForKey:@"pageId"]];
            }
            }
            [UserInfoManager setFirstLauch];
        }];
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
   NSArray *ak = [remoteNotification allKeys];
    if (ak.count>0) {
        
        NSString *type = remoteNotification[@"type"];
        if ([type isEqualToString:@"annunciate_list"]) {
            _annuciateId_push=-1;
           }
        if ([type isEqualToString:@"annunciate_details"]) {
                    NSInteger annunciateId = [remoteNotification[@"pageId"] integerValue];
                    if (annunciateId>0) {
                        self.annuciateId_push = annunciateId;
                    }
        }
        if ([type containsString:@"banner"]) {
           self.bannerUrl = [remoteNotification objectForKey:@"pageId"];
        }

   }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    return YES;
}
//通过OpenInstall获取已经安装App被唤醒时的参数（如果是通过渠道页面唤醒App时，会返回渠道编号）
-(void)getWakeUpParams:(OpeninstallData *)appData{
     NSString *uid = [appData.data objectForKey:@"artistid"];
    if (uid.length>0) {
        [self postNotifacationWithUID:[appData.data objectForKey:@"artistid"]];
    }
   
  NSString *type = [appData.data objectForKey:@"type"];
    if ([type isEqualToString:@"returnCode"]) {
        NSString *returnCode = appData.data[@"returnCode"];
        [self postNotifacationWithUID:[NSString stringWithFormat:@"returnCode=%@",returnCode]];
    }
    
    if ([type isEqualToString:@"annunciateList"]) {
    [self postNotifacationWithUID:@"annunciateId="];
    }else if ([type isEqualToString:@"annunciateDetail"]){
        NSString *annunciateId = [appData.data objectForKey:@"annunciateId"];
       [self postNotifacationWithUID:[NSString stringWithFormat:@"annunciateId=%@",annunciateId]];
    }

}
-(void)postNotifacationWithUID:(NSString *)UID
{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"HomeVCPush" object:UID userInfo:nil];
}
- (void)configUSharePlatforms
{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppKey appSecret:WXAppSecret redirectURL:nil];
//    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_Sina appKey:SNAppkey appSecret:SNAppSecret redirectURL:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{//在前台
    [JPUSHService handleRemoteNotification:userInfo];
  
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{//启动在后台时 此处获得通知内容
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    UIApplicationState state2 = [UIApplication sharedApplication].applicationState;
    BOOL result2 = (state2 ==UIApplicationStateActive);
    if (result2) {//防止程序在前台仍跳转
        return;
    }
    NSString *type = userInfo[@"type"];
    if ([type isEqualToString:@"annunciate_list"]) {
       [self postNotifacationWithUID:@"annunciateId="];
        return;
        }
    if ([type isEqualToString:@"annunciate_details"]) {
        NSInteger annunciateId = [userInfo[@"pageId"] integerValue];
        if (annunciateId>0) {
            [self postNotifacationWithUID:[NSString stringWithFormat:@"annunciateId=%ld",annunciateId]];
        }
    }
    if ([type containsString:@"banner"]) {
        [self postNotifacationWithUID:[NSString stringWithFormat:@"banner_%@",userInfo[@"pageId"]]];
    }
   
   
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}
#pragma mark- JPUSHRegisterDelegate  自定义消息核心代码
// iOS 10 Support app启动且在后台调用此函数
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
     NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"];
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(NSInteger))completionHandler
{ NSDictionary * userInfo = response.notification.request.content.userInfo;

    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
     }
   completionHandler(UNNotificationPresentationOptionSound);// 系统要求执行这个方法
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //app进入前台检查更新
    [self updateApp];
    if (_annuciateId_push>0) {
        [self postNotifacationWithUID:[NSString stringWithFormat:@"annunciateId=%ld",_annuciateId_push]];
        _annuciateId_push = 0;
    }else if(_annuciateId_push==-1){//-1指弹跳到列表
         [self postNotifacationWithUID:@"annunciateId="];
    }
    if (_bannerUrl.length>0) {
        [self postNotifacationWithUID:[NSString stringWithFormat:@"banner_%@",_bannerUrl]];
        _bannerUrl = @"";
    }
    //点击通知栏启动在此处处理finishLauch的值 。另外两处就是启动中在前台、后台
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//9.0以前
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result == %@",resultDic);
        }];
    }
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    if  ([OpenInstallSDK handLinkURL:url]){//必写
        return YES;
    }
   
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result == %@",resultDic);
            
            NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"] integerValue];   //支付结果
            if (resultStatus==9000) { //支付成功,通知去筛选页面
                [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:nil];
            }
        }];
    }
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    if  ([OpenInstallSDK handLinkURL:url]){//必写
        return YES;
    }
   
    return [[UMSocialManager defaultManager] handleOpenURL:url];//YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"pay"]) {
        return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
   // NSLog(@"userActivity : %@",userActivity.webpageURL.description);
    //判断是否通过OpenInstall Universal Link 唤起App
    if ([OpenInstallSDK continueUserActivity:userActivity]){//如果使用了Universal link ，此方法必写
        return YES;
    }
 
    return YES;
}


@end
