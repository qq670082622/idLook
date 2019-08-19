//
//  RoleServiceApplyFinishVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "RoleServiceApplyFinishVC.h"
#import "RoleServiceDetialVC.h"

@interface RoleServiceApplyFinishVC ()

@end

@implementation RoleServiceApplyFinishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选角服务"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self initUI];
}

-(void)onGoback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)initUI
{
    UIImageView *bg=[[UIImageView alloc]init];
    [self.view addSubview:bg];
    bg.contentMode=UIViewContentModeScaleAspectFill;
    bg.image=[UIImage imageNamed:@"auditService_finish"];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(44);
    }];
    
    UILabel *titleLab=[[UILabel alloc]init];
    titleLab.font=[UIFont systemFontOfSize:20];
    titleLab.textColor=Public_Text_Color;
    titleLab.text=@"提交成功";
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(bg.mas_bottom).offset(28);
    }];
    
    MLLabel *descLab = [[MLLabel alloc] init];
    descLab.font = [UIFont systemFontOfSize:15];
    descLab.numberOfLines=0;
    descLab.lineSpacing=4.0;
    descLab.textAlignment=NSTextAlignmentCenter;
    descLab.textColor =Public_DetailTextLabelColor;
    [self.view addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(40);
        make.top.mas_equalTo(bg.mas_bottom).offset(70);
    }];
    descLab.text=@"您的订单已经提交成功，脸探平台客服会在1个工作日内通过电话联系您，请留意。";
    
    CGFloat width = (UI_SCREEN_WIDTH-85)/2;
    //返回首页
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];
    backBtn.layer.cornerRadius=5;
    backBtn.layer.masksToBounds=YES;
    backBtn.layer.borderColor=Public_Red_Color.CGColor;
    backBtn.layer.borderWidth=1.0;
    [backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [backBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
    backBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(-12);
        make.top.mas_equalTo(descLab.mas_bottom).offset(85);
        make.size.mas_equalTo(CGSizeMake(145, 48));
    }];
    [backBtn addTarget:self action:@selector(backHomeAction) forControlEvents:UIControlEventTouchUpInside];
    
    //订单详情
    UIButton *detialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:detialBtn];
    detialBtn.layer.cornerRadius=5;
    detialBtn.layer.masksToBounds=YES;
    detialBtn.backgroundColor=Public_Red_Color;
    [detialBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [detialBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    detialBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [detialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX).offset(12);
        make.top.mas_equalTo(descLab.mas_bottom).offset(85);
        make.size.mas_equalTo(CGSizeMake(145, 48));
    }];
    [detialBtn addTarget:self action:@selector(orderDetialAction) forControlEvents:UIControlEventTouchUpInside];
    
    //客服电话
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:phoneBtn];
    [phoneBtn setTitle:@"客服电话：400-833-6969" forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor colorWithHexString:@"#47AEFF"] forState:UIControlStateNormal];
    phoneBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-SafeAreaTabBarHeight_IphoneX-15);
    }];
    [phoneBtn addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
    
}


//返回首页
-(void)backHomeAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//详情
-(void)orderDetialAction
{
    RoleServiceDetialVC *detialVC = [[RoleServiceDetialVC alloc]init];
    detialVC.model=self.model;
    [self.navigationController pushViewController:detialVC animated:YES];
    detialVC.refreshDataBlock = ^{
        
    };
}

//客服电话
-(void)phoneAction
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
}

@end
