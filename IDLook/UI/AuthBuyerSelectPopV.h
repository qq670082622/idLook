/*
 @header  AuthBuyerSelectPopV.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/22
 @description
      认证购买方类型选择弹出视图
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthBuyerSelectPopV : UIView
@property(nonatomic,copy)void(^authTypeSelectBlock)(NSInteger type);

-(void)show;
@end

NS_ASSUME_NONNULL_END
