/*
 @header  PublicTopV.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/16
 @description
    公共头部视图
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicTopV : UIView

@property(nonatomic,copy)void(^ClickTypeBlock)(NSInteger type);

-(id)initWithDataSource:(NSArray*)dataSource;

-(void)slideWithTag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
