//
//  ChangeMobileStep1.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ChangeMobileStep1.h"
#import "LoginCustomCell.h"
#import "ChangeMobileStep2.h"
#import "LoginCellModel.h"
#import "LoginCodeCell.h"
#import "VoiceCodePopV.h"

@interface ChangeMobileStep1 ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)UIView *bgV;

@end

@implementation ChangeMobileStep1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"更改手机号码"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.dataSource=[LoginCellModel getChangeMobileStep1DataSource];
    [self initUI];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI
{
    UILabel *title=[[UILabel alloc]init];
    title.text=@"请先进行身份验证";
    title.font=[UIFont boldSystemFontOfSize:17.0];
    title.textColor=[UIColor colorWithHexString:@"FF4A57"];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
    
    
    UIView *bg=[[UIView alloc]init];
    bg.layer.cornerRadius=4.0;
    bg.layer.shadowOffset = CGSizeMake(4,4);
    bg.layer.shadowOpacity = 0.8;
    bg.layer.shadowRadius= 20.0;
    bg.layer.shadowColor = [[UIColor colorWithHexString:@"#525252"] colorWithAlphaComponent:0.1].CGColor;
    bg.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.height.mas_equalTo(70*self.dataSource.count);
    }];
    self.bgV=bg;
    [self tableV];

}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,64,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-64) style:UITableViewStylePlain];
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
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(doNext) forControlEvents:UIControlEventTouchUpInside];
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


//下一步
-(void)doNext
{
    LoginCustomCell *cellAcc = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    LoginCodeCell *cellCode = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    if (cellAcc.textField.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    NSLog(@"当前账户手机号%@，输入的手机号%@",[UserInfoManager getUserMobile],cellAcc.textField.text);
    if (![cellAcc.textField.text isEqualToString:[UserInfoManager getUserMobile]]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不是该账户绑定的手机号"];
        return;
    }
    if (cellCode.textField.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }

    if ([UserInfoManager getIsJavaService]) {//java后台
        NSDictionary *dic = @{
                              @"oldMobile":cellAcc.textField.text,
                              @"oldCode":cellCode.textField.text};
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [AFWebAPI_JAVA setCheckoldPhoneWithArg:dic callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD dismiss];
                ChangeMobileStep2 *step2=[[ChangeMobileStep2 alloc]init];
                [self.navigationController pushViewController:step2 animated:YES];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:object];
            }
        }];
    }else{
    NSDictionary *dic = @{
                          @"oldmobile":cellAcc.textField.text,
                          @"oldcode":cellCode.textField.text};
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [AFWebAPI setCheckoldPhoneWithArg:dic callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            ChangeMobileStep2 *step2=[[ChangeMobileStep2 alloc]init];
            [self.navigationController pushViewController:step2 animated:YES];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
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
    NSLog(@"当前账户手机号%@，输入的手机号%@",[UserInfoManager getUserMobile],cellAcc.textField.text);
    if (![cellAcc.textField.text isEqualToString:[UserInfoManager getUserMobile]]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不是该账户绑定的手机号"];
        if (type==2) {//获取语音验证码时，手机号不对需要重制cellCode的计数
            [cellCode.timer invalidate];
            cellCode.count=30;
        }
        return;
    }
    
    if ([UserInfoManager getIsJavaService]) {//java后台
        NSDictionary *dic = @{@"mobile":cellAcc.textField.text,
                              @"verifyType":@(3),
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
                          @"userid":[UserInfoManager getUserUID],
                          @"checktel":@"1",
                          @"codetype":@(3),
                          @"voice":@(type)
                          };
    
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
