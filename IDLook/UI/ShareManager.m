/*
 @header  ShareManager.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/25
 @description
 
 */

#import "ShareManager.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation ShareManager

+(void)shareWithType:(ShareType)type withUserInfo:(UserDetialInfoM *)info withViewControll:(UIViewController *)controll
{
    NSString *title=[NSString stringWithFormat:@"演员%@的个人主页",info.nickName];
    
    NSURL *imgUrl = [NSURL URLWithString:info.avatar];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:imgUrl]];
    
    NSString *desc = @"上脸探，看看我的新动态！APP上线大促，下单就返现5%！活动截止11月底";
    NSString *test = @"http://www.test.idlook.com/idlook_h5/homepage/homepagePer?artistid=";
    NSString *production = @"http://www.idlook.com/idlook_h5/homepage/homepagePer?artistid=";
    //http://www.idlook.com/public/share/?artistid=%ld
    NSString *url = [NSString stringWithFormat:@"%@%ld",production,info.actorId];
//  测试h5
//    NSString *url = [NSString stringWithFormat:@"http://islsj.natapp1.cc/public/share/?artistid=%@",info.UID];
    [ShareManager shareContentWithType:type withTitle:title withDesc:desc withUrl:url withImage:image withController:controll];
 
}

+(void)shareAppWithType:(ShareType)type withViewControll:(UIViewController *)controll
{
    NSString *title=@"脸探肖像APP下载";
    UIImage *image = [UIImage imageNamed:@"app_icon"];
    NSString *desc = @"指尖一点，万千演员任您选。在线下单，手机试镜，专业副导由您差遣！";
    NSString *url = @"http://www.idlook.com/public/download/html/index.html";
    [ShareManager shareContentWithType:type withTitle:title withDesc:desc withUrl:url withImage:image withController:controll];
}
+(void)shareAnnunciateWithType:(ShareType)type Title:(NSString *)title andDesc:(NSString *)desc andUrl:(NSString *)url andController:(UIViewController *)VC
{
    UIImage *image = [UIImage imageNamed:@"pictg"];
    [ShareManager shareContentWithType:type withTitle:title withDesc:desc withUrl:url withImage:image withController:VC];
}
+(void)shareReturnCashWithType:(ShareType)type Title:(NSString *)title andDesc:(NSString *)desc andUrl:(NSString *)url andController:(UIViewController *)VC
{
    UIImage *image = [UIImage imageNamed:@"x216"];//@"pic_123321"];
     [ShareManager shareContentWithType:type withTitle:title withDesc:desc withUrl:url withImage:image withController:VC];
}
//分享纯图片
+(void)sharePic:(UIImage *)img shareType:(ShareType)type isVideo:(BOOL)isVideo videoUrl:(NSString *)videoUrl videoTitle:(NSString *)title andController:(UIViewController *)VC result:(void (^)(BOOL isSuccess))result
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMSocialPlatformType UMType=UMSocialPlatformType_UnKnown;
    if (type==ShareTypeWX) {
        UMType = UMSocialPlatformType_WechatSession;
    }
    else if (type==ShareTypeWXTimeLine)
    {
        UMType = UMSocialPlatformType_WechatTimeLine;
    }
    if (isVideo) {
        //创建视频内容对象
        UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:@"" thumImage:[UIImage imageNamed:@"x216"]];
        //设置视频网页播放地址
        shareObject.videoUrl = videoUrl;
        //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else{
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        // shareObject.thumbImage = [UIImage imageNamed:@"icon"];
        [shareObject setShareImage:img];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }

    
    //调用分享接口
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMType messageObject:messageObject currentViewController:VC completion:^(id data, NSError *error) {
        //必须在-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOp函数里增加友盟return 否则该回调不走
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
           
        }else{
             result(YES);
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}
+(void)shareContentWithType:(ShareType)type
                  withTitle:(NSString*)title
                   withDesc:(NSString*)desc
                    withUrl:(NSString*)url
                  withImage:(UIImage*)image
             withController:(UIViewController*)controller
{
    UMSocialPlatformType UMType=UMSocialPlatformType_UnKnown;
    if (type==ShareTypeWX) {
        UMType = UMSocialPlatformType_WechatSession;
    }
    else if (type==ShareTypeWXTimeLine)
    {
        UMType = UMSocialPlatformType_WechatTimeLine;
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:image];
    
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMType messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

@end
