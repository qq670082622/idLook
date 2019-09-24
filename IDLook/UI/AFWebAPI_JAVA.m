//
//  AFWebAPI_JAVA.m
//  IDLook
//
//  Created by 吴铭 on 2019/2/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "AFWebAPI_JAVA.h"
#import "CJSONDeserializer.h"
#import "OpenUDID.h"
#import "DeviceNameLib.h"
@implementation AFWebAPI_JAVA
//////////////////////////////////java后台用///////////////////////////////////////////
//普通post
+ (void)postWithUrl:(NSString *)url
             params:(NSDictionary *)params
            success:(void (^)(NSDictionary *contentDic))success
            failure:(void (^)(NSString *errorStr))failure
{
    
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
//    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"AccessToken"];
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"IOS%@",phoneVersion] forHTTPHeaderField:@"DeviceType"];
//    [manager.requestSerializer setValue:GetLocalAddress() forHTTPHeaderField:@"IPAddress"];
//    [manager.requestSerializer setValue:Current_BundleVersion forHTTPHeaderField:@"Version"];
    
 
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (params!=nil) {
        [dic setObject:params forKey:@"body"];
    }
    NSString *url2 = [NSString stringWithFormat:@"%@%@",java_url,url];
    NSMutableDictionary *header = [NSMutableDictionary new];
    NSString *tokenStr =  [UserInfoManager getAccessToken];
     UserLoginType type = [UserInfoManager checkWhetherHasLogined];
    if (tokenStr.length>0 && ![url isEqualToString:@"auth/login"] && type>=0 && ![url isEqualToString:@"getPublicConfig"]) {//没有登录时/游客/登陆接口/publicConfig接口 不传token 所以此处做个判断
        [header setObject:tokenStr forKey:@"accessToken"];
           [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",tokenStr] forHTTPHeaderField:@"authorization"];
    }
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    [header setObject:[NSString stringWithFormat:@"IOS %@",phoneVersion] forKey:@"deviceType"];
    NSString *ipAdress = GetLocalAddress();
    [header setObject:ipAdress forKey:@"ipAddress"];
     [header setObject:Current_BundleVersion forKey:@"version"];
    [header setObject:[[DeviceNameLib deviceId]stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:@"deviceToken"];
     [dic setObject:header forKey:@"header"];
    [manager POST:url2 parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject[@"header"];
        NSString *message = dic[@"message"];
        if ([message isEqualToString:@"SUCCESS"]) {
            success(responseObject);
        }else{
            failure(message);
        }
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"__________post失败_______url:%@_______error:%@________",url2,error);
        failure(@"连接服务器失败");
    }];
}
//单个图片的上传
+(void)singleFileUploadWithParams:(NSDictionary *)params
                             data:(NSData *)data
                              url:(NSString*)url
                          success:(void(^)(AFHTTPRequestOperation *op, NSDictionary *contentDic))success
                          failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{

    NSString *url2 = [NSString stringWithFormat:@"%@%@",java_url,url];
    NSMutableDictionary *dic = [params mutableCopy];
     [dic setObject:[UserInfoManager getAccessToken] forKey:@"token"];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url2 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(data.length>0){
       [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.jpeg",data.length] mimeType:@"image/jpeg"];
        }
    } error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *task = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSString *msg = responseObject[@"header"][@"message"];
            if (![msg isEqualToString:@"SUCCESS"]) {
                failure(nil,[NSError new]);
                NSLog(@"无error上传失败");
            }else{
                success(nil,responseObject);
            }

        }else{
            failure(nil,error);
            NSLog(@"有error上传失败");
        }
    }];
    [task resume];
  

}
//单个图片的上传
+(void)singleFileUploadWithParams2:(NSDictionary *)params
                             data:(NSData *)data
                              url:(NSString*)url
                          success:(void(^)(AFHTTPRequestOperation *op, NSDictionary *contentDic))success
                          failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    
    NSString *url2 = [NSString stringWithFormat:@"%@%@",java_url,url];
    NSMutableDictionary *dic = [params mutableCopy];
    [dic setObject:[UserInfoManager getAccessToken] forKey:@"token"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 120;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url2 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
       // NSInteger datalen=[data length];
        if(![data length])return;
        
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.jpeg",data.length] mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *err;
        NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        NSLog(@"上传返回:%@",dic2);
        success(nil,dic2);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}
//单个视频的上传
+(void)singleVideoUploadWithParams:(NSDictionary *)params
                             data:(NSData *)data
                              url:(NSString*)url
                          success:(void(^)(AFHTTPRequestOperation *op, NSDictionary *contentDic))success
                          failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    
    NSString *url2 = [NSString stringWithFormat:@"%@%@",java_url,url];
    NSMutableDictionary *dic = [params mutableCopy];
    [dic setObject:[UserInfoManager getAccessToken] forKey:@"token"];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url2 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(data.length>0){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.mov",data.length] mimeType:@"video/quicktime"];
        }
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *task = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSString *msg = responseObject[@"header"][@"message"];
            if (![msg isEqualToString:@"SUCCESS"]) {
                failure(nil,[NSError new]);
            }else{
                success(nil,responseObject);
            }
            success(nil,responseObject);
        }else{
            failure(nil,error);
        }
    }];
    [task resume];
}

//多个图片的上传
+(void)multiplePhotoUploadWithParams:(NSDictionary *)params
                                 url:(NSString*)url
                               imageDic:(NSDictionary*)imageDic
                             success:(void(^)(AFHTTPRequestOperation *op, NSDictionary *contentDic))success
                             failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    
    NSString *url2 = [NSString stringWithFormat:@"%@%@",java_url,url];
    NSMutableDictionary *dic = [params mutableCopy];
    [dic setObject:[UserInfoManager getAccessToken] forKey:@"token"];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer.timeoutInterval = 300;
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    //    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//
//    [manager POST:url2 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//         NSArray *array = [imageDic allKeys];
//        for (int i =0; i<array.count; i++) {
//            UIImage *image = [imageDic objectForKey:array[i]];
//            NSData *data =  UIImageJPEGRepresentation(image, 1.0);
//            if(![data length])return;
//            [formData appendPartWithFileData:data name:array[i] fileName:@".png" mimeType:@"image/png"];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *msg = responseObject[@"header"][@"message"];
//        if (![msg isEqualToString:@"SUCCESS"]) {
//            failure(nil,[NSError new]);
//            NSLog(@"无error上传失败");
//        }else{
//            success(nil,responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//       failure(nil,error);
//    }];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url2 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *array = [imageDic allKeys];
        for (int i =0; i<array.count; i++) {
            UIImage *image = [imageDic objectForKey:array[i]];
            NSData *data =  UIImageJPEGRepresentation(image, 1.0);
            if(![data length])return;
            [formData appendPartWithFileData:data name:array[i] fileName:[NSString stringWithFormat:@"%ld.png",data.length] mimeType:@"image/png"];
        }
    } error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *task = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSString *msg = responseObject[@"header"][@"message"];
            if (![msg isEqualToString:@"SUCCESS"]) {
                failure(nil,[NSError new]);
                NSLog(@"无error上传失败");
            }else{
                success(nil,responseObject);
            }

        }else{
            failure(nil,error);
            NSLog(@"有error上传失败");
        }
    }];
    [task resume];
}


/*******************************************注册、登陆及密码***************************************/
//未登录找回密码
+ (void)doFindPasswordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"auth/reset" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//已登录修改密码
+ (void)doModifPasswordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"auth/change" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取基础配置
+ (void)getPublicConfig:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/getPublicConfig" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取当前版本信息。新增接口，之前没有
+ (void)getCurrentVersionInfo:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/versionInfo" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//动态配置获取(目前功能是：是不是启用java后台)
+ (void)getIsUserJavaServiceWithCallBack:(HttpCallBackWithObject)callBack
{
//    [AFWebAPI_JAVA postWithUrl:@"home/systemConfig" params:[NSDictionary new] success:^(NSDictionary *contentDic) {
//        callBack(YES,contentDic);
//    } failure:^(NSString *errorStr) {
//        callBack(NO,nil);
//    }];
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
   [manager POST:[NSString stringWithFormat:@"%@home/systemConfig",java_url] parameters:[NSDictionary dictionary] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject[@"header"];
        NSString *message = dic[@"message"];
        if ([message isEqualToString:@"SUCCESS"]) {
            callBack(YES,responseObject);
        }else{
            callBack(NO,message);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callBack(NO,error.description);
    }];
}
//获取java后端的token
+(void)getTokenFromJavaService:(id)arg callBack:(HttpCallBackWithObject)callBack
{
  // 1.创建请求管理对象
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.requestSerializer.timeoutInterval = 60;
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
//    NSString *url = [NSString stringWithFormat:@"%@auth/login",java_url];
//    [manager POST:url parameters:arg success:^(NSURLSessionDataTask *task, id responseObject) {
//      callBack(YES,responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        callBack(NO,error.localizedFailureReason);
//    }];
    [AFWebAPI_JAVA postWithUrl:@"auth/login" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
         callBack(NO,errorStr);
    }];
}
//refereshToken
+ (void)refereshToken:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"auth/refresh" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
         callBack(NO,nil);
    }];
}
//验证码 1短信 2语音
+ (void)getVerCodeWithArg:(id)arg type:(NSInteger)type callBack:(HttpCallBackWithObject)callBack;
{
    NSString *url = type==1?@"auth/textcode":@"auth/voicecode";
    [AFWebAPI_JAVA postWithUrl:url params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//判断当前token是否有效
+ (void)checkTokenIsValid:(id)arg callBack:(HttpCallBackWithObject)callBack
{//home/appBanner
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
  NSMutableDictionary *dic = [NSMutableDictionary new];
    if (arg!=nil) {
        [dic setObject:arg forKey:@"body"];
    }
    NSString *url2 = [NSString stringWithFormat:@"%@home/appBanner",java_url];
    NSMutableDictionary *header = [NSMutableDictionary new];
    NSString *tokenStr =  [UserInfoManager getAccessToken];
    if (tokenStr.length>0) {//没有登录时不传token 所以此处做个判断
        [header setObject:tokenStr forKey:@"accessToken"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",tokenStr] forHTTPHeaderField:@"authorization"];
    }
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    [header setObject:[NSString stringWithFormat:@"IOS%@",phoneVersion] forKey:@"deviceType"];
    [header setObject:GetLocalAddress() forKey:@"ipAddress"];
    [header setObject:Current_BundleVersion forKey:@"version"];
    [dic setObject:header forKey:@"header"];
    [manager POST:url2 parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"des is %@",error.description);
        if ([error.description containsString:@"unauthorized (401)"]) {
             callBack(NO,@"用户手机号或者密码被修改");
        }
       
    }];
    
}
/**********************************************个人设置*******************************************/
//版本控制
+(void)checkVersionWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"version/query" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//用户消息设置 免打扰
+(void)setUserNewMsgWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/notify" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//验证旧手机号
+(void)setCheckoldPhoneWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/checkOldMobile" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//更换绑定手机号
+(void)setChangePhoneWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/changeMobile" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//意见反馈
+(void)setUserFeedbackArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA singleFileUploadWithParams:arg data:data url:@"upload/feedback" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
         callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
         callBack(NO,nil);
    }];
}
//资金明细
+(void)setCapitalDetailsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"capital/capitalDetails" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//评价演员
+(void)gradeActorWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"evaluate/addEvaluate" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查看演员的所有评价
+(void)checkActorGradesWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"evaluate/viewEvaluateList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//项目评价
+(void)gradeProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/addEvaluate" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查看评价
+(void)checkProjectGradeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"evaluate/evaluateList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//修改评价
+(void)modifyGradeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"evaluate/updateEvaluate" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//刷新我的页面
+(void)getCenterNewDataWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/getRefreshInfo" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//演员实名认证
+(void)getResourceAuthWithArg:(id)arg imageDic:(nonnull NSDictionary *)dic callBack:(nonnull HttpCallBackWithObject)callBack
{
    
    [AFWebAPI_JAVA multiplePhotoUploadWithParams:arg url:@"upload/actorCard" imageDic:dic success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//个人买家实名认证
+(void)getPersonlAuthWithArg:(id)arg imageDic:(nonnull NSDictionary *)dic callBack:(nonnull HttpCallBackWithObject)callBack
{
    
    [AFWebAPI_JAVA multiplePhotoUploadWithParams:arg url:@"upload/buyerCard" imageDic:dic success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//企业买家实名认证
+(void)getCompanyAuthWithArg:(id)arg imageDic:(nonnull NSDictionary *)dic callBack:(nonnull HttpCallBackWithObject)callBack
{
    
    [AFWebAPI_JAVA multiplePhotoUploadWithParams:arg url:@"upload/licence" imageDic:dic success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

/*******************************************首页，收藏。。。***************************************/
//获取各个演员列表
+(void)getHomeRecommendWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/actorSortSearch" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//举报用户
+(void)getReportUserWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{

    [AFWebAPI_JAVA singleFileUploadWithParams:arg data:data url:@"upload/complain" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}
//拉黑用户
+(void)getPullBlackUserWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/black" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//黑名单列表
+(void)getBlackListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/blackList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//检查电话是否注册
+(void)getIsRegistMoblieWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/checkTel" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取banner
+(void)getAppBannerWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/appBanner" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//点赞/取消点赞
+(void)getPraiseArtistWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/praise" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取收藏列表
+(void)getCollectionListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/collectionList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//收藏/取消收藏艺人
+(void)setCollectionArtistWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/collectActor" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//获取艺人主页资料
+(void)getUserInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"actor/detail" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//关键字搜索艺人
+(void)searchAristKeywordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/keySearch" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取新版搜索页相关搜索词条
+(void)getSearchVCDataWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/get/search/tags" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//清空搜索历史数据
+(void)cleanSearchHistoryWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/clear/search/tags" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//根据条件搜索演员（new）
+(void)searchActorWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/actor/search" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//首页搜索进入的搜索列表的条件配置
+(void)getHomeSearchConfigWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"config/data/list/actor/search" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
/*******************************************报价相关***************************************/
//查看演员报价
+(void)getQuotaListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"quotation/priceInfo" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查看演员自己的报价列表
+(void)getMyQuotaListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"quotation/priceList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//新增、修改报价
+(void)modifyQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"quotation/update" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//删除报价
+(void)delectQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"quotation/del" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//vip申请接口
+(void)applyVIPWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"buyer/applyVip" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//校验未认证用户能不能看
+(void)canLookPriceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"actor/consult/price/validate" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//告知后端未认证用户要去看了
+(void)unAuthLookedPriceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"quotation/priceInfo" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
/*******************************************订单相关***************************************/
//视频埋点统计
+(void)getVideoStatisticalWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"home/videoStatistics" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
/*******************方法*************************/

/*******************************************积分商城相关***************************************/
//获取商城列表
+(void)getStoreListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"point/shopList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取买家积分
+(void)getUserSorceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"point/view" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取买家积分明细
+(void)getSorceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"point/history" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//积分兑换
+(void)getSorceConvertWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"point/redeem" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

/*******************************************订单相关***************************************/
//1.计算拍摄订单价格
+(void)calculateOrderPriceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/calcPrice" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//2.下单成功积分回掉
+(void)placeOrderIntegralBackWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/callback" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//3.获取订单列表
+(void)getAllOrderListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/list" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//4.创建试镜服务
+(void)getCreatAuditServiceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/createAuditionService" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//5.试镜服务订单列表
+(void)getAuditServiceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/auditionServiceOrderList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//6.支付成功的回掉
+(void)getPaySuccessBackWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/callback" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//7.创建选角服务
+(void)getCreatRoleServiceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/createChooseActorService" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//8.选角服务订单列表
+(void)getRoleServiceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/chooseActorServiceOrderList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

/*******************************************项目相关***************************************/
//新增项目
+(void)addProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/create" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//获取项目详细信息
+(void)getProjectDetialWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/detail" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//修改拍摄项目项目
+(void)editProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/update" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//删除项目
+(void)delectProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/delete" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取项目列表
+(void)getProjectListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/list" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//36.上传试镜项目图片
+(void)upLoadShootMediaIsImage:(BOOL)img WithArg:(id)arg data:(NSData *)data callBack:(HttpCallBackWithObject)callBack
{
    if (img) {
        [AFWebAPI_JAVA singleFileUploadWithParams:arg data:data url:@"upload/projectScript" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
            callBack(YES,contentDic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {

            callBack(NO,nil);
        }];
       
    }else{
 
    [AFWebAPI_JAVA singleVideoUploadWithParams:arg data:data url:@"upload/projectScript" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
          callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {

        callBack(NO,nil);
    }];
    }
}
//36.上传试镜项目图片2
+(void)upLoadShootMediaIsImage2:(BOOL)img WithArg:(id)arg data:(NSData *)data callBack:(HttpCallBackWithObject)callBack
{
    if (img) {
        [AFWebAPI_JAVA singleFileUploadWithParams2:arg data:data url:@"upload/projectScript" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
            callBack(YES,contentDic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            
            callBack(NO,nil);
        }];
        
    }else{
        
        [AFWebAPI_JAVA singleVideoUploadWithParams:arg data:data url:@"upload/projectScript" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
            callBack(YES,contentDic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            
            callBack(NO,nil);
        }];
    }
}
//获取角色列表
+(void)getCastingListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/roleList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//询问档期
+(void)askDateWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/askSchedule" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//创建项目角色（单指从询问档期进入）
+(void)creatProjectCastingWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/createRole" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//修改项目角色
+(void)modifyCastingWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/updateRole" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//项目修改历史
+(void)checkProjectEditHistoryWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/changeHistory" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查询修改项目导致被影响的订单
+(void)checkEffectOdersWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/updateAffectedOrders" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//选择拍摄类别时的总价明细
+(void)getTotalPriceDetailWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/calcPriceV2" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
/*******************************************保险相关***************************************/
//创建团体保单
+(void)createInsuranceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"insurance/groupCreate" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//生成订单号
+(void)createOrderNumWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"common/idGenerate" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取保险列表
+(void)getInsuranceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"insurance/groupList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
/*******************************************优惠券相关***************************************/
//1.优惠券列表
+(void)getCouponListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"coupon/couponList" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//2.生成优惠券分享码
+(void)getCouponShareCodeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"coupon/createShareCode" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//3.生成优惠券
+(void)getCoupongenerateCodeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"coupon/generateCoupon" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//4.查询优惠券分享码
+(void)getCouponqueryShareCodeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"coupon/queryShareCode" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//5.调整优惠券顺序
+(void)getCouponSortWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"coupon/sort" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

/*******************************************通告相关***************************************/
//获取正在招募的通告列表
+(void)getAnnunciatesWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"shotBroadcast/list" params:arg success:^(NSDictionary *contentDic) {
       callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取公告详情
+(void)getAnnunDetailWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"shotBroadcast/detail" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//上传通告图片或视频
+(void)upLoadAnnunciateWithArg:(id)arg type:(NSInteger)type data:(NSData *)data callBack:(HttpCallBackWithObject)callBack
{
    if (type==2) {
        [AFWebAPI_JAVA singleVideoUploadWithParams:arg data:data url:@"upload/shotBroadcastWork" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
            callBack(YES,contentDic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
    if (type==1) {
        [AFWebAPI_JAVA singleFileUploadWithParams:arg data:data url:@"upload/shotBroadcastWork" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
            callBack(YES,contentDic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
   
}
//通告报名
+(void)applyAnnunciateWith:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack//
{
    [AFWebAPI_JAVA postWithUrl:@"shotBroadcast/apply" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//1.演员通告报名列表
+(void)getArtistAnnunciateListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"shotBroadcast/applyList" params:arg success:^(NSDictionary *contentDic) {
callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//2.演员报名通告详情
+(void)gettArtistAnnunciateDetialWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"shotBroadcast/applyDetail" params:arg success:^(NSDictionary *contentDic) {

        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
/*******************************************上传相关***************************************/
+(void)uploadCommonWithArg:(id)arg data:(id)data callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA singleFileUploadWithParams:arg data:data url:@"upload/fileUploadCommon" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}
/*******************************************资金相关***************************************/
//1.资金明细
+(void)getCapitalDetailsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"capital/capitalDetails" params:arg success:^(NSDictionary *contentDic) {
        
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//2.添加和更新银行卡和支付宝账号
+(void)updateBankCardAndAliPayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"capital/updateBankCardAndAliPay" params:arg success:^(NSDictionary *contentDic) {
        
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//3.提现
+(void)getwithdrawCashWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"capital/withdrawCash" params:arg success:^(NSDictionary *contentDic) {
        
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//4.银行卡和支付宝账号列表
+(void)getCardAndAliPayListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"capital/cardAndAliPayList" params:arg success:^(NSDictionary *contentDic) {
        
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
/*******************************************统计相关***************************************/
+(void)staticsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"statistics/accessLog" params:arg success:^(NSDictionary *contentDic) {
        
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

/*******************************************买家项目相关***************************************/
//1.查看最新项目
+(void)getViewNewProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"project/viewProject" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//2.锁定档期操作
+(void)getLockScheduleProcessWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/lockScheduleProcess" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//3.买家操作询问档期订单
+(void)getBuyerProcesssWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/buyerProcess" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
////修改在线试镜时间
//+(void)modifyTestAuditionDateWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
//{
//    [AFWebAPI_JAVA postWithUrl:@"order/tryVideoProcess" params:arg success:^(NSDictionary *contentDic) {
//        callBack(YES,contentDic);
//    } failure:^(NSString *errorStr) {
//        callBack(NO,errorStr);
//    }];
//}
//4.试镜操作
+(void)getTryVideoProcessWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/tryVideoProcess" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//5.定妆操作
+(void)getMakeupProcessWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/makeupProcess" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//6.订单详情
+(void)getOrderDetialWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/detail" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//7.取消订单
+(void)getOrderCancelWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/cancel" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//8.演员操作询问档期订单
+(void)getActorProcessWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/actorProcess" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}

//9.上传试镜作品
+(void)upLoadTryVideoWithArg:(id)arg data:(NSData *)data callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA singleVideoUploadWithParams:arg data:data url:@"upload/tryVideo" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//10.上传最新照片（多张）
+(void)upLoadLastPhotoWithArg:(id)arg data:(NSData *)data callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA singleFileUploadWithParams:arg data:data url:@"upload/fileUploadCommon" success:^(AFHTTPRequestOperation *op, NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}
//11 发起试镜
+(void)lauchAuditionOnlineWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"liveAudition/roomToken" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//12 问询是否有房间邀请
+(void)askRoomInviteWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
[AFWebAPI_JAVA postWithUrl:@"liveAudition/queryInvitation" params:arg success:^(NSDictionary *contentDic) {
    callBack(YES,contentDic);
} failure:^(NSString *errorStr) {
    callBack(NO,errorStr);
}];
}
//13 房间操作
+(void)roomOperationWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
[AFWebAPI_JAVA postWithUrl:@"liveAudition/roomOperate" params:arg success:^(NSDictionary *contentDic) {
    callBack(YES,contentDic);
} failure:^(NSString *errorStr) {
    callBack(NO,errorStr);
}];
}
//创建一个授权书申请
+(void)createPortraitsignWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"portrait/auth/create" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取授权书url
+(void)getPortraitUrlWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"portrait/auth/person/sign" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//预览授权书的url
+(void)lookPortraitWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"portrait/auth/preview" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//崔签字
+(void)portraitQuikWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"portrait/auth/press" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//取消授权书操作
+(void)portraitCancelWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"portrait/authbuyer/cancel" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//授权书下载
+(void)portraitDownloadWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"portrait/auth/download/email" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查询用户角色
+(void)getUserTypeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/defined/type/query" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//给用户添加角色
+(void)setUserTypeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"user/defined/type/add" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
/*******************************************达人首页相关***************************************/
//获取公告列表
+(void)getBulletinListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"bulletin/list" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取达人首页配置信息
+(void)getBuyerHomeConfigWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"config/data/list/expert/search" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取达人平台
+(void)getPlatformListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"platform/list/usable" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//获取达人排行榜
+(void)getRangeListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"actor/expert/ranking/list" params:arg success:^(NSDictionary *contentDic) {
    callBack(YES,contentDic);
} failure:^(NSString *errorStr) {
    callBack(NO,errorStr);
}];
    
}
//搜索达人
+(void)searchActorListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"actor/expert/search/list" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//达人首页详情
+(void)getActorInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"actor/expert/detail" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查询定制服务标签
+(void)checkOrderTypeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"customized/service/tags" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查询网红收藏
+(void)checkCollectionActorsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"collect/expert/list" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//新增网红定制订单
+(void)addCustomOrderWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"customized/service/add" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查询网红定制订单列表
+(void)getCustomizedOrderListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"customized/service/list" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
//查询网红定制订单详情
+(void)checkDetailCustomOrderWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    [AFWebAPI_JAVA postWithUrl:@"order/customized/detail" params:arg success:^(NSDictionary *contentDic) {
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];
}
@end
