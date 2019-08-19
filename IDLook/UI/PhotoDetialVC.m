//
//  PhotoDetialVC.m
//  IDLook
//
//  Created by HYH on 2018/6/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PhotoDetialVC.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"
#import "LookBigImageVC.h"

@interface PhotoDetialVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollV;

@end

@implementation PhotoDetialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftWhiteButtonWithTarget:self action:@selector(onGoback)]]];

    [self scrollV];
    [self initUI];
    

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个image，设置透明度
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:0.0]] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //修改状态栏颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;

}

-(UIScrollView*)scrollV
{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -SafeAreaTopHeight, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT+SafeAreaTopHeight-50)];
        _scrollV.delegate = self;
        _scrollV.pagingEnabled=NO;
        _scrollV.scrollEnabled = YES;
        _scrollV.backgroundColor = Public_Background_Color;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollV];
        _scrollV.contentSize=CGSizeMake(UI_SCREEN_WIDTH, 450+240+20+60+10);
        
        if ([UserInfoManager getUserType]==UserTypeResourcer) {
            _scrollV.frame=CGRectMake(0, -SafeAreaTopHeight, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT+SafeAreaTopHeight);
        }
        else
        {
            _scrollV.frame=CGRectMake(0, -SafeAreaTopHeight, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT+SafeAreaTopHeight-50);
        }
    }
    return _scrollV;
}

-(void)initUI
{
    UIImageView *headBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 430)];
    headBG.contentMode=UIViewContentModeScaleAspectFill;
    headBG.clipsToBounds=YES;
    headBG.userInteractionEnabled=YES;
    [self.scrollV addSubview:headBG];
    [headBG sd_setImageWithUrlStr:self.model.url placeholderImage:[UIImage imageNamed:@"default_photo"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookBigPhoto)];
    [headBG addGestureRecognizer:tap];
    
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 430-143, UI_SCREEN_WIDTH, 143)];
    bgV.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.6];
    [self.scrollV addSubview:bgV];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15,15,UI_SCREEN_WIDTH-30,25)];
    title.text = self.model.title;
    title.font = [UIFont boldSystemFontOfSize:16.0];
    title.textColor = [UIColor whiteColor];
    [bgV addSubview:title];
    
    NSArray *array = @[[NSString stringWithFormat:@"作品编码：%@",self.model.creativeid],[NSString stringWithFormat:@"格        式：%@",self.model.format],[NSString stringWithFormat:@"像        素：%.fX%.f",self.model.widthpx,self.model.heightpx],[NSString stringWithFormat:@"大        小：%.2fMB",self.model.size]];
    
    for (int i =0; i<array.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15,45+22*i,UI_SCREEN_WIDTH-30,22)];
        lab.text = array[i];
        lab.font = [UIFont systemFontOfSize:13.0];
        lab.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
        [bgV addSubview:lab];
    }
    
    //微出镜照片授权书
    UIImageView *cerifBG = [[UIImageView alloc]initWithFrame:CGRectMake(15,450, UI_SCREEN_WIDTH-30,240)];
//    cerifBG.contentMode=UIViewContentModeScaleAspectFill;
    [self.scrollV addSubview:cerifBG];
    [cerifBG sd_setImageWithUrlStr:self.info.authorization2 placeholderImage:[UIImage imageNamed:@"default_photo"]];
    
    MLLabel *desc = [[MLLabel alloc] initWithFrame:CGRectMake(30,450+240+10,UI_SCREEN_WIDTH-60,60)];
    desc.text = @"*脸探肖像独家销售权，可转签肖像使用权（同品类独家）可用于品牌商业用途，请提交下单获取报价信息 。";
    desc.font = [UIFont systemFontOfSize:11.0];
    desc.numberOfLines=0;
    desc.lineSpacing=5.0;
    desc.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    desc.textAlignment=NSTextAlignmentCenter;
    [self.scrollV addSubview:desc];
    
    
    UIButton *button=[[UIButton alloc]init];
    [self.view addSubview:button];
    button.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [button setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [button setTitle:@"立即下单" forState:UIControlStateNormal];
    button.frame=CGRectMake(0,UI_SCREEN_HEIGHT-50, UI_SCREEN_WIDTH, 50);
    button.backgroundColor=Public_Red_Color;
    [button addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        button.hidden=YES;

    }
    else
    {
        button.hidden=NO;

    }
    
}

-(void)placeOrderAction
{
    //未登陆
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist)
    {
        [self goLogin];
        return;
    }

    //未认证成功，跳到认证界面
    if ([UserInfoManager getUserAuthState]!=1) {
        [self goAuth];
        return;
    }

}

#pragma mark---未登录，先去登录
-(void)goLogin
{
    LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
    [self presentViewController:login animated:YES completion:nil];
}



#pragma mark---未认证，先认证
-(void)goAuth
{
    if ([UserInfoManager getUserAuthState]==3){  //审核中
        [SVProgressHUD showImage:nil status:@"你的认证信息正在审核中，通过后才能下单！"];
        return;
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"去认证" message:@"认证通过之后您才能下单！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"去认证"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        
                                                        if ([UserInfoManager getUserAuthState]==0) {
                                                            AuthBuyerVC *authVC=[[AuthBuyerVC alloc]init];
                                                            authVC.hidesBottomBarWhenPushed=YES;
                                                            [self.navigationController pushViewController:authVC animated:YES];
                                                        }
                                                        else if ([UserInfoManager getUserAuthState]==2 || [UserInfoManager getUserAuthState]==3)
                                                        {
                                                            MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
                                                            stateVC.authState=[UserInfoManager getUserAuthState];
                                                            stateVC.hidesBottomBarWhenPushed=YES;
                                                            [self.navigationController pushViewController:stateVC animated:YES];
                                                        }
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}

-(void)lookBigPhoto
{
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    [lookImage showWithImageArray:@[self.model.url] curImgIndex:0 AbsRect:CGRectMake(0, 0, UI_SCREEN_WIDTH, 430)];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {};
}

@end
