//
//  VipApplyView.m
//  IDLook
//
//  Created by 吴铭 on 2019/10/11.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "VipApplyView.h"
@interface VipApplyView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;

@property (weak, nonatomic) IBOutlet UIView *nameBG;
@property (weak, nonatomic) IBOutlet UIView *phoneNumBG;
@property (weak, nonatomic) IBOutlet UIView *remarkBG;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *remarkField;
- (IBAction)repply:(id)sender;
- (IBAction)contact:(id)sender;

@end
@implementation VipApplyView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"VipApplyView" owner:nil options:nil] lastObject];
    }
    [self initUI];
 return self;
}
-(void)initUI
{
    self.nameField.delegate = self;
    self.phoneNumField.delegate = self;
    self.remarkField.delegate = self;
    self.bgImg.layer.cornerRadius = 13;
    self.bgImg.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    self.nameBG.layer.cornerRadius = 5;
    self.nameBG.layer.masksToBounds = YES;
    self.phoneNumBG.layer.cornerRadius = 5;
    self.phoneNumBG.layer.masksToBounds = YES;
    self.remarkBG.layer.cornerRadius = 5;
    self.remarkBG.layer.masksToBounds = YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameField resignFirstResponder];
    [self.phoneNumField resignFirstResponder];
    [self.remarkField resignFirstResponder];
    return YES;
}
- (IBAction)repply:(id)sender {
    if (_nameField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写您的姓名"];
        return;
    }
    if (_phoneNumField.text.length==0) {
          [SVProgressHUD showImage:nil status:@"请填写您的电话号码"];
              return;
    }
    self.reply(_nameField.text, _phoneNumField.text, _remarkField.text);
}

- (IBAction)contact:(id)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:400-833-6969"];
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
