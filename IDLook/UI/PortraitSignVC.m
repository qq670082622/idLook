//
//  PortraitSignVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/7/22.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "PortraitSignVC.h"

@interface PortraitSignVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView1;
@property (weak, nonatomic) IBOutlet UIView *backView2;

@property (weak, nonatomic) IBOutlet UIImageView *actiorHead;
@property (weak, nonatomic) IBOutlet UILabel *actorName;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
@property (weak, nonatomic) IBOutlet UITextField *daiLiFangField;
@property (weak, nonatomic) IBOutlet UITextField *zhiZuoFangField;
@property (weak, nonatomic) IBOutlet UITextField *shiYongFangField;
@property (weak, nonatomic) IBOutlet UITextField *keHuFangField;
@property (weak, nonatomic) IBOutlet UITextField *pinPaiChanPinField;
@property (weak, nonatomic) IBOutlet UITextField *guangGaoMingField;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
- (IBAction)ensure:(id)sender;

@end

@implementation PortraitSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backView1.layer.cornerRadius = 8;
    self.backView1.layer.masksToBounds = YES;
    self.backView2.layer.cornerRadius = 8;
    self.backView2.layer.masksToBounds = YES;
    self.ensureBtn.layer.cornerRadius = 8;
    self.ensureBtn.layer.masksToBounds = YES;
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"签署肖像授权书"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.actorName.text = _actorNametr;
    self.roleName.text = _roleNametr;
    [self.actiorHead sd_setImageWithUrlStr:_actiorHeadStr placeholderImage:[UIImage imageNamed:@"default_home"]];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


- (IBAction)ensure:(id)sender {
    if (_daiLiFangField.text.length==0 ||_zhiZuoFangField.text.length==0 ||_shiYongFangField.text.length==0 ||_keHuFangField.text.length==0 ||_pinPaiChanPinField.text.length==0 ||_guangGaoMingField.text.length==0 ) {
        [SVProgressHUD showImage:nil status:@"请完整填写授权书信息"];
        return;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
   
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -120, self.view.frame.size.width, self.view.frame.size.height);
      
        }];
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
   
        //    //视图下沉恢复原状
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
