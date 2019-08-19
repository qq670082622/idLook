/*
 @header  ShotStepCellD.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/27
 @description
     填写推荐人cell
 */

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

@interface ShotStepCellD : UITableViewCell

@property(nonatomic,copy)void(^textFieldChangeBlock)(NSString *text);
@property(nonatomic,copy)void(^BeginEdit)(void);  //开始编辑

@property(nonatomic,strong)UITextField *textField;
-(void)reloadUIWithModel:(OrderStructM*)model;

@end

