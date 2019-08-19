/*
 @header  AuthBuyerVC.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/16
 @description
     购买方认证
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthBuyerVC : UIViewController

/**
 购买方类型 0:个人。 1:企业
 */
@property(nonatomic,assign)NSInteger buyType;

/**
 升级成企业买家的data
 */
@property(nonatomic,strong)NSDictionary *upgradeDic;

@end

NS_ASSUME_NONNULL_END
