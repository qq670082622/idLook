//
//  UserInfoManager.h
//  IDLook
//
//  Created by HYH on 2018/4/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoM.h"

typedef NS_ENUM(NSInteger,UserLoginType) {
    UserLoginTypeTourist    =-1,    //游客登录
    UserLoginTypeMobile =0,  //手机
    UserLoginTypeWX     =1,  //微信
    UserLoginTypeSina   =2,  //微博
    
};

//用户类型
typedef NS_ENUM(NSInteger,UserType)
{
    UserTypePurchaser=1,  //购买方
    UserTypeResourcer   //资源方
};

//用户子类型
typedef NS_ENUM(NSInteger,UserSubType)
{
    UserSubTypePurPersonal=3,                              //购买方 个人
    UserSubTypePurProductionCompanyPhotography=13,        // 制作公司 平面摄影
    UserSubTypePurProductionCompanyFilm=14,               // 制作公司 影视制作
    UserSubTypePurProductionCompanyDesign=15,             // 制作公司  设计公司
    UserSubTypePurAdvertisingAgent=16,                    //广告代理商  广告代理
    UserSubTypePurAdvertisingAgentDigital=17,             //广告代理商 数字营销
    UserSubTypePurRelationsService=18,                    //公关公司 公关服务
    UserSubTypePurRelationsEconomy=19,                    //公关公司 公关经纪
    UserSubTypePurEventPlanning=20,                       //活动公司  企业策划
    UserSubTypePurActivityService=21,                     //活动公司  活动服务
    UserSubTypePurBusinessBrand=8,                        //企业品牌部/策划部/市场部
    UserSubTypePurAll=28,         //购买方企业全部
    
    UserSubTypeResActorModel=9,                          //演员模特 限个人
    UserSubTypeResStarArtistPersonal=22,                  //明星艺人  个人
    UserSubTypeResStarArtistCompany=23,                   //明星艺人   经纪公司
    UserSubTypeResICPersonal=24,                          //网络红人   个人
    UserSubTypeResICCompany=25,                           //网络红人   经纪公司
    UserSubTypeResSportsStarsPersonal=26,                 //体育明星   个人
    UserSubTypeResSportsStarsCompany=27                   //体育明星   机构
    
};

@interface UserInfoManager : NSObject



/*********************************************用户信息相关************************************************************/

//
+ (void)setUserLoginfo:(UserInfoM *)info;
+ (void)clearUserLoginfo;

//登录类型
+ (void)setUserLoginType:(UserLoginType)type;
+ (UserLoginType)getUserLoginType;

//检测历史登录状态
+ (UserLoginType)checkWhetherHasLogined;

//公共基础配置
+ (void)setPublicConfig:(NSDictionary *)config;
+ (NSDictionary *)getPublicConfig;

//UID
+ (void)setUserUID:(NSString *)UID;
+ (NSString *)getUserUID;

//手机号
+ (void)setUserMobile:(NSString *)phoneNum;
+ (NSString *)getUserMobile;

//密码
+ (void) setUserPwd:(NSString *)pwd;
+ (NSString *)getUserPwd;

//第三方登录openID
+ (void)setUserOpenID:(NSString *)openID;
+ (NSString *)getUserOpenID;

//用户类型
+ (void)setUserType:(UserType)type;
+ (UserType)getUserType;

//用户子类型
+ (void)setUserSubType:(UserSubType)type;
+ (UserSubType)getUserSubType;

//用户头像
+ (void)setUserHead:(NSString *)head;
+ (NSString *)getUserHead;

//用户昵称
+ (void)setUserNick:(NSString *)nick;
+ (NSString *)getUserNick;

//用户真实姓名
+ (void)setUserRealName:(NSString *)name;
+ (NSString *)getUserRealName;

//用户出生日期
+ (void)setUserBirth:(NSString *)birth;
+ (NSString *)getUserBirth;

//用户国籍
+ (void)setUserNationality:(NSString *)nationality;
+ (NSString *)getUserNationality;

//性别
+ (void)setUserSex:(NSInteger)sex;
+ (NSInteger)getUserSex;

//所在地
+ (void)setUserRegion:(NSString *)region;
+ (NSString *)getUserRegion;

//通讯地址
+ (void)setUserAddress:(NSString *)address;
+ (NSString *)getUserAddress;

//邮编
+ (void)setUserPostalCode:(NSString*)code;
+ (NSString*)getUserPostalCode;

//联系电话1
+ (void)setUserContactnumber1:(NSString *)number;
+ (NSString *)getUserContactnumber1;

//联系电话2
+ (void)setUserContactnumber2:(NSString *)number;
+ (NSString *)getUserContactnumber2;

//邮箱
+ (void)setUserEmail:(NSString *)email;
+ (NSString *)getUserEmail;

//艺人用户基本资料   身高，体重，胸围，腰围，臀围，鞋码
+ (void)setUserBasicInfo:(NSInteger)value WithType:(PickerType)type;
+ (NSInteger)getUserBasicInfoWithType:(PickerType)type;

//艺人职业
+ (void)setUserOccupation:(NSInteger)occupation;
+ (NSInteger)getUserOccupation;

//专精
+ (void)setUserMastery:(NSInteger)mastery;
+ (NSInteger)getUserMastery;

//艺人毕业院校
+ (void)setUserSchoolInfo:(NSString *)info;
+ (NSString *)getUserSchoolInfo;

//艺人年级
+ (void)setUserGrade:(NSString *)grade;
+ (NSString *)getUserGrade;

//艺人专业
+ (void)setUserSpecialty:(NSString *)specialty;
+ (NSString *)getUserSpecialty;

//艺人主页头像
+ (void)setUserBackGround:(NSString *)background;
+ (NSString *)getUserBackGround;

//艺人审核头像
+ (void)setUserAudit:(NSString *)audit;
+ (NSString *)getUserAudit;

//艺人审核头像缩略图
+ (void)setUserMiniaudit:(NSString *)miniaudit;
+ (NSString *)getUserMiniaudit;

//艺人头像审核状态
+ (void)setUserHeadstatus:(NSInteger)headstatus;
+ (NSInteger)getUserHeadstatus;

//代表作品
+ (void)setUserTypicalworks:(NSString *)works;
+ (NSString *)getUserTypicalworks;

//简介
+ (void)setUserBrief:(NSString *)brief;
+ (NSString *)getUserBrief;

//所属身份年龄段
+ (void)setUserAgeType:(NSInteger)age;
+ (NSInteger)getUserAgeType;

//擅长表演类型
+(void)setPerformingTypes:(NSString*)type;
+(NSString*)getPerformingTypes;

//可开放微出镜图片类别
+(void)setExploitableMirrPhotos:(NSString*)type;
+(NSString*)getExploitableMirrPhotos;

//可开放微出镜视频类别
+(void)setExploitableMirrVideos:(NSString*)type;
+(NSString*)getExploitableMirrVideos;


//授权书列表
+(void)setUserAuthorizationList:(NSArray*)list;
+(NSArray*)getUserAuthorizationList;

//认证状态   0.未提交审核 1.审核成功  2.审核失败  3.审核中。//1正常，2不通过，0待审核，目前默认正常
+ (void)setUserAuthState:(NSInteger)auth;
+ (NSInteger)getUserAuthState;
+ (void)setUserAuthState_wm:(NSInteger)auth;
+ (NSInteger)getUserAuthState_wm;
//微博名字
+(void)setUserSinaName:(NSString*)name;
+(NSString*)getUserSinaName;

//微博粉丝数，万为单位
+ (void)setUserSinaFansNumber:(CGFloat)number;
+ (CGFloat)getUserSinaFansNumber;


//银行卡号
+(void)setUserBankCard:(NSString*)bankcard;
+(NSString*)getUserBankCard;

//开户行
+(void)setUserBankName:(NSString*)bankName;
+(NSString*)getUserBankName;

//银行卡户名
+(void)setUserBankUser:(NSString*)user;
+(NSString*)getUserBankUser;

//支付宝账号
+(void)setUserAlipay:(NSString*)alipay;
+(NSString*)getUserAlipay;

//支付宝姓名
+(void)setUserAlipayName:(NSString*)alipayName;
+(NSString*)getUseralipayName;

//未读系统消息个数
+ (void)setUnreadCount:(NSInteger)count;
+ (NSInteger)getUnreadCount;

//搜索历史
+(void)setSearchHistory:(NSArray*)array;
+(NSArray*)getSearchHistoryType;

//公司名称
+(void)setUserCompanyName:(NSString*)name;
+(NSString*)getUserCompanyName;

//管理员名字
+(void)setUserBuyerName:(NSString*)name;
+(NSString*)getUserBuyerName;

//语言
+(void)setUserLanguage:(NSString*)language;
+(NSString*)getUserLanguage;

//方言
+(void)setUserLocalism:(NSString*)localism;
+(NSString*)getUserLocalism;

//是否工作室演员
+ (void)setUserStudio:(NSInteger)studio;
+ (NSInteger)getUserStudio;

//艺人是否资料完善类型
+ (void)setUserCompletInfo:(NSInteger)value WithType:(NSInteger)type;
+ (NSInteger)getUserCompletInfoWithType:(NSInteger)type;

//是否显示底部认证
+ (void)setAuthBottomShow:(BOOL)show;
+ (BOOL)getAuthBottom;

//用户状态和vip状况   1开头表示用户状态;* 100正常，101注销，102待审核，104黑名单;2开头表示用户等级;* 200普通用户，201vip用户，202超级vip,
+ (void)setUserStatus:(NSInteger)status;
+ (NSInteger)getUserStatus;

//折扣率
+ (void)setUserDiscount:(float)discount;
+ (float)getUserDiscount;

/**********************************************************用户设置***********************************************************/

//新消息通知
+ (void)setMsgNotify:(BOOL)notify;
+ (NSInteger)getMsgNotify;


//声音
+ (void)setUserSoundOn:(BOOL)on;
+ (BOOL)getSoundStatus;

//震动
+ (void)setUserVibirateOn:(BOOL)on;
+ (BOOL)getUserVibirateStatus;

//4g网络下 是否自动播放
+ (void)setWWanAuthPlay:(BOOL)play;
+ (BOOL)getWWanAuthPlay;

//4g网络下 是否每次询问
+ (void)setAskEachTime:(BOOL)ask;
+ (BOOL)getAskEachTime;

//是否自动播放 wifi网络下
+ (void)setWifiAuthPlay:(BOOL)play;
+ (BOOL)getWifiAuthPlay;

//是否第一次设置网络
+ (void)setNetworkSettingFirst:(BOOL)first;
+ (BOOL)getNetworkSettingFirst;

//列表播放是否静音
+ (void)setListPlayIsMute:(BOOL)mute;
+ (BOOL)getListPlayIsMute;

//是否弹出优惠券说明弹窗
+ (void)setPopupCoupon:(BOOL)pop;
+ (BOOL)getPopupCoupon;

/**********************************************************动态配置***********************************************************/
//图片压缩比例
+ (void)setScaleRatio:(NSString *)ratio;
+ (NSInteger)getScaleRatio;
//判断app是否是首次启动（首次安装的启动，非更新的启动）
+ (void)setFirstLauch;
+ (BOOL)getFirstLauch;
//设置为java后台，不设置默认不是
+ (void)setIsJavaService:(BOOL)isJava;
+ (BOOL)getIsJavaService;
//存取token
+ (void)setAccessToken:(NSString *)token;
+ (NSString *)getAccessToken;
//存取refreshToken
+ (void)setRefreshToken:(NSString *)token;
+ (NSString *)getRefreshToken;
//存取上次视频播放时间
+(void)setLastestVideoPlayTime:(NSInteger)time;
+(long)getLastedVideoPlayTime;
@end
