//
//  LoginAndRegistVC.m
//  IDLook
//
//  Created by HYH on 2018/4/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "LoginAndRegistVC.h"

#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "OpenUDID.h"

#import "LoginCustomCell.h"
#import "ThridLRView.h"
#import "RegisterVC.h"
#import "ResetPasswordVC.h"
#import "CompleteInfoVC.h"
#import "LoginCellModel.h"
#import "JPUSHService.h"
@interface LoginAndRegistVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)ThridLRView *thridLRV;
@end

@implementation LoginAndRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    self.dataSource=[LoginCellModel getLoginDataSource];
    
    [self initUI];
}

-(void)initUI
{
    UILabel *title=[[UILabel alloc]init];
    title.text=@"Hi，欢迎登录脸探肖像";
    title.font=[UIFont boldSystemFontOfSize:17.0];
    title.textColor=[UIColor colorWithHexString:@"FF4A57"];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(74);
    }];
    
    UIButton *colsebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:colsebtn];
    [colsebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [colsebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(48, 48));

    }];
    [colsebtn addTarget:self action:@selector(colseLogin) forControlEvents:UIControlEventTouchUpInside];

    
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
    
    [self tableV];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"FF4A57"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.borderColor=[UIColor colorWithHexString:@"FF4A57"].CGColor;
    registerBtn.layer.borderWidth=1.0;
    registerBtn.layer.cornerRadius=5.0;
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(107, 45));
        make.bottom.mas_equalTo(self.view).offset(-150);
    }];
    
//    [self thridLRV];
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
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateDisabled];
    [loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.enabled = NO;
    [view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.right.equalTo(view).offset(-15);
        make.height.equalTo(@45);
        make.top.equalTo(view).offset(25);
    }];
    self.loginBtn=loginBtn;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"忘记密码?";
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor colorWithHexString:@"FF4A57"];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(loginBtn);
        make.top.equalTo(loginBtn.mas_bottom).offset(15);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findPwd)];
    [label addGestureRecognizer:tap];
    return view;
}

-(ThridLRView*)thridLRV
{
    if (!_thridLRV) {
        _thridLRV=[[ThridLRView alloc]init];
        [self.view addSubview:_thridLRV];
        [_thridLRV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).offset(-10);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(@100);
        }];
        [_thridLRV layoutIfNeeded];
        __weak __typeof(self)weakSelf=self;
        _thridLRV.btnClickedType = ^(UserLoginType type) {
            [weakSelf processThirdLogin:type];
        };
    }
    return _thridLRV;
}

//退出登录界面
-(void)colseLogin
{
    [self.view endEditing:YES];
    if (self.isHideClose) {
        AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [dele showRootVC];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{
        }];

    }
}

//忘记密码
-(void)findPwd
{
    ResetPasswordVC *resetpasswordVC = [[ResetPasswordVC alloc]init];
    resetpasswordVC.type=0;
    [self presentViewController:resetpasswordVC animated:NO completion:^{
        
    }];

}

//登录
-(void)doLogin
{
    [self.view endEditing:YES];

    NSString *acc = nil;
    NSString *pwd = nil;
    
    LoginCustomCell *cellAcc = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    LoginCustomCell *cellPwd = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    acc = cellAcc.textField.text;
    pwd = cellPwd.textField.text;
    
    if(acc.length>11)
    {
        [SVProgressHUD showErrorWithStatus:@"输入的手机号不能超过11位"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeClear];
    NSDictionary *param = @{@"mobile":acc,
                            @"password":MD5Str(pwd)
                            };
    [AFWebAPI_JAVA getTokenFromJavaService:param callBack:^(BOOL success, id  _Nonnull object) {//无论是不是java都要登陆，这个是获取token的唯一方法，有了token才能使用询问是否用java后端
        if (success) {
            NSLog(@"obj is %@",object);
            NSDictionary *tokenInfo = (NSDictionary *)object[@"body"][@"tokenInfo"];
            NSString *token = tokenInfo[@"accessToken"];
            NSString *refreshToken = tokenInfo[@"refreshToken"];
            [UserInfoManager setAccessToken:token];
            [UserInfoManager setRefreshToken:refreshToken];
            
            UserInfoM *uinfo = [[UserInfoM alloc] initJavaDataWithDic:[object objectForKey:JSON_body]];
            [UserInfoManager setUserStatus:uinfo.status];
            [UserInfoManager setUserVip:uinfo.vipLevel];
            [UserInfoManager setUserDiscount:uinfo.discount];
        }
    }];
    
    NSDictionary *dicArg = @{@"mobile":acc,
                             @"password":MD5Str(pwd),
                             @"uuid":[OpenUDID value],
                             @"ver":Current_BundleVersion,
                             @"channelid":LINK_ID,
                             @"logintype":@(0),
                             @"plat":@0};
    
    [AFWebAPI doLoginByMobileWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [object objectForKey:JSON_data];
            
            UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
            NSString *userId = [UserInfoManager getUserUID];
            if (userId.length>1) {
                [JPUSHService setAlias:userId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    
                } seq:1];
            }
            [UserInfoManager setUserLoginfo:uinfo];
            [UserInfoManager setUserMobile:acc];
            [UserInfoManager setUserPwd:pwd];
            [UserInfoManager setUserLoginType:UserLoginTypeMobile];
            
            if ([UserInfoManager getUserType]==UserTypeResourcer) {
                 if ([[UserInfoManager getUserRegion]length]==0 || [UserInfoManager getUserOccupation]==0 || [UserInfoManager getUserSex]<=0 ||[[UserInfoManager getUserNationality]length]==0 || [[UserInfoManager getUserRealName]length]==0 || [[UserInfoManager getUserBirth]length]==0) {
                    CompleteInfoVC *step2 = [[CompleteInfoVC alloc]init];
                    CustomNavVC *nav = [[CustomNavVC alloc]initWithRootViewController:step2];
                    [self presentViewController:nav animated:NO completion:^{}];
                }
                else
                {
                    AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [dele showRootVC];
                }
            }
            else
            {
                AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [dele showRootVC];
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
   
}

//注册
-(void)doRegister
{
    [self.view endEditing:YES];

    RegisterVC *registerVC = [[RegisterVC alloc]init];
    [self presentViewController:registerVC animated:NO completion:^{
        
    }];
    
}

//第三方登录
- (void)processThirdLogin:(UserLoginType)type
{
    if(type==UserLoginTypeWX)
    {
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
            
            UMSocialUserInfoResponse *resp = result;
            
            if (error) {
                
            }
            else
            {
                [self checkOpenIDValidity:resp type:UserLoginTypeWX];
            }
        }];
    }
    else if(type==UserLoginTypeSina)
    {
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
            
            UMSocialUserInfoResponse *resp = result;
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"授权失败"];
            }
            else
            {
                [self checkOpenIDValidity:resp type:UserLoginTypeSina];
            }
        }];
    }
}

- (void)checkOpenIDValidity:(UMSocialUserInfoResponse *)snsAccount type:(UserLoginType)type
{
    
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
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"LoginCustomCell";
    LoginCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[LoginCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        WeakSelf(self);
        cell.textFDidChanged = ^(CustomTextField *textF) {
            [weakself cellTextFDidChange:textF];
        };
    }

    [cell reloadUIWithModel:self.dataSource[indexPath.row]];
    return cell;
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
- (void)cellTextFDidChange:(CustomTextField *)textF
{
    if(textF.tag==LRCellTypePhone)
    {
        LoginCustomCell *cellPwd = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        if(textF.text.length>0&&
           cellPwd.textField.text.length>0)
        {
            self.loginBtn.enabled = YES;
            [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn" ] forState:UIControlStateNormal];
        }
        else
        {
            self.loginBtn.enabled = NO;
            [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn_n" ] forState:UIControlStateNormal];

        }
    }
    else if(textF.tag==LRCellTypePassword)
    {
        LoginCustomCell *cellAcc = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if(textF.text.length>0&&
           cellAcc.textField.text.length>0)
        {
            self.loginBtn.enabled = YES;
            [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn" ] forState:UIControlStateNormal];
        }
        else
        {
            self.loginBtn.enabled = NO;
            [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn_n" ] forState:UIControlStateNormal];
        }
    }
}

@end
