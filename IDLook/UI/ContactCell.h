/*
 @header  ContactCell.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/30
 @description
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactCell : UITableViewCell
-(void)reloadUIWithDic:(NSDictionary*)dic;
@end

NS_ASSUME_NONNULL_END