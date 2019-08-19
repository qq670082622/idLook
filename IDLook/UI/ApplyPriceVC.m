//
//  ApplyPriceVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/10.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ApplyPriceVC.h"

@interface ApplyPriceVC ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *castingName;

@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UITextField *wantPriceField;
@property (weak, nonatomic) IBOutlet UILabel *yellowTip;

@property (weak, nonatomic) IBOutlet UIView *backView1;
@property (weak, nonatomic) IBOutlet UITextView *reasonField;
@property (weak, nonatomic) IBOutlet UILabel *reasonTip;
@property (weak, nonatomic) IBOutlet UILabel *countTip;

@property (weak, nonatomic) IBOutlet UIView *backView2;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)applyAction:(id)sender;

@end

@implementation ApplyPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn.layer.cornerRadius = 8;
    self.btn.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
    self.yellowTip.hidden = YES;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"申请议价"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    if (_applyedPrice>0) {
        self.wantPriceField.text = [NSString stringWithFormat:@"%ld",_applyedPrice];
        [self textFieldDidEndEditing:_wantPriceField];
        self.reasonField.text = _applyReason;
        if (_applyReason.length>0) {
            _reasonTip.hidden = YES;
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_info.sex==1) {//男
        self.sex.image = [UIImage imageNamed:@"icon_male"];
    }else{
        self.sex.image = [UIImage imageNamed:@"icon_female"];
    }
    self.name.text = _info.nickName;
    self.castingName.text = [NSString stringWithFormat:@"饰演角色：%@",_castingNameStr];
    self.city.text = [NSString stringWithFormat:@"• %@",_info.region];
    [self.name sizeToFit];
    [self.city sizeToFit];
   [self.icon sd_setImageWithUrlStr:_info.avatar placeholderImage:[UIImage imageNamed:@"icon_normal"]];
    self.name.frame = CGRectMake(64, 15, _name.width, 23);
    self.sex.x = _name.right+8;
    self.city.frame = CGRectMake(_sex.right+8, 19, _city.width, 16);
    
    self.price.text = [NSString stringWithFormat:@"￥%ld",_actorPrice];
}
- (IBAction)applyAction:(id)sender {
    if (_reasonField.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请填写议价理由"];
        return;
    }
    if (_wantPriceField.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请填写预算价格"];
        return;
    }
    if ([_wantPriceField.text integerValue]>_actorPrice || [_wantPriceField.text integerValue]==_actorPrice) {
       [SVProgressHUD showErrorWithStatus:@"预算价格应低于报价"];
        return;
    }
    //预算申请
    self.applyPrice([[_wantPriceField.text stringByReplacingOccurrencesOfString:@"￥" withString:@""] integerValue], _reasonField.text);
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>0)
    {
        self.reasonTip.hidden=YES;
    }
    else
    {
        self.reasonTip.hidden=NO;
    }
    self.countTip.text = [NSString stringWithFormat:@"%ld/500",textView.text.length];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length>0) {
     //   self.yellowTip.hidden = NO;
        if ([textField.text containsString:@"￥"]) {
            textField.text = textField.text;
        }else{
        textField.text = [NSString stringWithFormat:@"￥%@",textField.text];
        }
    }
  //  self.backView1.y = _yellowTip.bottom+15;
 //   self.backView2.y = _backView1.bottom;
}


#pragma mark - textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length>499) {
        if (text.length==0) {//在删除
            return YES;
        }else if (text.length>0 && ![text isEqualToString:@"\n"]) //还想加字，不允许
        {
            return NO;
        }
    }
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}
//-(BOOL)textfiel
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length>6) {
        if (string.length==0) {//在删除
            return YES;
        }else if (string.length>0) //还想加字，不允许
        {
            return NO;
        }
    }
    if ([string isEqualToString:@"\n"]) {
        
        [textField resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
