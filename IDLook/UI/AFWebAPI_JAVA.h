//
//  AFWebAPI_JAVA.h
//  IDLook
//
//  Created by 吴铭 on 2019/2/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

/**
 JSON
 */
#define JSON_header  @"header"
#define JSON_body @"body"

/**
 AF result error
 */
#define AF_SHOW_JAVA_ERROR   {                                                                   \
                               NSString *msg = object;\
                               if(msg!=nil && [msg length]>1 )\
                                       {[SVProgressHUD showErrorWithStatus:msg];}                   \
                               else  \
                                      {[SVProgressHUD showErrorWithStatus:@"您的网络似乎已断开"];} \
                               }

typedef void (^HttpCallBackWithObject)(BOOL success,id object);
@interface AFWebAPI_JAVA : NSObject
/*******************************************注册、登陆及密码***************************************/
//未登录找回密码
+ (void)doFindPasswordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//已登录修改密码
+ (void)doModifPasswordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取基础配置
+ (void)getPublicConfig:(id)arg callBack:(HttpCallBackWithObject)callBack;

#warning -token 要先获取token再询问是否使用java后台，因为询问使用java需要token
//获取java后端的token
+ (void)getTokenFromJavaService:(id)arg callBack:(HttpCallBackWithObject)callBack;
//refereshToken
+ (void)refereshToken:(id)arg callBack:(HttpCallBackWithObject)callBack;
//动态配置获取(目前功能是：是不是启用java后台)
+ (void)getIsUserJavaServiceWithCallBack:(HttpCallBackWithObject)callBack;
//获取当前版本信息。新增接口，之前没有
+ (void)getCurrentVersionInfo:(id)arg callBack:(HttpCallBackWithObject)callBack;
//短信验证码 语音验证码 1短信 2语音
+ (void)getVerCodeWithArg:(id)arg type:(NSInteger)type callBack:(HttpCallBackWithObject)callBack;
//判断当前token是否有效
+ (void)checkTokenIsValid:(id)arg callBack:(HttpCallBackWithObject)callBack;

/**********************************************个人设置*******************************************/
//用户消息设置
+(void)setUserNewMsgWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//验证旧手机号
+(void)setCheckoldPhoneWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//更换绑定手机号
+(void)setChangePhoneWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//意见反馈
+(void)setUserFeedbackArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;
//*资金明细
+(void)setCapitalDetailsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//评价演员
+(void)gradeActorWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//查看演员的所有评价
+(void)checkActorGradesWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//项目评价  老版本了
+(void)gradeProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//查看自己的评价
+(void)checkProjectGradeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//修改自己的评价
+(void)modifyGradeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//刷新我的页面
+(void)getCenterNewDataWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//演员实名认证
+(void)getResourceAuthWithArg:(id)arg imageDic:(NSDictionary*)dic callBack:(HttpCallBackWithObject)callBack;

//个人买家实名认证
+(void)getPersonlAuthWithArg:(id)arg imageDic:(nonnull NSDictionary *)dic callBack:(nonnull HttpCallBackWithObject)callBack;

//企业买家实名认证
+(void)getCompanyAuthWithArg:(id)arg imageDic:(nonnull NSDictionary *)dic callBack:(nonnull HttpCallBackWithObject)callBack;

/*******************************************首页，收藏。。。***************************************/
//获取各个演员列表
+(void)getHomeRecommendWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//举报用户
+(void)getReportUserWithArg:(id)arg data:(NSData*)data callBack:(HttpCallBackWithObject)callBack;
//拉黑用户
+(void)getPullBlackUserWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//黑名单列表
+(void)getBlackListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//检查电话是否注册
+(void)getIsRegistMoblieWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取banner
+(void)getAppBannerWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//点赞/取消点赞
+(void)getPraiseArtistWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取收藏列表
+(void)getCollectionListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//收藏/取消收藏艺人
+(void)setCollectionArtistWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//获取艺人主页资料
+(void)getUserInfoWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//关键字搜索艺人
+(void)searchAristKeywordWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取新版搜索页相关搜索词条
+(void)getSearchVCDataWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//清空搜索历史数据
+(void)cleanSearchHistoryWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//根据条件搜索演员（new）
+(void)searchActorWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//首页搜索进入的搜索列表的条件配置
+(void)getHomeSearchConfigWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
/*******************************************报价相关***************************************/
//查看演员报价
+(void)getQuotaListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//查看演员自己的报价列表
+(void)getMyQuotaListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//新增、修改报价
+(void)modifyQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//删除报价
+(void)delectQuotaWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//视频埋点统计
+(void)getVideoStatisticalWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//校验未认证用户能不能看
+(void)canLookPriceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//告知后端未认证用户要去看了
+(void)unAuthLookedPriceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
/*******************************************积分商城相关***************************************/
//获取商城列表
+(void)getStoreListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取买家积分
+(void)getUserSorceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取买家积分明细
+(void)getSorceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//积分兑换
+(void)getSorceConvertWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//vip申请接口
+(void)applyVIPWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

/*******************************************订单相关***************************************/
//1.计算拍摄订单价格
+(void)calculateOrderPriceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//2.下单成功积分回掉
+(void)placeOrderIntegralBackWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//3.获取订单列表
+(void)getAllOrderListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//4.创建试镜服务
+(void)getCreatAuditServiceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//5.试镜服务订单列表
+(void)getAuditServiceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//6.支付成功的回掉
+(void)getPaySuccessBackWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//7.创建选角服务
+(void)getCreatRoleServiceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//8.选角服务订单列表
+(void)getRoleServiceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;


/*******************************************项目相关***************************************/
//新增项目
+(void)addProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取项目详细信息
+(void)getProjectDetialWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//修改拍摄项目项目
+(void)editProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//删除项目
+(void)delectProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取项目列表
+(void)getProjectListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//上传试镜项目图片
+(void)upLoadShootMediaIsImage:(BOOL)img WithArg:(id)arg data:(NSData *)data callBack:(HttpCallBackWithObject)callBack;
//上传试镜项目图片2
+(void)upLoadShootMediaIsImage2:(BOOL)img WithArg:(id)arg data:(NSData *)data callBack:(HttpCallBackWithObject)callBack;
//获取角色列表
+(void)getCastingListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//询问档期
+(void)askDateWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//创建项目角色（单指从询问档期进入）
+(void)creatProjectCastingWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack;
//修改项目角色
+(void)modifyCastingWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack;
//项目修改历史
+(void)checkProjectEditHistoryWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack;
//查询修改项目导致被影响的订单
+(void)checkEffectOdersWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//选择拍摄类别时的总价明细
+(void)getTotalPriceDetailWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
/*******************************************保险相关***************************************/
//创建团体保单
+(void)createInsuranceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//生成订单号
+(void)createOrderNumWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//获取保险列表
+(void)getInsuranceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
/*******************************************优惠券相关***************************************/
//1.优惠券列表
+(void)getCouponListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//2.生成优惠券分享码
+(void)getCouponShareCodeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//3.生成优惠券
+(void)getCoupongenerateCodeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//4.查询优惠券分享码
+(void)getCouponqueryShareCodeWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//5.调整优惠券顺序
+(void)getCouponSortWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

/*******************************************通告相关***************************************/
//获取正在招募的通告列表
+(void)getAnnunciatesWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack;
//获取公告详情
+(void)getAnnunDetailWithArg:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack;
//上传通告图片或视频
+(void)upLoadAnnunciateWithArg:(id)arg type:(NSInteger)type data:(NSData *)data callBack:(HttpCallBackWithObject)callBack;
//通告报名
+(void)applyAnnunciateWith:(NSDictionary *)arg callBack:(HttpCallBackWithObject)callBack;
//1.演员通告报名列表
+(void)getArtistAnnunciateListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//2.演员报名通告详情
+(void)gettArtistAnnunciateDetialWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
/*******************************************上传相关***************************************/
+(void)uploadCommonWithArg:(id)arg data:(id)data callBack:(HttpCallBackWithObject)callBack;
/*******************************************资金相关***************************************/
//1.资金明细
+(void)getCapitalDetailsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//2.添加和更新银行卡和支付宝账号
+(void)updateBankCardAndAliPayWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//3.提现
+(void)getwithdrawCashWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//4.银行卡和支付宝账号列表
+(void)getCardAndAliPayListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
/*******************************************统计相关***************************************/
+(void)staticsWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

/*******************************************买家项目相关***************************************/
//1.查看最新项目
+(void)getViewNewProjectWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//2.锁定档期操作
+(void)getLockScheduleProcessWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//3.买家操作询问档期订单
+(void)getBuyerProcesssWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//4.试镜操作
+(void)getTryVideoProcessWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//5.定妆操作
+(void)getMakeupProcessWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//6.订单详情
+(void)getOrderDetialWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//7.取消订单
+(void)getOrderCancelWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//8.演员操作询问档期订单
+(void)getActorProcessWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;

//9.上传试镜作品
+(void)upLoadTryVideoWithArg:(id)arg data:(NSData *)data callBack:(HttpCallBackWithObject)callBack;

//10.上传最新照片（多张）
+(void)upLoadLastPhotoWithArg:(id)arg data:(NSData *)data callBack:(HttpCallBackWithObject)callBack;

//11 发起试镜
+(void)lauchAuditionOnlineWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//12 问询是否有房间邀请
+(void)askRoomInviteWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//13 房间操作
+(void)roomOperationWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
@end

NS_ASSUME_NONNULL_END
