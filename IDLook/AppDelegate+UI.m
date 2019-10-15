//
//  AppDelegate+UI.m
//  IDLook
//
//  Created by HYH on 2018/4/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "RootTabbarVC.h"
#import "LoginAndRegistVC.h"
#import "OpenUDID.h"
#import "CompleteInfoVC.h"
#import "AppUnablePopV.h"
#import "JPUSHService.h"
#import "VersionPopv.h"
#import "TypeSelectVC.h"
@implementation AppDelegate (UI)

-(void)initializeUI
{
//     [[TABViewAnimated sharedAnimated]initWithOnlySkeleton];
    
    
    [UserInfoManager setAskEachTime:YES];
    [UserInfoManager setPopupCoupon:YES];
    
    UserLoginType type = [UserInfoManager checkWhetherHasLogined];
    [AFWebAPI_JAVA getIsUserJavaServiceWithCallBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            BOOL useJava = object[@"body"][@"EnableJava"];
            if (useJava) {
                [UserInfoManager setIsJavaService:YES];
            }else{
                [UserInfoManager setIsJavaService:NO];
            }
        }
    }];
    if(type>=0)  //非游客，登录获取信息
    {
        //用户更新版本，而老版本没有token会导致鉴权失败，所以启动时获取token
        NSDictionary *param = @{@"mobile":[UserInfoManager getUserMobile],
                                @"password":MD5Str([UserInfoManager getUserPwd])
                                };
       [AFWebAPI_JAVA getTokenFromJavaService:param callBack:^(BOOL success, id  _Nonnull object) {//无论是不是java都要登陆，这个是获取token的唯一方法，有了token才能使用询问是否用java后端
            if (success) {
                NSLog(@"登陆成功");
                NSDictionary *tokenInfo = (NSDictionary *)object[@"body"][@"tokenInfo"];
                if (tokenInfo) {
                    NSString *token = tokenInfo[@"accessToken"];
                    NSString *refreshToken = tokenInfo[@"refreshToken"];
                    [UserInfoManager setAccessToken:token];
                    [UserInfoManager setRefreshToken:refreshToken];
                }
                
                UserInfoM *uinfo = [[UserInfoM alloc] initJavaDataWithDic:[object objectForKey:JSON_body]];
                [UserInfoManager setUserStatus:uinfo.status];
                [UserInfoManager setUserDiscount:uinfo.discount];
                [UserInfoManager setUserVip:uinfo.vipLevel];
                [self showRootVC];
               // [self processAutoLoginWithType:type];
                NSString *userId = [UserInfoManager getUserUID];
                if (userId.length>0) {
                    [JPUSHService setAlias:userId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                        
                    } seq:1];
                    
                }

           }else{
             //   [SVProgressHUD showErrorWithStatus:object];//@"账户不存在或密码已被修改"
            //    [UserInfoManager clearUserLoginfo];
             
             //   [self showLRVC];
             //   return ;
            }
        }];
    

    }
    else  //游客
    {
        [UserInfoManager clearUserLoginfo];
        [self showRootVC];
    }
    
    [self getPublicConfig];
  //  [self refereshToken];//刷新token  感觉这个接口没有意义
}
-(void)refereshToken
{
    NSString *beforeToken = [UserInfoManager getAccessToken];
    if (beforeToken.length>0) {
        NSDictionary *dic = @{@"refreshToken":[UserInfoManager getRefreshToken]};
        [AFWebAPI_JAVA refereshToken:dic callBack:^(BOOL success, id  _Nonnull object) {
         
                NSString *token = object[@"body"][@"accessToken"];
                NSString *refreshToken = object[@"body"][@"refreshToken"];
                [UserInfoManager setAccessToken:token];
                [UserInfoManager setRefreshToken:refreshToken];
            }];
        }
}

- (void)showRootVC
{
    WeakSelf(self);
//查询用户type
    [AFWebAPI_JAVA getUserTypeWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSInteger userDefinedType = [object[@"body"][@"userDefinedType"] integerValue];//户自定义类型 0=未选择 1=电商 2=制片 3=演员

            if (userDefinedType==0) {//没选择过
                TypeSelectVC *tsvc = [TypeSelectVC new];
                self.window.rootViewController = tsvc;
                [self.window reloadInputViews];
                [self.window makeKeyAndVisible];
                tsvc.selectType = ^(NSInteger type) {
                    NSDictionary * arg2 = @{@"userDefinedType":@(type)};
                    [AFWebAPI_JAVA setUserTypeWithArg:arg2 callBack:^(BOOL success, id  _Nonnull object) {
                        if (success) {
                               [WriteFileManager userDefaultSetObj:[NSString stringWithFormat:@"%ld",type] WithKey:@"userType"];
                            [weakself tabbarRoot];
                         }
                    }];
                };
            }else{
                 [WriteFileManager userDefaultSetObj:[NSString stringWithFormat:@"%ld",userDefinedType] WithKey:@"userType"];
                [self tabbarRoot];
            }
        }else{//请求失败默认一个电商
            [WriteFileManager userDefaultSetObj:@"1" WithKey:@"userType"];
            [self tabbarRoot];
        }
    }];
   
//    [self tabbarRoot];
//
//    RootTabbarVC *tabbarController =  (RootTabbarVC *)self.window.rootViewController;
//    [[[tabbarController.tabBar items] objectAtIndex:3] setBadgeValue:@"100"];
    
    
}
-(void)tabbarRoot
{
    RootTabbarVC *tabVC = [[RootTabbarVC alloc] init];
    self.window.rootViewController = tabVC;
    [self.window reloadInputViews];
    [self.window makeKeyAndVisible];
}
- (void)showLRVC
{
    LoginAndRegistVC *loginVC=[[LoginAndRegistVC alloc]init];
    loginVC.isHideClose=YES;
    self.window.rootViewController=loginVC;
    [self.window reloadInputViews];
    [self.window makeKeyAndVisible];
}

//完善资料
-(void)showCompetInfoVC
{
    CompleteInfoVC *completVC = [[CompleteInfoVC alloc]init];
    CustomNavVC *nav = [[CustomNavVC alloc]initWithRootViewController:completVC];
    self.window.rootViewController=nav;
    [self.window reloadInputViews];
    [self.window makeKeyAndVisible];

}

- (void)processAutoLoginWithType:(UserLoginType)type
{
    if(type==UserLoginTypeMobile)
    {
        NSDictionary *dicArg = @{@"mobile":[UserInfoManager getUserMobile],
                                 @"password":MD5Str([UserInfoManager getUserPwd]),
                                 @"uuid":[OpenUDID value],
                                 @"ver":Current_BundleVersion,
                                 @"channelid":LINK_ID,
                                 @"logintype":@(0),
                                 @"plat":@0};
        [AFWebAPI doLoginByMobileWithArg:dicArg callBack:^(BOOL success, id object) {
            if(success)
            {
                NSDictionary *dic = [object objectForKey:JSON_data];
                UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
                
                [UserInfoManager setUserLoginfo:uinfo];
                [UserInfoManager setUserLoginType:UserLoginTypeMobile];
                
                if ([UserInfoManager getUserType]==UserTypeResourcer)
                {
                    if ( [[UserInfoManager getUserRegion]length]==0 || [UserInfoManager getUserOccupation]==0 || [UserInfoManager getUserSex]<=0 ||[[UserInfoManager getUserNationality]length]==0 || [[UserInfoManager getUserRealName]length]==0 || [[UserInfoManager getUserBirth]length]==0 || ([UserInfoManager getUserOccupation]==1&&[UserInfoManager getUserMastery]==0)) {
                        [self showCompetInfoVC];
                    }
//                    else
//                    {
//                        [self showRootVC];
//                    }
                }
//                else
//                {
//                    [self showRootVC];
//                }
            }
            else
            {
                AF_SHOW_RESULT_ERROR
                if(object!=nil)
                {
                    NSString *msg = [(NSDictionary *)object objectForKey:JSON_msg];
                    if(msg!=nil)
                    {
                        [UserInfoManager clearUserLoginfo];
                        [self performSelector:@selector(showLRVC) withObject:object afterDelay:2.1];
                    }
                }
                else
                {
                    [self performSelector:@selector(showLRVC) withObject:object afterDelay:2.1];
                }
            }
        }];
    }
}

//获取公共基础配置
-(void)getPublicConfig
{
    //if ([UserInfoManager getIsJavaService]) {
        [AFWebAPI_JAVA getPublicConfig:[NSDictionary new] callBack:^(BOOL success, id object) {
            if (success) {
                NSDictionary *dic = [object objectForKey:JSON_body];
                [UserInfoManager setPublicConfig:dic];
                
                NSInteger runnable = [(NSNumber *)safeObjectForKey(dic, @"runnable") integerValue];;
                if (runnable==2) {
                    AppUnablePopV *popV = [[AppUnablePopV alloc]init];
                    [popV show];
                }
            }
            else
            {
                NSLog(@"获取公共基础配置失败,%@",object);// [SVProgressHUD showErrorWithStatus:@"获取公共基础配置失败"];
            }
        }];

//    }
//    else
//    {
//
//    [AFWebAPI getPublicConfig:nil callBack:^(BOOL success, id object) {
//        if (success) {
//            NSDictionary *dic = [object objectForKey:JSON_data];
//            [UserInfoManager setPublicConfig:dic];
//
//            NSInteger runnable = [(NSNumber *)safeObjectForKey(dic, @"runnable") integerValue];;
//            if (runnable==2) {
//                AppUnablePopV *popV = [[AppUnablePopV alloc]init];
//                [popV show];
//            }
//        }
//        else
//        {
//            AF_SHOW_RESULT_ERROR
//        }
//    }];
//    }
}


//检测app更新
-(void)updateApp
{
    //开辟一个子线程去请求苹果服务器
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 这是获取appStore上的app的版本的url
        NSString *appStoreUrl = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",STORE_APPID];
        
        NSURL *url = [NSURL URLWithString:appStoreUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                           timeoutInterval:10];
        
        [request setHTTPMethod:@"POST"];
        
        NSOperationQueue *queue = [NSOperationQueue new];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
            NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
            if (data) {
                
                NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                    
                    [receiveStatusDic setValue:@"1" forKey:@"status"];
                    [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
                }else{
                    
                    [receiveStatusDic setValue:@"-1" forKey:@"status"];
                }
            }else{
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
            });
        }];
    });  
}

-(void)receiveData:(id)sender
{
//    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    // 手机当前APP软件版本  比如：1.0.2
//    NSString *nativeVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *storeVersion  = sender[@"version"];
//    NSString *popVersion = [udf objectForKey:@"popversion"];
//    NSLog(@"本地版本号curV=%@",nativeVersion);
//    NSLog(@"商店版本号appV=%@", sender[@"version"]);
//
//
//    BOOL needPop = false; //需要弹窗
//    BOOL needUpdate = false;//弹窗需要升级按钮
//    NSComparisonResult comparisonResult = [popVersion compare:nativeVersion options:NSNumericSearch];
//    //NSOrderedSame相同 NSOrderedAscending = -1L表示升序;  NSOrderedDescending = +1 表示降序
//    switch (comparisonResult) {
//        case NSOrderedSame:
//            NSLog(@"弹窗版本与本地版本号相同，不需要更新");
//            break;
//        case NSOrderedAscending:
//            NSLog(@"弹窗版本号 < 本地版本号，需要更新");
//            // [self update];
//            needPop = YES;
//            [udf setObject:storeVersion forKey:@"popversion"];
//
//            break;
//        case NSOrderedDescending:
//            NSLog(@"弹窗版本号 > 本地版本号，不需要更新");
//            break;
//        default:
//            break;
//    }
//
//     NSComparisonResult comparisonResult2 = [nativeVersion compare:storeVersion options:NSNumericSearch];
//    //NSOrderedSame相同 NSOrderedAscending = -1L表示升序;  NSOrderedDescending = +1 表示降序
//    switch (comparisonResult2) {
//        case NSOrderedSame:
//            NSLog(@"本地版本与商店版本号相同，不需要更新");
//            break;
//        case NSOrderedAscending:
//            NSLog(@"本地版本号 < 商店版本号，需要更新");
//           // [self update];
//            needPop = YES;
//            needUpdate = YES;
//            break;
//        case NSOrderedDescending:
//            NSLog(@"本地版本号 > 商店版本号，不需要更新");
//            break;
//        default:
//            break;
//    }
//
//    if (needPop) {
//        VersionPopv *vp = [[VersionPopv alloc] init];
//        [vp showWithUpdate:YES andVersion:@"v1.4.2" andTips:@[@"2183621874681268",@"12312412412312sfdfsdf",@"nv839725v9823v9832nv79582v3b2359v8b62359v8b632598vb68923v69238bv6923bv692"]];
//        vp.update = ^{
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",STORE_APPID]];
//            [[UIApplication sharedApplication] openURL:url];
//        };
//    }
    
    [AFWebAPI_JAVA checkVersionWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *body = [object objectForKey:@"body"];
            BOOL prompt = [body[@"prompt"] boolValue];//新版内容弹窗
            BOOL update = [body[@"update"] boolValue];//更新样式弹窗
            NSString *version = body[@"version"];
            NSArray *desc = body[@"desc"];
            if (prompt || update) {

                        VersionPopv *vp = [[VersionPopv alloc] init];
                        [vp showWithUpdate:update andVersion:version andTips:desc];
                        vp.update = ^{
                            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",STORE_APPID]];
                            [[UIApplication sharedApplication] openURL:url];
                        };
                
            }
        }
    }];
}

//更新
-(void)update
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"发现新版本是否更新?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"去更新"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",STORE_APPID]];
                                                        [[UIApplication sharedApplication] openURL:url];
                                                    }];

    [alert addAction:action0];
    [self.window.rootViewController presentViewController:alert animated:YES completion:^{}];
}

@end
