//
//  AFWebAPI.m
//  IDLook
//
//  Created by HYH on 2018/5/24.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AFWebAPI.h"
#import "CJSONDeserializer.h"
#import "OpenUDID.h"

#define AFWEBAPI_REQUEST_TIMEOUT 10   //普通get请求超时时间
#define AFWEBAPI_UPLOAD_TIMEOUT 300    //上传图片，视频超时时间

static const NSString *staticToken = @"^x389fhfeahykge";

@implementation AFWebAPI

/////////////////////////////////////////////////////////////////////////////////////////////////////
/*                                              网络层                                              */
/////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark - 普通get请求(json返回格式)

+ (void)commonGetRequestWithArg:(id)arg
                       success:(void(^)(AFHTTPRequestOperation *op, NSString *resp))success
                      failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_REQUEST_TIMEOUT;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:g_http_url parameters:arg success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//      success(operation,[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        success(operation,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(operation,error);
        //   [SVProgressHUD showErrorWithStatus:@"没有网络啦，不要让Ta等太久哦"];
    }];
}

#pragma mark -
#pragma mark - 普通post请求
+ (void)commonPostRequestWithArg:(id)arg
                      success:(void(^)(AFHTTPRequestOperation *op, NSString *resp))success
                      failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_REQUEST_TIMEOUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:g_http_url parameters:arg success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        success(operation,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(operation,error);
    }];
}
//请求普通数据   以前是将参数放在url中，此处的参数在parameter
+ (void)postWithNormalUrl:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(NSDictionary *contentDic))success
                  failure:(void (^)(NSString *errorStr))failure
{
   
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic addEntriesFromDictionary:params];



    [manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
     //   NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
      
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
     
         success(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error.localizedFailureReason);
    }];
}
#pragma mark -
#pragma mark - 普通图片文件上传

+ (void)commonUploadWithArg:(id)arg
                       data:(NSData *)data
                       head:(NSString*)head
                    success:(void(^)(AFHTTPRequestOperation *op, NSString *resp))success
                    failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_UPLOAD_TIMEOUT;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    [manager POST:g_http_url parameters:arg constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSInteger datalen=[data length];
        if(![data length])return;
        
        [formData appendPartWithFileData:data name:head fileName:@"headicon.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        success(operation,[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
         success(operation,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

#pragma mark -
#pragma mark - 普通视频文件上传
+ (void)commonVideoUploadWithArg:(id)arg
                       data:(NSData *)data
                       head:(NSString*)head
                    success:(void(^)(AFHTTPRequestOperation *op, NSString *resp))success
                    failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_UPLOAD_TIMEOUT;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    [manager POST:g_http_url parameters:arg constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSInteger datalen=[data length];
        if(![data length])return;
        
        [formData appendPartWithFileData:data name:head fileName:@"video1.mov" mimeType:@"video/quicktime"];

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        success(operation,[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        success(operation,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

#pragma mark -
#pragma mark - 多个图片文件上传
+ (void)commonUploadWithArg:(id)arg
                       dataDic:(NSDictionary *)dic
                    success:(void(^)(AFHTTPRequestOperation *op, NSString *resp))success
                    failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_UPLOAD_TIMEOUT;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:g_http_url parameters:arg constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSArray *array = [dic allKeys];
        for (int i =0; i<array.count; i++) {
            UIImage *image = [dic objectForKey:array[i]];
            NSData *data =  UIImageJPEGRepresentation(image, 1.0);
            NSInteger datalen=[data length];
            if(![data length])return;
            [formData appendPartWithFileData:data name:array[i] fileName:@"headicon.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        success(operation,[str stringByRemovingPercentEncoding]);
        success(operation,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

#pragma mark -
#pragma mark - 多个图片文件上传
+ (void)commonUploadMoreImageWithArg:(id)arg
                    ImageArray:(NSArray *)imageArr
                                head:(NSString*)head
                    success:(void(^)(AFHTTPRequestOperation *op, NSString *resp))success
                    failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_UPLOAD_TIMEOUT;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:g_http_url parameters:arg constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i =0; i<imageArr.count; i++) {
            UIImage *image = imageArr[i];
            NSData *data =  UIImageJPEGRepresentation(image, 1.0);
            if(![data length])return;
            [formData appendPartWithFileData:data name:head fileName:@"headicon.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //        success(operation,[str stringByRemovingPercentEncoding]);
        success(operation,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

#pragma mark -
#pragma mark - 多个视频文件上传/相同head
+ (void)commonUploadWithArg:(id)arg
                       head:(NSString*)head
                  dataArray:(NSArray*)array
                    success:(void(^)(AFHTTPRequestOperation *op, NSString *resp))success
                    failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_UPLOAD_TIMEOUT;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    [manager POST:g_http_url parameters:arg constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i =0; i<array.count; i++) {
            NSData *data = array[i];
            NSInteger datalen=[data length];
            if(![data length])return;
            if ([head containsString:@"wuming"]) {
                NSString *head2 = [head stringByReplacingOccurrencesOfString:@"wuming" withString:@""];
                 [formData appendPartWithFileData:data name:head2 fileName:[NSString stringWithFormat:@"video%d.mov",i] mimeType:@"video/quicktime"];
            }else{
            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"video[%d]",i] fileName:[NSString stringWithFormat:@"video%d.mov",i] mimeType:@"video/quicktime"];
        }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        success(operation,[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        success(operation,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}


#pragma mark -
#pragma mark - 模特卡上传，图片  视频一起上传
+ (void)commonUploadWithArg:(id)arg
                  imageData:(NSData *)imageData
                   videData:(NSData*)videoData
                    success:(void(^)(AFHTTPRequestOperation *op, NSString *resp))success
                    failure:(void(^)(AFHTTPRequestOperation *op, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = AFWEBAPI_UPLOAD_TIMEOUT;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    [manager POST:g_http_url parameters:arg constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(![imageData length])return;
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"headicon.jpg" mimeType:@"image/jpeg"];
        
        if(![videoData length])return;
        [formData appendPartWithFileData:videoData name:@"video" fileName:@"video1.mov" mimeType:@"video/quicktime"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        success(operation,[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        success(operation,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
/*                                             业务层                                               */
/////////////////////////////////////////////////////////////////////////////////////////////////////

/**********************************************接口参数封装*******************************************/

+ (id)completeArgsWithArg:(id)arg Service:(NSString *)service
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:arg];
   
    time_t timestamp = time(0);
     //不重复随机数
    srand((unsigned)timestamp);
    //随机数
    NSString *nonce = [NSString stringWithFormat:@"%d",rand()%(99999-10000)+10000];
    //将参数字典转成字符串
    NSString *argList = nil;
    argList = [AFWebAPI allBusinessArgsSort:arg];
    //将参数组合成新的字符串                                      //@"^x389fhfeahykge";
    NSString *input=[NSString stringWithFormat:@"%@%ld%@%@%@",staticToken,timestamp,nonce,service,argList];
   //将新的字符串进行md5加密
    NSString *signature = MD5Str(input);
    NSLog(@"key=%@",input);
    
    //NSString *version = Current_BundleVersion;
    //获取当前软件版本
    NSString *version = Current_BundleVersion;
    NSString *uuid = [OpenUDID value];//获取设备uid
    if(![uuid length])
        uuid = @"";
    //拼字典。       某个接口
    [dic setObject:service forKey:@"service"];
    [dic setObject:[NSNumber numberWithLong:timestamp] forKey:@"timestamp"];
    [dic setObject:nonce forKey:@"nonce"];
    [dic setObject:signature forKey:@"signature"];
    
    NSString *str = @"ios";
    
    [dic setObject:version forKey:@"v"];
    [dic setObject:str forKey:@"p"];
    [dic setObject:uuid forKey:@"u"];
    return dic;
}

//业务参数排序,返回排序后所有参数序列集合
+ (NSString *)allBusinessArgsSort:(id)arg
{
    NSDictionary *dic = (NSDictionary *)arg;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[dic allValues]];
    
    for(int i=0;i<[array count];i++)
    {
        id obj = [array objectAtIndex:i];
        if(!obj||(![obj isKindOfClass:[NSNumber class]]&&![obj isKindOfClass:[NSString class]]&&![obj isKindOfClass:[NSArray class]]&&![obj isKindOfClass:[NSDictionary class]]))
        {
            [arg replaceObjectAtIndex:i withObject:@""];
        }
        else if([obj isKindOfClass:[NSNumber class]])
        {
            NSNumber *num = (NSNumber *)obj;
            NSString *numStr = [NSString stringWithFormat:@"%ld",(long)[num integerValue]];
            [array replaceObjectAtIndex:i withObject:numStr];
        }
        else if([obj isKindOfClass:[NSString class]])
        {
            NSString *strTmp = (NSString *)obj;
            NSString *text = [strTmp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [array replaceObjectAtIndex:i withObject:text];
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            NSArray *strTmp = (NSArray *)obj;
            NSString *text = [strTmp componentsJoinedByString:@","];
            [array replaceObjectAtIndex:i withObject:text];
        }
        else if([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *strTmp = (NSDictionary *)obj;
            NSError *parseError = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:strTmp options:NSJSONWritingPrettyPrinted error:&parseError];
            NSString *text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [array replaceObjectAtIndex:i withObject:text];
        }
    }
    
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *pinyinFirst = [self lowercaseSpellingWithChineseCharacters:(NSString*)obj1];
        NSString *pinyinSecond = [self lowercaseSpellingWithChineseCharacters:(NSString*)obj2];
        return [(NSString *)pinyinFirst compare:(NSString *)pinyinSecond];   //汉字转拼音后排序
    }];

//   NSArray *result = [array sortedArrayUsingSelector:@selector(localizedCompare:)];
//
//    [array sortUsingSelector:@selector(localizedCompare:)];
    
    NSMutableString *argList = [[NSMutableString alloc] initWithCapacity:0];
    for(id obj in array)
    {
        [argList appendString:(NSString *)obj];
    }
    return argList;
}

//汉字转拼音
+(NSString *)lowercaseSpellingWithChineseCharacters:(NSString *)chinese {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:chinese];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    //返回小写拼音
    return [str lowercaseString];
}


//返回结果分析和json解析
+ (BOOL)analyzeRetrunMessage:(NSString *)message result:(NSDictionary **)dic
{
    if(![message length])
    {
        *dic = nil;
        return NO;
    }
    
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dicTmp = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
    
    NSDictionary *dicTmp = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
    
    if([dicTmp count])
    {
        *dic = dicTmp;
        NSObject *ret = [*dic objectForKey:JSON_ret];
        
        if(ret!=nil)
        {
            if([ret isKindOfClass:[NSString class]])
            {
                if([(NSString *)ret isEqualToString:@"200"])
                {
                    return YES;
                }
            }
            
            if([ret isKindOfClass:[NSNumber class]])
            {
                if([(NSNumber *)ret integerValue ]==200)
                {
                    return YES;
                }
            }
        }
        return NO;
    }
    else
    {
        *dic = nil;
        return NO;
    }
}

/*******************************************注册、登陆及密码*****************************************/
//1、获取验证码
+ (void)getVerCodeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"passport.code";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//2、手机注册
+ (void)doRegistByMobile:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"passport.mobile";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//3、手机登录
+ (void)doLoginByMobileWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    
    NSString *service = @"passport.lmobile";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//4、未登录找回密码
+ (void)doFindPasswordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
   NSString *service = @"passport.retrievePassword";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
        
}

//5.获取基础配置
+ (void)getPublicConfig:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.getPublicConfig";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//6、已登录修改密码
+ (void)doModifPasswordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"passport.modifyPassword";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

/**********************************************个人设置*******************************************/
//1.修改个人资料，无图片
+(void)modifMyotherInfoWithAry:(id)arg callBack:(HttpCallBackWithObject)callBack;
{
    NSString *service = @"User.modifyInfo";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//1.1修改个人资料，带图片
+(void)modifMyotherInfoWithArg:(id)arg DataDic:(NSDictionary*)dic callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.modifyInfo";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict dataDic:dic success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//2.用户消息设置
+(void)setUserNewMsgWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.notify";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//3.意见反馈
+(void)setUserFeedbackArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.feedback";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict data:data head:@"image" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];

}

//4.验证旧手机号
+(void)setCheckoldPhoneWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.checkOldMobile";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//5.更换绑定手机号
+(void)setChangePhoneWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.changemobile";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//6.修改/上传购买方认证信息
+(void)uploadAuthInfoWithArg:(id)arg DataDic:(NSDictionary*)dic callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.buyerAuthentication";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict dataDic:dic success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//6.1修改/上传资源方认证信息
+(void)uploadResourceAuthInfoWithArg:(id)arg DataDic:(NSDictionary*)dic callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.actorAuthentication";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict dataDic:dic success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//7.添加模特卡
+(void)addmodelcardWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;
{
    NSString *service = @"User.addModelCard113";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    if ([dict[@"cardorvideo"] integerValue]==1)   //模特卡
    {
        [AFWebAPI commonUploadWithArg:dict data:data head:@"image" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
    else
    {
        [AFWebAPI commonVideoUploadWithArg:dict data:data head:@"video" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
    
}

//8.上传授权书
+(void)uploadAuthorizationArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.uploadAuthorization";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict data:data head:@"authorization" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//9.资金明细
+(void)setCapitalDetailsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.capitalDetails";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];

}

//10.获取认证信息
+(void)getAuthInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.authInfo";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//11.上传作品
+(void)uploadWorksWithArg:(id)arg withDataArr:(NSArray*)array callBack:(HttpCallBackWithObject)callBack;
{
    NSString *service = @"User.uploadworks113";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict head:@"video[]" dataArray:array success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//12.上传微出镜/试葩间作品
+(void)uploadMirrAndTrialWorksWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.uploadmicromirror";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    NSDictionary *dic = (NSDictionary*)arg;
    
    if ([dic[@"worktype"] integerValue]==0)   //图片上传
    {
        [AFWebAPI commonUploadWithArg:dict data:data head:@"workresource[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
    
    else     //视频上传
    {
        [AFWebAPI commonVideoUploadWithArg:dict data:data head:@"workresource[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }

}

//13.删除作品，微出镜，试葩间 ， 模特卡
+(void)setDelectWroks:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.delCreative";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//14.获取作品，微出镜/试葩间，模特卡等信息
+(void)getWorksModelcardMirrorList:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.TalMirModInfo";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//15.修改作品，模特卡，微出镜/试葩间等信息
+(void)getModifyWorks:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.editCreative";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//16.获取授权书信息
+(void)getCertficiInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.authorizationInfo";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//17.获取所有报价管理列表
+(void)getQuotaListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Price.showQuotationList";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//18.新增报价
+(void)addNewQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Price.addQuotation";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//19.修改报价
+(void)modifyQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Price.editQuotation";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//20.删除报价
+(void)delectQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Price.delQuotation";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//21.报价详情
+(void)getQuotaDetailWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Price.showQuotationDetail";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//22.提现
+(void)getForwardWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Price.withdrawCash";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//22.1.添加银行卡/支付宝账号
+(void)addBankcardAlipayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.addCardAli";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//23.系统消息
+(void)getCustomMsgWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.getUserOsMsg";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//24.刷新我的页面
+(void)getCenterNewDataWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.getRefreshInfo";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//25.修改毕业院校信息
+(void)doModifySchoolInfo:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.modifyProfession";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}


//26.获取我的所有作品
+(void)getMyAllWorksListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.myWorks";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//27.上传/修改才艺展示
+(void)getUploadTalentWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.upTalentShow";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonVideoUploadWithArg:dict data:data head:@"resource[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//28.上传/修改过往作品
+(void)getUploadPastworkWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.upPastWorks";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    NSDictionary *dic = (NSDictionary*)arg;
    
    if ([dic[@"type"] integerValue]==1)   //图片上传
    {
        [AFWebAPI commonUploadWithArg:dict data:data head:@"resource[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
    else  //视频上传
    {
        [AFWebAPI commonVideoUploadWithArg:dict data:data head:@"resource[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
}

//29.刪除‘过往作品’和‘才艺展示’
+(void)delectPastWorkAndTalWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.delPastworkTalent";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//30.新增项目
+(void)addProjectWithArg:(id)arg imageArray:(NSArray*)array callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.addProjectShoot";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadMoreImageWithArg:dict ImageArray:array head:@"projecturl[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//31.修改项目
+(void)editProjectWithArg:(id)arg imageArray:(NSArray*)array callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.editProjectShoot";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadMoreImageWithArg:dict ImageArray:array head:@"projecturl[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//32.删除项目
+(void)delectProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.delProject";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//33.获取项目信息
+(void)getProjectInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.projectInfo";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//34.获取项目列表
+(void)getProjectListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.projectInfo";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}
//34.获取项目详细信息
+(void)getProjectDetialWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.projectDetail";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}
//35.上传试镜项目视频
+(void)upLoadShootVideoWithArg:(id)arg videoArray:(NSArray *)array callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.projectAnnex";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict head:@"projecturl[]wuming" dataArray:array success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
         callBack(NO,nil);
    }];
}
//36.上传试镜项目图片
+(void)upLoadShootImageWithArg:(id)arg mageArray:(NSArray *)array callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.projectAnnex";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadMoreImageWithArg:dict ImageArray:array head:@"projecturl[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//37.新增试镜项目
+(void)addShootProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.addProject";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}
//38.修改试镜项目
+(void)EditShootProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.editProject";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}
//39.项目评价
+(void)gradeProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.evaluate";
    id dict = [AFWebAPI completeArgsWithArg:[NSDictionary new] Service:service];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
  
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_\"+ \n"];
    NSString * hmutStr = [[jsonString componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
     NSCharacterSet *doNotWant2 = [NSCharacterSet characterSetWithCharactersInString:@","];
    NSCharacterSet *doNotWant3 = [NSCharacterSet characterSetWithCharactersInString:@":"];
   NSString *hmutStr2 = [[hmutStr componentsSeparatedByCharactersInSet: doNotWant2]componentsJoinedByString: @"&"];
     NSString *hmutStr3 = [[hmutStr2 componentsSeparatedByCharactersInSet: doNotWant3]componentsJoinedByString: @"="];
    NSString *newUrl = [NSString stringWithFormat:@"%@?%@",g_http_url,hmutStr3];
    [AFWebAPI postWithNormalUrl:newUrl params:arg success:^(NSDictionary *contentDic) {
        
        callBack(YES,contentDic);
    } failure:^(NSString *errorStr) {
        callBack(NO,errorStr);
    }];

}
//40查看项目评价
+(void)checkProjectGradeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.evaluateInfo";
     id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}
/*******************************************首页，收藏。。。***************************************/
//1.获取收藏列表
+(void)getCollectionListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.collectionList";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//2.收藏/取消收藏艺人
+(void)setCollectionArtistWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.collection";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//3.获取首页推荐列表
+(void)getHomeRecommendWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.homePage";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//4.关键字搜索艺人
+(void)searchAristKeywordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.keySearch";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//5.搜索筛选艺人
+(void)screenAristWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.search";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//6.获取艺人主页资料
+(void)getUserInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.artistinfo";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//7.获取推荐列表
+(void)getRecommendListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.homePageList";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//8.标签筛选用户
+(void)getScreeUserListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.genreActorList";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}


//9.举报用户
+(void)getReportUserWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.report";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict data:data head:@"image" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//10.拉黑用户
+(void)getPullBlackUserWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.black";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//11.黑名单列表
+(void)getBlackListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.blackList";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//12.视频演员主页面列表
+(void)getVideoTypeListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.genreActorList2";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//13.筛选演员,  广告，影视，外籍演员
+(void)getScreenVideoListWithArg:(id)arg withService:(NSString *)service callBack:(HttpCallBackWithObject)callBack
{
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//14.查看购买方是否第一次下单
+(void)getIsFirstOrderWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.firstOrderUser";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//15.检查电话是否注册
+(void)getIsRegistMoblieWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"User.checkTel";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//16.获取banner
+(void)getAppBannerWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"home.appBanner";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//17.点赞/取消点赞
+(void)getPraiseArtistWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"home.praise";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

/*******************************************订单相关***************************************/
//1.试镜下单
+(void)placeOrderAudition:(id)arg imageArray:(NSArray*)array callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.underaudition";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadMoreImageWithArg:dict ImageArray:array head:@"creativeurl[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//1.1 项目试镜下单
+(void)ProjectAuditionPlaceOrder:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.proAuditionOrder";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//2.拍摄下单
+(void)placeOrderShot:(id)arg withService:(NSString*)service imageArray:(NSArray*)array callBack:(HttpCallBackWithObject)callBack
{
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadMoreImageWithArg:dict ImageArray:array head:@"creativeurl[]" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//2.1 项目拍摄下单
+(void)ProjectShotPlaceOrder:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.proShotOrder";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//3.微出镜下单
+(void)placeOrderAuditionMirror:(id)arg dataType:(NSInteger)type data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.undermirror";

    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    if (type==0) {
        [AFWebAPI commonUploadWithArg:dict data:data head:@"creativeurl" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
    else
    {
        [AFWebAPI commonVideoUploadWithArg:dict data:data head:@"creativeurl" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
}

//4.试葩间下单
+(void)placeOrderTrial:(id)arg dataType:(NSInteger)type data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.undertry";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    if (type==0) {
        [AFWebAPI commonUploadWithArg:dict data:data head:@"creativeurl" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
    else
    {
        [AFWebAPI commonVideoUploadWithArg:dict data:data head:@"creativeurl" success:^(AFHTTPRequestOperation *op, NSString *resp) {
            NSDictionary *dic = nil;
            BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
            callBack(status,dic);
        } failure:^(AFHTTPRequestOperation *op, NSError *error) {
            callBack(NO,nil);
        }];
    }
}

//5.续约下单
+(void)placeOrderAuditionRenewal:(id)arg dataType:(NSInteger)type data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.underrenwal";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict data:data head:@"creativeurl" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//6.用户所有订单列表
+(void)getAllOrderList:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.proAllorder";
    
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//7.用户订单消息列表
+(void)getOrderNewsList:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"msg.orderMsg";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//8.接单
+(void)getAcceptOrder:(id)arg withSerivce:(NSString *)service callBack:(HttpCallBackWithObject)callBack
{
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//8.1.购买方再次确认档期
+(void)getConfrimSchedAgainWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.acceptAgain";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];

}

//9.拒单
+(void)getRejectOrder:(id)arg withSerivce:(NSString *)service callBack:(HttpCallBackWithObject)callBack
{
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//10.取消订单
+(void)getcancleOrder:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.proCancel";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//10.删除订单
+(void)getDeleteOrder:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.proDeleted";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}


//10.手机快速试镜上传视频
+(void)uploadVideoAuditionOrder:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.uploadvideo";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonVideoUploadWithArg:dict data:data head:@"video" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//11.确认完成订单
+(void)finishOrder:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.finish";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//12.订单进度
+(void)getOrderProgress:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.getstatelist";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//13.订单详情
+(void)getOrderDetail:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.proOrderDetail";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//14.拍摄订单报价
+(void)getShotOrderOfferWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.pricereport";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//15.拍摄订单同意报价
+(void)getShotOrderAcceptOfferWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.priceaccept";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//16.拍摄订单拒绝报价
+(void)getShotOrderRejectOfferWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"order.pricereject";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//17.拍摄订单上传授权书
+(void)uploadShotOrderCertificationWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Order.uploadcert";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonUploadWithArg:dict data:data head:@"certfile" success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//18.微信支付统一支付接口
+(void)wxPayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Pay.wxPay";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//19.支付宝支付统一支付接口
+(void)aliPayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Pay.aliPay";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//20.0元付款
+(void)getZeroPayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"pay.zeroPriceNotify";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

//21.视频埋点统计
+(void)getVideoStatisticalWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack
{
    NSString *service = @"Home.videoStatistics";
    id dict = [AFWebAPI completeArgsWithArg:arg Service:service];
    
    [AFWebAPI commonGetRequestWithArg:dict success:^(AFHTTPRequestOperation *op, NSString *resp) {
        NSDictionary *dic = nil;
        BOOL status = [AFWebAPI analyzeRetrunMessage:resp result:&dic];
        callBack(status,dic);
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        callBack(NO,nil);
    }];
}

@end
