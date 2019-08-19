/*
 @header  LoginCellModel.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/15
 @description
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LRCellType)
{
    LRCellTypePhone=0,       //手机号
    LRCellTypePassword,      //密码
    LRCellTypeVerificationCode,   //验证码
    LRCellTypeIdentity        //身份
};

@interface LoginCellModel : NSObject

/**
 获取登录数据
 @return 数组
 */
+(NSArray*)getLoginDataSource;

/**
 获取注册数据
 @return 数组
 */
+(NSArray*)getReginDataSource;

/**
 获取重置密码数据
 @return 数组
 */
+(NSArray*)getResetPswDataSource;

/**
 获取更换手机号第一步数据
 @return 数组
 */
+(NSArray*)getChangeMobileStep1DataSource;

/**
 获取更换手机号地二步数据
 @return 数组
 */
+(NSArray*)getChangeMobileStep2DataSource;

@end

@interface LoginCellStrutM : NSObject

/**
 图片
 */
@property(nonatomic,copy)NSString *imageN;

/**
 提示文字
 */
@property(nonatomic,copy)NSString *placeholder;

/**
 内容
 */
@property(nonatomic,copy)NSString *content;

/**
 cell类型
 */
@property(nonatomic,assign)LRCellType cellType;

/**
 用户类型 1:购买方。1:资源方
 */
@property(nonatomic,assign)UserType userType;

/**
 购买方类型。 0:个人。 1:公司
 */
@property(nonatomic,assign)NSInteger buyType;

/**
 是否显示语言验证
 */
@property(nonatomic,assign)BOOL isShowVoiceCode;


-(id)initWithDic:(NSDictionary*)dic;


@end

NS_ASSUME_NONNULL_END
