/*
 @header  ShareManager.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/25
 @description
    分享类
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ShareType) {
    
    ShareTypeWX        = 0,   //微信
    ShareTypeWXTimeLine,      //朋友圈
    ShareTypeQQSpace,         //qq空间
    ShareTypeeQQ,          //qq
    ShareTypeWB           //微博
};

@interface ShareManager : NSObject

/**
 根据用户分享个人主页
 @param type 分享类型
 @param info 用户信息
 @param controll 控制器
 */
+ (void)shareWithType:(ShareType)type withUserInfo:(UserDetialInfoM*)info withViewControll:(UIViewController*)controll;

/**
 分享app
 @param type 分享类型
 @param controll 控制器
 */
+ (void)shareAppWithType:(ShareType)type withViewControll:(UIViewController*)controll;
//分享通告
+(void)shareAnnunciateWithType:(ShareType)type Title:(NSString *)title andDesc:(NSString *)desc andUrl:(NSString *)url andController:(UIViewController *)VC;
//分享优惠券页面
+(void)shareReturnCashWithType:(ShareType)type Title:(NSString *)title andDesc:(NSString *)desc andUrl:(NSString *)url andController:(UIViewController *)VC;
//分享纯图片或视频
+(void)sharePic:(UIImage *)img shareType:(ShareType)type isVideo:(BOOL)isVideo videoUrl:(NSString *)videoUrl videoTitle:(NSString *)title andController:(UIViewController *)VC result:(void (^)(BOOL isSuccess))result;
@end


