//
//  ChoseIdentityVC.m
//  IDLook
//
//  Created by HYH on 2018/5/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ChoseIdentityVC.h"
#import "ChoseIdentityTypeV.h"

@interface ChoseIdentityVC ()<ChoseIdentityTypeVDelegate>
@property(nonatomic,strong)ChoseIdentityTypeV *userTypeView;
@property(nonatomic,strong)UIButton *lastStepBtn;
@property(nonatomic,assign)NSInteger choseStep;   //选择到第几步

@end

@implementation ChoseIdentityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.choseStep = 0;
    
 
    
    [self initUI];
    

    [self.userTypeView reloadUI];
    
}

//退出
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//上一步
-(void)lastStep
{
    [self.userTypeView lastStepAction];
}

-(void)initUI
{
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];

    [backBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *laststepBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:laststepBtn];
    laststepBtn.hidden=YES;
    [laststepBtn setImage:[UIImage imageNamed:@"btn_public_back_n"] forState:UIControlStateNormal];
    [laststepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(48, 48));

    }];
    [laststepBtn addTarget:self action:@selector(lastStep) forControlEvents:UIControlEventTouchUpInside];
    self.lastStepBtn=laststepBtn;
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"选择身份";
    title.font = [UIFont systemFontOfSize:24.0];
    title.textColor = Public_Text_Color;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(75);
    }];
    
    
    UILabel *desc = [[UILabel alloc] init];
    desc.text = @"选择后不可更改，请准确选择您的身份";
    desc.font = [UIFont systemFontOfSize:13.0];
    desc.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.view addSubview:desc];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(title.mas_bottom).offset(30);
    }];
}

-(ChoseIdentityTypeV*)userTypeView
{
    if (!_userTypeView) {
        _userTypeView =[[ChoseIdentityTypeV alloc]init];
        [_userTypeView layoutIfNeeded];
        _userTypeView.delegate=self;
        [self.view addSubview:_userTypeView];
        [_userTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).offset(156);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    return _userTypeView;
}

#pragma mark---ChoseIdentityTypeVDelegate
-(void)choseIdentityWithType:(NSInteger)type withSubType:(NSInteger)subType withContent:(NSString *)content
{
    NSLog(@"--%ld --%ld  --%@",type,subType,content);
//
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"选择后不可更改，请准确选择您的身份" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self.userTypeView cancle];
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        self.choseeIdentityBlock(type+1, subType, content);
                                                        [self dismissViewControllerAnimated:YES completion:nil];
                                                        
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}

-(void)isShowLastStep:(NSInteger)step
{
    if (step<1) {
        self.lastStepBtn.hidden=YES;
    }
    else
    {
        self.lastStepBtn.hidden=NO;
    }
}

@end
