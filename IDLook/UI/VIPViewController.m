//
//  VIPViewController.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/28.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "VIPViewController.h"

@interface VIPViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (weak, nonatomic) IBOutlet UIView *content1;
@property (weak, nonatomic) IBOutlet UILabel *desc1;
@property (weak, nonatomic) IBOutlet UIView *content2;
@property (weak, nonatomic) IBOutlet UILabel *desc2;
@property (weak, nonatomic) IBOutlet UIView *content3;
@property (weak, nonatomic) IBOutlet UILabel *desc3;
@property (weak, nonatomic) IBOutlet UIView *content4;
@property (weak, nonatomic) IBOutlet UILabel *desc4;
@property (weak, nonatomic) IBOutlet UIView *content5;
@property (weak, nonatomic) IBOutlet UILabel *desc5;
@property (weak, nonatomic) IBOutlet UIView *content6;
@property (weak, nonatomic) IBOutlet UILabel *desc6;
@property (weak, nonatomic) IBOutlet UIView *line6;

@property (weak, nonatomic) IBOutlet UIView *content7;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *img;

- (IBAction)applyAction:(id)sender;
@property(nonatomic,assign)NSInteger type;//1可申请 2申请中 3已经申请
@end

@implementation VIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"我的VIP"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
 
   

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSInteger status = [UserInfoManager getUserStatus];
    //  105正在申请中  200普通用户，201VIP战略合作公司，202VIP制片",
    if (status==105) {
        _type = 2;
    }else if (status>200){
        _type=3;
    }else if (status==100){
        _type = 1;
    }
    
    self.topView.layer.cornerRadius = 8;
    self.topView.layer.masksToBounds = YES;
    [self.desc1 sizeToFit];
    self.desc1.frame = CGRectMake(63, 26, _topView.width-72, _desc1.height);
    self.content1.height = _desc1.height+39;
    
    [self.desc2 sizeToFit];
    self.desc2.frame = CGRectMake(63, 26, _topView.width-72, _desc2.height);
    self.content2.height = _desc1.height+39;
    self.content2.y = _content1.bottom+15;
    
    [self.desc3 sizeToFit];
    self.desc3.frame = CGRectMake(63, 26, _topView.width-72, _desc3.height);
    self.content3.height = _desc3.height+39;
    self.content3.y = _content2.bottom+15;
    
    [self.desc4 sizeToFit];
    self.desc4.frame = CGRectMake(63, 26, _topView.width-72, _desc4.height);
    self.content4.height = _desc4.height+39;
    self.content4.y = _content3.bottom+15;
    
    [self.desc5 sizeToFit];
    self.desc5.frame = CGRectMake(63, 26, _topView.width-72, _desc5.height);
    self.content5.height = _desc5.height+39;
    self.content5.y = _content4.bottom+15;
    
    [self.desc6 sizeToFit];
    self.desc6.frame = CGRectMake(63, 26, _topView.width-72, _desc6.height);
    if (_type==3) {
        self.content6.height = _desc6.height+59;
    }else{
        self.content6.height = _desc6.height+39;
    }
    self.content6.y = _content5.bottom+15;
    
    self.content7.y = self.content6.bottom;
    
     self.contenView.height = _content7.bottom;
//    if (UI_SCREEN_HEIGHT<736) {
//        self.contenView.height = _content7.bottom+64;
//    }
//    else if(UI_SCREEN_HEIGHT==736){
//        self.contenView.height = _content7.bottom;
//    }else{
//        self.contenView.height = _content7.bottom-64;
//    }
    
    
    //  type;//1可申请 2申请中 3已经申请
    if (_type==1) {
        [self.button setBackgroundImage:[UIImage imageNamed:@"vipbtn1"] forState:0];
        [self.button setTitle:@"立即申请" forState:0];
        self.button.userInteractionEnabled = YES;
    }else if (_type==2){
        [self.button setBackgroundImage:[UIImage imageNamed:@"vipbtn2"] forState:0];
        [self.button setTitle:@"申请中" forState:0];
        [self.button setTitleColor:[UIColor colorWithHexString:@"#909090"] forState:0];
        self.button.userInteractionEnabled = NO;
    }else if (_type==3){
        self.content7.hidden = YES;
        self.contenView.height = _content6.bottom;
        self.line6.hidden = YES;
//        if (UI_SCREEN_HEIGHT<736) {
//            self.contenView.height = _content6.bottom+64;
//        }else if(UI_SCREEN_HEIGHT==736){
//            self.contenView.height = _content6.bottom;
//        }else{
//            self.contenView.height = _content6.bottom-64;
//        }
    }
    self.scroll.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _contenView.height+315);//
    [self.scroll bringSubviewToFront:_topView];
    [self.scroll bringSubviewToFront:_contenView];
}

- (IBAction)applyAction:(id)sender {
   
       NSInteger authState = [UserInfoManager getUserAuthState_wm];
        if (authState!=1) {
            [SVProgressHUD showImage:nil status:@"您还未实名认证，请认证后再申请。"];
            return;
        }
    NSDictionary *dic = @{
                          @"userId":@([[UserInfoManager getUserUID]integerValue]),
                          @"vipType":@(202)              //201=VIP战略合作公司; 202=VIP制片
                          };
    [SVProgressHUD showWithStatus:@"" maskType:SVProgressHUDMaskTypeClear];
    [AFWebAPI_JAVA applyVIPWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"已经提交申请"];
            [self.button setBackgroundImage:[UIImage imageNamed:@"vipbtn2"] forState:0];
            [self.button setTitle:@"申请中" forState:0];
            [UserInfoManager setUserStatus:105];
     [self.button setTitleColor:[UIColor colorWithHexString:@"#909090"] forState:0];
            self.button.userInteractionEnabled = NO;
            self.reloadUI();
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}
- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
