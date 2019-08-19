//
//  LoginCustomCell.h
//  IDLook
//
//  Created by HYH on 2018/4/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "VerffyCodeBtn.h"
#import "LoginCellModel.h"


@interface LoginCustomCell : UITableViewCell
@property(nonatomic,strong)CustomTextField *textField;
//@property(nonatomic,strong)UITextField *textField;
-(void)reloadUIWithModel:(LoginCellStrutM*)model;
-(void)setTextFieldText:(NSString*)text;

@property (nonatomic,copy)void(^textFDidChanged)(CustomTextField *textF);

@end
