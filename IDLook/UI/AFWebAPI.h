//
//  AFWebAPI.h
//  IDLook
//
//  Created by HYH on 2018/5/24.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 JSON
 */
#define JSON_ret  @"ret"
#define JSON_msg  @"msg"
#define JSON_data @"data"

/**
 AF result error
 */
#define AF_SHOW_RESULT_ERROR   {                                                                   \
                                      NSString *msg = [(NSDictionary *)object objectForKey:JSON_msg];\
                                        if(msg!=nil && [msg length]>1 )\
                                            {[SVProgressHUD showErrorWithStatus:msg];}                   \
                                        else  \
                                             {[SVProgressHUD showErrorWithStatus:@"您的网络似乎已断开"];} \
                                  }


/** http请求回调定义二(POST/GET)
 success：接口是否调用成功
 object：服务器返回的对象（一般为dictionary，用于业务处理）
 */
typedef void (^HttpCallBackWithObject)(BOOL success,id object);

@interface AFWebAPI : NSObject

/*******************************************注册、登陆及密码***************************************/
//1、获取验证码
+ (void)getVerCodeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//2、手机注册
+ (void)doRegistByMobile:(id)arg callBack:(HttpCallBackWithObject)callBack;

//3、手机登录
+ (void)doLoginByMobileWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//4、未登录找回密码
+ (void)doFindPasswordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//5.获取基础配置
+ (void)getPublicConfig:(id)arg callBack:(HttpCallBackWithObject)callBack;

//6、已登录修改密码
+ (void)doModifPasswordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

/**********************************************个人设置*******************************************/
//1.修改个人资料，无图片
+(void)modifMyotherInfoWithAry:(id)arg callBack:(HttpCallBackWithObject)callBack;

//1.1修改个人资料，带图片
+(void)modifMyotherInfoWithArg:(id)arg DataDic:(NSDictionary*)dic callBack:(HttpCallBackWithObject)callBack;

//2.用户消息设置
+(void)setUserNewMsgWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//3.意见反馈
+(void)setUserFeedbackArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//4.验证旧手机号
+(void)setCheckoldPhoneWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//5.更换绑定手机号
+(void)setChangePhoneWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//6.修改/上传认证信息
+(void)uploadAuthInfoWithArg:(id)arg DataDic:(NSDictionary*)dic callBack:(HttpCallBackWithObject)callBack;

//6.1修改艺人/上传认证信息
+(void)uploadResourceAuthInfoWithArg:(id)arg DataDic:(NSDictionary*)dic callBack:(HttpCallBackWithObject)callBack;

//7.添加模特卡
+(void)addmodelcardWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//8.上传授权书
+(void)uploadAuthorizationArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//9.资金明细
+(void)setCapitalDetailsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//10.获取认证信息
+(void)getAuthInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//11.上传作品
+(void)uploadWorksWithArg:(id)arg withDataArr:(NSArray*)array callBack:(HttpCallBackWithObject)callBack;

//12.上传微出镜/试葩间作品
+(void)uploadMirrAndTrialWorksWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//13.删除作品，微出镜，试葩间 ， 模特卡
+(void)setDelectWroks:(id)arg callBack:(HttpCallBackWithObject)callBack;

//14.获取作品，微出镜/试葩间，模特卡等信息
+(void)getWorksModelcardMirrorList:(id)arg callBack:(HttpCallBackWithObject)callBack;

//15.修改作品，微出镜/试葩间等信息
+(void)getModifyWorks:(id)arg callBack:(HttpCallBackWithObject)callBack;

//16.获取授权书信息
+(void)getCertficiInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//17.获取所有报价管理列表
+(void)getQuotaListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//18.新增报价
+(void)addNewQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//19.修改报价
+(void)modifyQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//20.删除报价
+(void)delectQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//21.报价详情
+(void)getQuotaDetailWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//22.提现
+(void)getForwardWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//22.1.添加银行卡/支付宝账号
+(void)addBankcardAlipayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//23.系统消息
+(void)getCustomMsgWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//24.刷新我的页面
+(void)getCenterNewDataWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//25.修改毕业院校信息
+(void)doModifySchoolInfo:(id)arg callBack:(HttpCallBackWithObject)callBack;

//26.获取我的所有作品
+(void)getMyAllWorksListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//27.上传/修改才艺展示
+(void)getUploadTalentWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//28.上传/修改过往作品
+(void)getUploadPastworkWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//29.刪除‘过往作品’和‘才艺展示’
+(void)delectPastWorkAndTalWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//30.新增拍摄项目
+(void)addProjectWithArg:(id)arg imageArray:(NSArray*)array callBack:(HttpCallBackWithObject)callBack;

//31.修改拍摄项目项目
+(void)editProjectWithArg:(id)arg imageArray:(NSArray*)array callBack:(HttpCallBackWithObject)callBack;

//32.删除项目
+(void)delectProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//33.获取项目信息
+(void)getProjectInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//34.获取项目列表
+(void)getProjectListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//34.获取项目详细信息
+(void)getProjectDetialWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//35.上传试镜项目视频
+(void)upLoadShootVideoWithArg:(id)arg videoArray:(NSArray *)array callBack:(HttpCallBackWithObject)callBack;
//36.上传试镜项目图片
+(void)upLoadShootImageWithArg:(id)arg mageArray:(NSArray *)array callBack:(HttpCallBackWithObject)callBack;
//37.新增试镜项目
+(void)addShootProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//38.修改试镜项目
+(void)EditShootProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//39.项目评价
+(void)gradeProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//40查看项目评价
+(void)checkProjectGradeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
/*******************************************首页，收藏。。。***************************************/
//1.获取收藏列表
+(void)getCollectionListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//2.收藏/取消收藏艺人
+(void)setCollectionArtistWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//3.获取首页推荐列表
+(void)getHomeRecommendWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//4.关键字搜索艺人
+(void)searchAristKeywordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//5.搜索筛选艺人
+(void)screenAristWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//6.获取艺人主页资料
+(void)getUserInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//7.获取推荐列表
+(void)getRecommendListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//8.标签筛选用户
+(void)getScreeUserListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//9.举报用户
+(void)getReportUserWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//10.拉黑用户
+(void)getPullBlackUserWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//11.黑名单列表
+(void)getBlackListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//12.视频演员主页面列表
+(void)getVideoTypeListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//13.筛选视频演员
+(void)getScreenVideoListWithArg:(id)arg withService:(NSString*)service callBack:(HttpCallBackWithObject)callBack;

//14.查看购买方是否第一次下单
+(void)getIsFirstOrderWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//15.检查电话是否注册
+(void)getIsRegistMoblieWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//16.获取banner
+(void)getAppBannerWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//17.点赞/取消点赞
+(void)getPraiseArtistWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

/*******************************************订单相关***************************************/
//1.试镜下单
+(void)placeOrderAudition:(id)arg imageArray:(NSArray*)array callBack:(HttpCallBackWithObject)callBack;

//1.1 项目试镜下单
+(void)ProjectAuditionPlaceOrder:(id)arg callBack:(HttpCallBackWithObject)callBack;

//2.拍摄下单
+(void)placeOrderShot:(id)arg withService:(NSString*)service imageArray:(NSArray*)array callBack:(HttpCallBackWithObject)callBack;

//2.1 项目拍摄下单
+(void)ProjectShotPlaceOrder:(id)arg callBack:(HttpCallBackWithObject)callBack;

//3.微出镜下单
+(void)placeOrderAuditionMirror:(id)arg dataType:(NSInteger)type data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//4.试葩间下单
+(void)placeOrderTrial:(id)arg dataType:(NSInteger)type data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//5.续约下单
+(void)placeOrderAuditionRenewal:(id)arg dataType:(NSInteger)type data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//6.用户所有订单列表
+(void)getAllOrderList:(id)arg callBack:(HttpCallBackWithObject)callBack;

//7.用户订单消息列表
+(void)getOrderNewsList:(id)arg callBack:(HttpCallBackWithObject)callBack;

//8.接单/确认档期
+(void)getAcceptOrder:(id)arg withSerivce:(NSString*)service callBack:(HttpCallBackWithObject)callBack;

//8.1.购买方再次确认档期
+(void)getConfrimSchedAgainWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//9.拒单
+(void)getRejectOrder:(id)arg withSerivce:(NSString *)service callBack:(HttpCallBackWithObject)callBack;

//10.取消订单
+(void)getcancleOrder:(id)arg callBack:(HttpCallBackWithObject)callBack;

//10.删除订单
+(void)getDeleteOrder:(id)arg callBack:(HttpCallBackWithObject)callBack;

//10.手机快速试镜上传视频
+(void)uploadVideoAuditionOrder:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//11.确认完成订单
+(void)finishOrder:(id)arg callBack:(HttpCallBackWithObject)callBack;

//12.订单进度
+(void)getOrderProgress:(id)arg callBack:(HttpCallBackWithObject)callBack;

//13.订单详情
+(void)getOrderDetail:(id)arg callBack:(HttpCallBackWithObject)callBack;

//14.拍摄订单报价
+(void)getShotOrderOfferWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//15.拍摄订单同意报价
+(void)getShotOrderAcceptOfferWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//16.拍摄订单拒绝报价
+(void)getShotOrderRejectOfferWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//17.拍摄订单上传授权书
+(void)uploadShotOrderCertificationWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;

//18.微信支付统一支付接口
+(void)wxPayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//19.支付宝支付统一支付接口
+(void)aliPayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//20.0元付款
+(void)getZeroPayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//21.视频埋点统计
+(void)getVideoStatisticalWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

@end
