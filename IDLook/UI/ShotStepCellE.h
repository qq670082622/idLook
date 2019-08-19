/*
 @header  ShotStepCellE.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/8
 @description
    拍摄下单cell  ,外籍演员
 */

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShotStepCellE : UITableViewCell
@property(nonatomic,copy)void(^BeginEdit)(void);  //开始编辑
@property(nonatomic,copy)void(^showDetialPopV)(void);  //外模popv

@property(nonatomic,strong)UITextField *textField;
-(void)reloadUIWithModel:(OrderStructM*)model;
@end

NS_ASSUME_NONNULL_END