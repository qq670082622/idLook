//
//  ResetPasswordVC.m
//  IDLook
//
//  Created by HYH on 2018/4/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "LoginCustomCell.h"
#import "LoginCellModel.h"
#import "LoginCodeCell.h"
#import "VoiceCodePopV.h"

@interface ResetPasswordVC ()<UITableViewDataSource,UITableViewDelegate,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)UIView *bgV;

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    self.dataSource=[LoginCellModel getResetPswDataSource];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)initUI
{
    UILabel *title=[[UILabel alloc]init];
    title.font=[UIFont boldSystemFontOfSize:17.0];
    title.textColor=[UIColor colorWithHexString:@"FF4A57"];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(74);
    }];
    
    if (self.type==0) {
        title.text=@"找回密码";
    }
    else
    {
        title.text=@"修改密码";
    }
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"btn_public_back_n"] forState:UIControlStateNormal];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bg=[[UIView alloc]init];
    bg.layer.cornerRadius=4.0;
    bg.layer.shadowOffset = CGSizeMake(5, 5);
    bg.layer.shadowOpacity = 0.8;
    bg.layer.shadowColor = [[UIColor colorWithHexString:@"#525252"] colorWithAlphaComponent:0.1].CGColor;
    bg.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(118);
        make.height.mas_equalTo(70*self.dataSource.count);
    }];
    self.bgV=bg;
    [self tableV];
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,118,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-118) style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.scrollEnabled = NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.touchDelegate=self;
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        _tableV.tableFooterView=[self tableFooterV];
    }
    return _tableV;
}


- (UIView *)tableFooterV
{
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,0,100}];
    view.backgroundColor=[UIColor clearColor];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn" ] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn" ] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"确认重置" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(doReset) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.enabled = YES;
    [view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.right.equalTo(view).offset(-15);
        make.height.equalTo(@45);
        make.top.equalTo(view).offset(25);
    }];
    return view;
}

//返回
-(void)back
{
    if (self.isPush) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }
}


//  确认重置
-(void)doReset
{
    [self.view endEditing:YES];
    
    LoginCustomCell *cellAcc = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    LoginCodeCell *cellCode = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    LoginCustomCell *cellPsw = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    LoginCustomCell *cellPsw2 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

    
    if(!IsCorrectPhoneNumber(cellAcc.textField.text))
    {
        [SVProgressHUD showErrorWithStatus:@"请填写正确手机号码"];
        return;
    }
    if (cellCode.textField.text.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请填写验证码"];
        return;
    }
    if (cellPsw.textField.text.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (![cellPsw.textField.text isEqualToString:cellPsw2.textField.text]) {
        [SVProgressHUD showErrorWithStatus:@"输入的密码不一致"];
        return;
    }
    
    if (self.type==0) {  //找回密码
         [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        if ([UserInfoManager getIsJavaService]) {//java后台
            NSDictionary *dicArg= @{@"mobile":cellAcc.textField.text,
                                  //  @"verifyType":@"2",
                                    @"password":MD5Str(cellPsw.textField.text),
                                    @"verifyCode":cellCode.textField.text};
            [AFWebAPI_JAVA doFindPasswordWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    [SVProgressHUD showSuccessWithStatus:@"密码已重置，请重新登录"];
                    
                    [UserInfoManager clearUserLoginfo];
                    
                    AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [dele showLRVC];
                }else{
                    [SVProgressHUD showErrorWithStatus:object];
                }
            }];
        }else{
        NSDictionary *dicArg= @{@"mobile":cellAcc.textField.text,
                                @"userid":[UserInfoManager getUserUID],
                                @"password":MD5Str(cellPsw.textField.text),
                                @"codekey":cellCode.textField.text};
        [AFWebAPI doFindPasswordWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"密码已重置，请重新登录"];
                
                [UserInfoManager clearUserLoginfo];
                
                AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [dele showLRVC];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
        }
    }
    else  //修改密码
    {
      
         [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        if ([UserInfoManager getIsJavaService]) {//java后台
            NSDictionary *dicArg= @{@"mobile":cellAcc.textField.text,
                                  //  @"verifyType":@"2",
                                    @"password":MD5Str(cellPsw.textField.text),
                                    @"verifyCode":cellCode.textField.text};
            [AFWebAPI_JAVA doFindPasswordWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    [SVProgressHUD showSuccessWithStatus:@"密码已重置，请重新登录"];
                    
                    [UserInfoManager clearUserLoginfo];
                    
                    AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [dele showLRVC];
                }else{
                    [SVProgressHUD showErrorWithStatus:object];
                }
            }];
        }else{
        NSDictionary *dicArg= @{@"mobile":cellAcc.textField.text,
                                @"userid":[UserInfoManager getUserUID],
                                @"password":MD5Str(cellPsw.textField.text),
                                @"codekey":cellCode.textField.text};
        
        [AFWebAPI doModifPasswordWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"密码修改成功，请重新登录"];
                
                [UserInfoManager clearUserLoginfo];
                
                AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [dele showLRVC];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
            }
    }
}


#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginCellStrutM *model = self.dataSource[indexPath.row];
    if (model.cellType==LRCellTypeVerificationCode && model.isShowVoiceCode==YES)
    {
        return 90;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginCellStrutM *model = self.dataSource[indexPath.row];
    LRCellType cellType = model.cellType;
    if (cellType==LRCellTypeVerificationCode) {
        static NSString *identifer = @"LoginCodeCell";
        LoginCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[LoginCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        WeakSelf(self);
        cell.textFDidChanged = ^(CustomTextField *textF) {
            model.content = textF.text;
        };
        cell.getVerificationCodeBlock = ^{
            [weakself getVerificationCodeWithType:1];
        };
        WeakSelf(cell);
        cell.voiceCodeBlock = ^{
            model.isShowVoiceCode=YES;
            [weakself.tableV beginUpdates];
            [weakself.tableV endUpdates];
            weakcell.desc.hidden=NO;
            weakcell.voiceBtn.hidden=NO;
            [weakself.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(70*(weakself.dataSource.count)+20);
            }];
        };
        cell.getVoiceCodeBlokc = ^(BOOL get) {
            if (get) {
                [weakself getVerificationCodeWithType:2];
            }
        };
        [cell reloadUIWithModel:model];
        return cell;
    }
    else
    {
        static NSString *identifer = @"LoginCustomCell";
        LoginCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[LoginCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.textFDidChanged = ^(CustomTextField *textF) {
                model.content=textF.text;
            };
        }
        
        [cell reloadUIWithModel:model];
        return cell;
    }
    return nil;
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark - others


-(void)getVerificationCodeWithType:(NSInteger)type
{
    [self.view endEditing:YES];
  LoginCodeCell *cellCode = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    LoginCustomCell *cellAcc = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if(!IsCorrectPhoneNumber(cellAcc.textField.text))
    {
        [SVProgressHUD showErrorWithStatus:@"请正确填写手机号码"];
        if (type==2) {//获取语音验证码时，手机号不对需要重制cellCode的计数
            [cellCode.timer invalidate];
            cellCode.count=30;
        }
        return;
    }
    
    if(_type!=0)//修改密码
    {
        if (![cellAcc.textField.text isEqualToString:[UserInfoManager getUserMobile]]) {
            [SVProgressHUD showErrorWithStatus:@"手机号不是该账户绑定的手机号"];
           if (type==2) {//获取语音验证码时，手机号不对需要重制cellCode的计数
                    [cellCode.timer invalidate];
                    cellCode.count=30;
                }
            return;
        }
    }
                 NSLog(@"绑定号%@，填写号%@",[UserInfoManager getUserMobile],cellAcc.textField.text);
  
    if ([UserInfoManager getIsJavaService]) {//java后台
        NSDictionary *dic = @{@"mobile":cellAcc.textField.text,
                              @"verifyType":@(2),
                              };
        [AFWebAPI_JAVA getVerCodeWithArg:dic type:type callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                if (type==1) {
                    [SVProgressHUD showSuccessWithStatus:@"获取成功，请查收。"];
                    [cellCode.codeBtn timeFailBeginFrom:30];
                }
                else
                {
                    VoiceCodePopV *popV = [[VoiceCodePopV alloc]init];
                    [popV show];
                }
            }else{
                 [SVProgressHUD showErrorWithStatus:object];
                if (type==2) {//获取语音验证码时，手机号不对需要重制cellCode的计数
                    [cellCode.timer invalidate];
                    cellCode.count=30;
                }
            }
        }];
    }else{
    NSDictionary *dic;
    
    if (self.type==0) {
        dic = @{@"mobile":cellAcc.textField.text,
                @"codetype":@(2),
                @"voice":@(type)
                };
    }
    else
    {
        dic = @{@"mobile":cellAcc.textField.text,
                @"codetype":@(2),
                @"userid":[UserInfoManager getUserUID],
                @"voice":@(type)
                };
    }
    
    [AFWebAPI getVerCodeWithArg:dic callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"获取成功，请查收。"];
            if (type==1) {
                [cellCode.codeBtn timeFailBeginFrom:30];
            }
            else
            {
                VoiceCodePopV *popV = [[VoiceCodePopV alloc]init];
                [popV show];
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR;
        }
    }];
    }
}

@end
