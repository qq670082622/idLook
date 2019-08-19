/*
 @header  SharePopV.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/25
 @description
 
 */

#import <UIKit/UIKit.h>


@interface SharePopV : UIView
@property(nonatomic,copy)void(^shareBlock)(NSInteger tag);
- (void)hide;
-(void)showBottomShare;
-(void)showBottomShareWithReturnView:(UIView *)returnView andQRCodeImg:(UIImage *)img;
@property(nonatomic,copy)void(^hideBlock)(void);

@end


@interface ShareCell : UIView
@property(nonatomic,copy)void(^ShareCellBlock)(NSInteger tag);

-(void)loadCellWithImage:(NSString*)icon withTitle:(NSString*)title;

@end
