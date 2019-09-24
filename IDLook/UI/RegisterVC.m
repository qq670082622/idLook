//
//  RegisterVC.m
//  IDLook
//
//  Created by HYH on 2018/4/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RegisterVC.h"
#import "LoginCustomCell.h"
#import "LoginCodeCell.h"
#import "ChoseIdentityVC.h"
#import "OpenUDID.h"
#import "PublicWebVC.h"
#import "CompleteInfoVC.h"
#import "RegistCellB.h"
#import "LoginCellModel.h"
#import "VoiceCodePopV.h"

@interface RegisterVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UIView *bgV;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    self.dataSource=[LoginCellModel getReginDataSource];
    
    [self initUI];
    
    [self.view endEditing:YES];
}

-(void)initUI
{
    UILabel *title=[[UILabel alloc]init];
    title.text=@"注册脸探肖像";
    title.font=[UIFont boldSystemFontOfSize:17.0];
    title.textColor=[UIColor colorWithHexString:@"FF4A57"];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(74);
    }];
    
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
        _tableV.bounces=NO;
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
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn_n" ] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn" ] forState:UIControlStateSelected];
    [loginBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateDisabled];
    [loginBtn addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.enabled = NO;
    [view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.right.equalTo(view).offset(-15);
        make.height.equalTo(@45);
        make.top.equalTo(view).offset(25);
    }];
    self.loginBtn=loginBtn;
    
    UILabel *staticLab = [[UILabel alloc] init];
    staticLab.textColor = [UIColor lightGrayColor];
    staticLab.font = [UIFont systemFontOfSize:12.0];
    staticLab.text = @"点击立即注册，即表示您同意并遵守";
    [view addSubview:staticLab];
    [staticLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view).offset(-60);
        make.top.equalTo(loginBtn.mas_bottom).offset(15);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"《脸探肖像用户协议》";
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:12.0];
    label.textColor = [UIColor colorWithHexString:@"FF4A57"];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(staticLab.mas_right);
        make.top.equalTo(loginBtn.mas_bottom).offset(15);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showProtocol)];
    [label addGestureRecognizer:tap];
    return view;
}

//返回
-(void)back
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}


//立即注册
-(void)doRegister
{
    LoginCellStrutM *model1 = self.dataSource[0];
    LoginCellStrutM *model2 = self.dataSource[1];
    LoginCellStrutM *model3 = self.dataSource[2];
    LoginCellStrutM *model4 = self.dataSource[3];
    LoginCellStrutM *model5 = self.dataSource[4];

    
    if(!IsCorrectPhoneNumber(model1.content))
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
        return;
    }
    if (model2.content.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (model3.content.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (![model3.content isEqualToString:model4.content]) {
        [SVProgressHUD showErrorWithStatus:@"输入的密码不一致"];
        return;
    }
    
    NSDictionary *dicArg = @{@"mobile":model1.content,
                             @"password":MD5Str(model3.content),
                             @"uuid":[OpenUDID value],
                             @"channelid":LINK_ID,
                             @"ver":Current_BundleVersion,
                             @"plat":@"0",
                             @"registertype":@(UserLoginTypeMobile),
                             @"usertype":@(model5.userType),
                             @"registerip":GetLocalAddress(),
                             @"key":model2.content,
                             @"codetype":@(1)};
    
    [SVProgressHUD showWithStatus:@"正在注册..." maskType:SVProgressHUDMaskTypeClear];
    
    [AFWebAPI doRegistByMobile:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            NSString *ut = [WriteFileManager userDefaultForKey:@"userType"];
            NSDictionary * arg2 = @{@"userDefinedType":@([ut integerValue])};
            [AFWebAPI_JAVA setUserTypeWithArg:arg2 callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    
                    
                }
            }];
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            NSDictionary *dic = [object objectForKey:JSON_data];
            UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
            [UserInfoManager setUserLoginfo:uinfo];
            [UserInfoManager setUserMobile:model1.content];
            [UserInfoManager setUserPwd:model3.content];
            [UserInfoManager setUserLoginType:UserLoginTypeMobile];
            
            if ([UserInfoManager getUserType]==UserTypeResourcer) {
                CompleteInfoVC *step2 = [[CompleteInfoVC alloc]init];
                CustomNavVC *nav = [[CustomNavVC alloc]initWithRootViewController:step2];
                [self presentViewController:nav animated:NO completion:^{}];
            }
            else
            {
                AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [dele showRootVC];
            }
            [self.view endEditing:YES];
        }
        else
        {
            AF_SHOW_RESULT_ERROR;
        }
    }];

}

//用户协议
- (void)showProtocol
{
    PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"脸探肖像用户协议" url:@"http://www.idlook.com/public/agreement.html"];
    CustomNavVC *nav=[[CustomNavVC alloc]initWithRootViewController:webVC];
    [self presentViewController:nav animated:NO completion:^{}];
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
    LoginCellStrutM *model= self.dataSource[indexPath.row];
    NSString *userType = [WriteFileManager userDefaultForKey:@"userType"];
    NSInteger usert = [userType integerValue];
    //    userType 户自定义类型 0=未选择 1=电商 2=制片 3=演员
    if (usert==1 || usert==2) {
        model.userType = UserTypePurchaser;
    }else if (usert==3){
        model.userType = UserTypeResourcer;
    }
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
            [weakself cellTextFDidChange:textF];
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
    else if (cellType==LRCellTypeIdentity)
    {
        static NSString *identifer = @"RegistCellB";
        RegistCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[RegistCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        [cell reloadUIWithModel:model];
        WeakSelf(self);
        cell.typeChoose1 = ^(UserType type) {
            model.userType=type;
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
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

        }
        [cell reloadUIWithModel:model];
        WeakSelf(self);
        cell.textFDidChanged = ^(CustomTextField *textF) {
            model.content = textF.text;
            [weakself cellTextFDidChange:textF];
        };
        return cell;
    }
    return nil;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    LoginCustomCell *cellAcc = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    LoginCodeCell *cellCode = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if(!IsCorrectPhoneNumber(cellAcc.textField.text))
    {
        [SVProgressHUD showErrorWithStatus:@"请正确填写手机号码"];
        if (type==2) {//获取语音验证码时，手机号不对需要重制cellCode的计数
            [cellCode.timer invalidate];
            cellCode.count=30;
        }
        return;
    }
    
    
    
      if ([UserInfoManager getIsJavaService]) {//java后台
          NSDictionary *dic = @{@"mobile":cellAcc.textField.text,
                                @"verifyType":@(1),
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
    NSDictionary *dic = @{@"mobile":cellAcc.textField.text,
                          @"codetype":@(1),
                          @"voice":@(type)
                          };
    
    [AFWebAPI getVerCodeWithArg:dic callBack:^(BOOL success, id object) {
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
        }
        else
        {
            AF_SHOW_RESULT_ERROR;
        }
    }];
      }
}

#pragma mark -
#pragma mark - others
- (void)cellTextFDidChange:(CustomTextField *)textF
{
    LoginCellStrutM *model1 = self.dataSource[0];
    LoginCellStrutM *model2 = self.dataSource[1];
    LoginCellStrutM *model3 = self.dataSource[2];
    LoginCellStrutM *model4 = self.dataSource[3];
    
    if (model1.content.length>0 && model2.content.length>0 && model3.content.length>0 && model4.content.length>0) {
        self.loginBtn.enabled = YES;
        [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn" ] forState:UIControlStateNormal];
    }
    else
    {
        self.loginBtn.enabled = NO;
        [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn_n" ] forState:UIControlStateNormal];
    }
    
}



@end
