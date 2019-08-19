/*
 @header  PlayContinuePopV.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/29
 @description
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayContinuePopV : UIView
@property(nonatomic,copy)void(^ContinueBlock)(void);
-(void)show;

@end

NS_ASSUME_NONNULL_END
