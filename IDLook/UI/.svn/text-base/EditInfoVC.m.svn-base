//
//  EditInfoVC.m
//  IDLook
//
//  Created by HYH on 2018/5/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditInfoVC.h"

@interface EditInfoVC ()
@property (nonatomic,strong)CustomTextField *textF;
@property (nonatomic,strong)NSString *parameter;
@end
@implementation EditInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"保存" Target:self action:@selector(save)]]];
    
    EditType type = [self.info[@"type"] integerValue];

    if (type==EditTypeWeiBoName || type ==EditTypeWeiBoFans) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"保存" Target:self action:@selector(save)]]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"确认" Target:self action:@selector(save)]]];
    }
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:self.info[@"title"]]];
    self.textF.placeholder=self.info[@"placeholder"];
    self.textF.text=self.info[@"content"];
    self.parameter=self.info[@"parameter"];
    self.textF.keyboardType=UIKeyboardTypeDefault;
    
    if (type==EditTypeWeiBoName) {
        
        self.textF.keyboardType=UIKeyboardTypeDefault;
        
        self.textF.text=[UserInfoManager getUserSinaName];
    }
    else if (type==EditTypeWeiBoFans)
    {
        self.textF.keyboardType=UIKeyboardTypeDecimalPad;
        self.textF.isNumber=YES;
        
        UILabel *rightLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,35,44)];
        rightLab.text=@"万";
        rightLab.textColor=Public_Text_Color;
        rightLab.textAlignment=NSTextAlignmentLeft;
        rightLab.font=[UIFont systemFontOfSize:14.0];
        self.textF.rightView=rightLab;
        self.textF.rightViewMode=UITextFieldViewModeAlways;
        
        if ([self.info[@"content"] length]) {
            NSString *strUrl = [self.info[@"content"] stringByReplacingOccurrencesOfString:@"万" withString:@""];  //替换字符
            self.textF.text=strUrl;
        }
    }
    else if (type==EditTypeEmail)
    {
        self.textF.keyboardType=UIKeyboardTypeEmailAddress;
    }
    else if (type==EditTypeUrgentPhone1 || type==EditTypeUrgentPhone2 || type==EditTypePostCode)
    {
        self.textF.keyboardType=UIKeyboardTypePhonePad;
    }
    
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    BOOL isRequired = [self.info[@"isRequired"] boolValue];
    if (isRequired==YES && self.textF.text.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    if ([self.textF.text isEqualToString:self.info[@"content"]]) {  //未修改
        [self onGoback];
        self.didSelectBlock(self.textF.text);
        return;
    }
    
    EditType type = [self.info[@"type"] integerValue];
    if(type==EditTypeUrgentPhone1 || type==EditTypeUrgentPhone2)
    {
        if (self.textF.text.length) {
            if (!IsCorrectPhoneNumber(self.textF.text))
            {
                if (!IsCorrectFixedTelephoneNumber(self.textF.text)) {
                    [SVProgressHUD showErrorWithStatus:@"请正确填写联系电话"];
                    return;
                }
            }
        }
    }
    else if (type==EditTypePostCode && self.textF.text.length>6)
    {
        [SVProgressHUD showErrorWithStatus:@"邮编最多输入六位数字"];
        return;
    }
    
    
    BOOL isSave = [self.info[@"isSave"] boolValue];

    if (isSave) {  //是否直接保存
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dicAry =@{@"userid":[UserInfoManager getUserUID],
                                self.parameter:self.textF.text};
        [AFWebAPI modifMyotherInfoWithAry:dicAry callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                NSDictionary *dic = [object objectForKey:JSON_data];
                UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
                [UserInfoManager setUserLoginfo:uinfo];
                
                [self onGoback];
                self.didSelectBlock(self.textF.text);
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    else
    {
        [self onGoback];
        self.didSelectBlock(self.textF.text);
    }
}

- (CustomTextField *)textF
{
    if(!_textF)
    {
        _textF = [[CustomTextField alloc] init];
        _textF.text=@"";
        [_textF addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged];
        _textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textF.borderStyle = UITextBorderStyleNone;
        _textF.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_textF];
        [_textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(20);
            make.height.equalTo(@(44));
        }];
//        [_textF becomeFirstResponder];
        
        UIView *leftV=[[UIView alloc]initWithFrame:CGRectMake(0, 0,20, 0)];
        _textF.leftView=leftV;
        _textF.leftViewMode=UITextFieldViewModeAlways;
        
        UIView *rightV=[[UIView alloc]initWithFrame:CGRectMake(0, 0,20, 0)];
        _textF.rightView=rightV;
        _textF.rightViewMode=UITextFieldViewModeAlways;
    }
    return _textF;
}

- (void)textFieldDidChange:(UITextField *)textField
{

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
