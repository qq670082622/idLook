/*
 @header  ShotNoticePopV.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/23
 @description
     拍摄下单须知
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShotNoticePopV : UIView
@property(nonatomic,copy)void(^agreeAndPayBlock)(void);   //同意并支付
@property(nonatomic,copy)void(^TimercountDownBlock)(NSInteger count);   //倒计时

/**
 ui显示
 @param count 倒计时时间
 */
-(void)showWithCountDown:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
