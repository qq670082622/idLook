//
//  MyAuthStateVC.m
//  IDLook
//
//  Created by HYH on 2018/6/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyAuthStateVC.h"
#import "AuthBuyerVC.h"
#import "AuthResourcerVC.h"
#import "AuthBuyerSelectPopV.h"

@interface MyAuthStateVC ()

@end

@implementation MyAuthStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem setTitleView:[CustomNavVC setWhiteNavgationItemTitle:@"认证审核"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self initUI];

}

-(void)onGoback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    [self scrolloffY:self.tableV.contentOffset.y];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

-(void)initUI
{
    UIImageView *bgV = [[UIImageView alloc]init];
    [self.view addSubview:bgV];
    bgV.contentMode=UIViewContentModeScaleAspectFill;

    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    UIImageView *stateBG = [[UIImageView alloc]init];
    [self.view addSubview:stateBG];
    stateBG.contentMode=UIViewContentModeScaleAspectFill;
    [stateBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgV).offset(93);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *statelab = [[UILabel alloc]init];
    statelab.textColor=[UIColor whiteColor];
    statelab.font=[UIFont systemFontOfSize:16.0];
    [self.view addSubview:statelab];
    [statelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(stateBG).offset(64);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.textColor=Public_Text_Color;
    titleLab.font=[UIFont systemFontOfSize:15.0];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgV.mas_bottom).offset(45);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *desc = [[UILabel alloc]init];
    desc.numberOfLines=0;
    desc.textAlignment=NSTextAlignmentCenter;
    desc.textColor=[UIColor colorWithHexString:@"#999999"];
    desc.font=[UIFont systemFontOfSize:14.0];
    [self.view addSubview:desc];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(21);
    }];
    
    UIButton *reSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    reSubmit.layer.masksToBounds=YES;
    reSubmit.layer.cornerRadius=5.0;
    reSubmit.backgroundColor=Public_Red_Color;
    [self.view addSubview:reSubmit];
    [reSubmit setTitle:@"重新认证" forState:UIControlStateNormal];
    [reSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reSubmit.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [reSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(desc.mas_bottom).offset(35);
        make.size.mas_equalTo(CGSizeMake(130, 45));
    }];
    reSubmit.hidden=YES;
    [reSubmit addTarget:self action:@selector(reAuthAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (self.authState==3) {
        bgV.image=[UIImage imageNamed:@"auth_top_bg1"];
        stateBG.image=[UIImage imageNamed:@"auth_state_1"];
        statelab.text=@"审核中";
        titleLab.text=@"资料提交成功！";
        desc.text=@"实名认证审核预计1-2小时内完成，请您耐心等待审核结果~";
        reSubmit.hidden=YES;
    }
    else if (self.authState==2)
    {
        bgV.image=[UIImage imageNamed:@"auth_top_bg2"];
        stateBG.image=[UIImage imageNamed:@"auth_state_2"];
        statelab.text=@"审核失败";
        titleLab.text=@"抱歉，您的认证未通过审核！";
//        desc.text=@"请去修改您未通过审核的信息，重新提交认证~";
        reSubmit.hidden=NO;
    }
}

//重新认证
-(void)reAuthAction
{

    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        AuthResourcerVC *authVC=[[AuthResourcerVC alloc]init];
        [self.navigationController pushViewController:authVC animated:YES];
    }
    else
    {
        AuthBuyerSelectPopV *popV = [[AuthBuyerSelectPopV alloc]init];
        [popV show];
        WeakSelf(self);
        popV.authTypeSelectBlock = ^(NSInteger type) {
            AuthBuyerVC *authVC=[[AuthBuyerVC alloc]init];
            authVC.buyType=type;
            authVC.hidesBottomBarWhenPushed=YES;
            [weakself.navigationController pushViewController:authVC animated:YES];
        };
    }
}

@end
