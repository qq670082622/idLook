/*
 @header  AuthCellD.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/26
 @description
    上传营业执照cell
 */

#import <UIKit/UIKit.h>
#import "AuthModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthCellD : UITableViewCell
@property(nonatomic,copy)void(^selectPhotoBlock)(NSInteger tag);  //选择图片回掉
@property(nonatomic,copy)void(^downloadCerBlock)(void);  //下载授权书回掉
-(void)reloadUIWithModel:(AuthStructModel*)model;
@end

NS_ASSUME_NONNULL_END
