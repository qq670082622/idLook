/*
 @header  ShotFootV.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/22
 @description
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShotFootV : UIView
@property(nonatomic,copy)void(^takePhoneBlock)(void);  //打电话
@property(nonatomic,copy)void(^upgradeBlock)(void);  //升级
@property(nonatomic,copy)void(^protocolBlock)(void);  //协议

@end

NS_ASSUME_NONNULL_END
