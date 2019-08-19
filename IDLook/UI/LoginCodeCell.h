/*
 @header  LoginCodeCell.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/15
 @description
 
 */

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "VerffyCodeBtn.h"
#import "LoginCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginCodeCell : UITableViewCell
@property(nonatomic,strong)CustomTextField *textField;
@property(nonatomic,strong)VerffyCodeBtn *codeBtn;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)UIButton *voiceBtn;
@property(strong,nonatomic) NSTimer *timer;
@property(assign,nonatomic) NSInteger count;
-(void)reloadUIWithModel:(LoginCellStrutM*)model;
-(void)setTextFieldText:(NSString*)text;

@property (nonatomic,copy)void(^textFDidChanged)(CustomTextField *textF);

@property (nonatomic,copy)void(^getVerificationCodeBlock)(void);

@property(nonatomic,copy)void(^voiceCodeBlock)(void);

@property (nonatomic,copy)void(^getVoiceCodeBlokc)(BOOL get);


@end

NS_ASSUME_NONNULL_END
