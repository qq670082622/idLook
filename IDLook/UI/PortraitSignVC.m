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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    self.actiorHead.layer.cornerRadius = 22;
    self.actiorHead.layer.masksToBounds = YES;
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
    if (_shiYongFangField.text.length==0 ||_keHuFangField.text.length==0 ||_pinPaiChanPinField.text.length==0 ||_guangGaoMingField.text.length==0 ) {
        [SVProgressHUD showImage:nil status:@"请完整填写授权书信息"];
        return;
    }
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *arg = @{
                          @"adTopic":self.guangGaoMingField.text,//广告篇名
                          @"agency":self.daiLiFangField.text.length>0?self.daiLiFangField.text:@"",//代理方
                          @"company":self.keHuFangField.text,//企业客户方
                          @"portraitUser":self.shiYongFangField.text,//肖像使用方
                          @"producer":self.zhiZuoFangField.text.length>0?self.zhiZuoFangField.text:@"",//制作方
                          @"product":self.pinPaiChanPinField.text,//品牌产品
                          @"shotId":_orderId,//拍摄订单主键ID
                          @"userId":@([[UserInfoManager getUserUID] integerValue]),
                          @"roleId":@(_roleId)
                          };
    [AFWebAPI_JAVA createPortraitsignWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD dismiss];
            self.created();
            [SVProgressHUD showImage:nil status:@"已发送，请等待审核"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:(NSString *)object];
        }
    }];
    
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
  self.scrollView.contentOffset = CGPointMake(0, 120);
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
  self.scrollView.contentOffset = CGPointMake(0, 0);
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
