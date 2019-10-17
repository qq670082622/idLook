//
//  RootTabbarVC.m
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RootTabbarVC.h"
#import "HomeMainVC.h"
#import "VideoMainVC.h"
#import "CollectionMainVC.h"
#import "MsgMainVC.h"
#import "CenterMainVC.h"
#import "ProjectMainVC.h"
#import "LoginAndRegistVC.h"
#import "NetworkSettPopV.h"
#import "AnnunciateVC.h"
#import "QNTestVC.h"
#import "BuyerHomeVC.h"
#import <AVFoundation/AVFoundation.h>
@interface RootTabbarVC ()<UITabBarControllerDelegate,MCTabBarControllerDelegate>
@property(nonatomic,strong)UIButton *auditionBtn;
@property(nonatomic,strong)NSMutableDictionary *roomDic;
@end

@implementation RootTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.delegate=self;
    

    
      NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
       [notiCenter addObserver:self selector:@selector(pushToOrderTab) name:@"pushToOrderTab" object:nil];
    
    [notiCenter addObserver:self selector:@selector(presentToQN:) name:@"presentToQN" object:nil];
    //清除半透明层
//    for (UIView *view in self.tabBar.subviews) {
//        [view removeFromSuperview];
//    }
    NSString *userType = [WriteFileManager userDefaultForKey:@"userType"];
//    userType 户自定义类型 0=未选择 1=电商 2=制片 3=演员
//    买家是 达人。演员 收藏 我
//    演员 是 演员 达人 通告 收藏 我
     //首页
    HomeMainVC *homeVC = [[HomeMainVC alloc] init];
        BuyerHomeVC *buy = [BuyerHomeVC new];
    buy.tabBarItem.tag=100;
    homeVC.tabBarItem.tag=101;
    if ([userType isEqualToString:@"1"]) {
//
        [self addChildController:buy title:@"带货达人" imageName:@"common_tabbar_talent_icon_n" selectedImageName:@"common_tabbar_talent_icon_s"];
        [self addChildController:homeVC title:@"广告演员" imageName:@"common_tabbar_acto_icon_n" selectedImageName:@"common_tabbar_acto_icon_s"];
    }else if ([userType isEqualToString:@"2"]){
        [self addChildController:homeVC title:@"广告演员" imageName:@"common_tabbar_acto_icon_n" selectedImageName:@"common_tabbar_acto_icon_s"];
          [self addChildController:buy title:@"带货达人" imageName:@"common_tabbar_talent_icon_n" selectedImageName:@"common_tabbar_talent_icon_s"];
    }else if ([userType isEqualToString:@"3"]){
         [self addChildController:homeVC title:@"广告演员" imageName:@"common_tabbar_acto_icon_n" selectedImageName:@"common_tabbar_acto_icon_s"];
         [self addChildController:buy title:@"带货达人" imageName:@"common_tabbar_talent_icon_n" selectedImageName:@"common_tabbar_talent_icon_s"];
    }else if ([userType isEqualToString:@"0"]){
          [self addChildController:buy title:@"带货达人" imageName:@"common_tabbar_talent_icon_n" selectedImageName:@"common_tabbar_talent_icon_s"];
                [self addChildController:homeVC title:@"广告演员" imageName:@"common_tabbar_acto_icon_n" selectedImageName:@"common_tabbar_acto_icon_s"];
    }
    
 

    //收藏
    if (![userType isEqualToString:@"3"]) {
        CollectionMainVC *collectVC = [[CollectionMainVC alloc] init];
        collectVC.tabBarItem.tag=102;
        [self addChildController:collectVC title:@"收藏" imageName:@"common_tabbar_collect_icon_n" selectedImageName:@"common_tabbar_collect_icon_s"];
    }
   
    
    if ( [UserInfoManager getUserType] == 2) {
        //    创建自定义TabBar
   self.mcTabbar.position = MCTabBarCenterButtonPositionBulge;
        self.mcTabbar.centerImage = [UIImage imageNamed:@"icon_bigBtn"];
        self.mcDelegate = self;
        self.mcTabbar.tintColor = Public_Red_Color;
        AnnunciateVC *ann = [AnnunciateVC new];
         [self addChildController:ann title:@"通告" imageName:@"" selectedImageName:@""];
    }
    if ([userType isEqualToString:@"3"]) {
        CollectionMainVC *collectVC = [[CollectionMainVC alloc] init];
        collectVC.tabBarItem.tag=102;
        [self addChildController:collectVC title:@"收藏" imageName:@"common_tabbar_collect_icon_n" selectedImageName:@"common_tabbar_collect_icon_s"];
    }
    
    //消息
//    MsgMainVC *msgVC = [[MsgMainVC alloc] init];
//    msgVC.tabBarItem.tag=103;
//    [self addChildController:msgVC title:@"消息" imageName:@"menu_message_n" selectedImageName:@"menu_message_h"];

   
    if ([UserInfoManager getUserType]==UserTypePurchaser) {
        //项目
//        ProjectMainVC *projectVC = [[ProjectMainVC alloc] init];
//        projectVC.tabBarItem.tag=104;
//        [self addChildController:projectVC title:@"项目" imageName:@"menu_projected_n" selectedImageName:@"menu_projected_h"];
    }
  
    //我的
    CenterMainVC *centerVC = [[CenterMainVC alloc] init];
    centerVC.tabBarItem.tag=105;
    [self addChildController:centerVC title:@"我的" imageName:@"common_tabbar_me_icon_n" selectedImageName:@"common_tabbar_me_icon_s"];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
//    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    

//  __block  BOOL notReachable = false;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //网络监听
        if ([[NetworkNoti shareInstance]getNetworkStatus]==AFNetworkReachabilityStatusReachableViaWWAN && [UserInfoManager getNetworkSettingFirst]) {   //流量时弹出提示框,只会一次弹出
            NetworkSettPopV *popV = [[NetworkSettPopV alloc]init];
            [popV show];
        }
    });
    
    
    UIButton *ab = [UIButton buttonWithType:0];
    [ab setImage:[UIImage imageNamed:@"icon_auditionRoom"] forState:0];
    ab.frame = CGRectMake(UI_SCREEN_WIDTH-100, UI_SCREEN_HEIGHT-170, 98, 86);
    [ab addTarget:self action:@selector(joinRoom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ab];
    self.auditionBtn = ab;
    [self.auditionBtn setTag:336699];
//    [self.view setTag:336688];
    self.auditionBtn.hidden = YES;
}

- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName
{
    id item ;
    item = [childController.tabBarItem initWithTitle:title
                                               image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                       selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    [childController.tabBarItem setImageInsets:UIEdgeInsetsMake(3, 0, -3, 0)];

    // 设置一下选中tabbar文字颜色
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Public_Red_Color}forState:UIControlStateSelected];
    
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor}forState:UIControlStateNormal];
    if ([title isEqualToString:@"通告"]) {
            childController.title = title;//多加这句话，不然通告title不显示
       
    }

    CustomNavVC* nav = [[CustomNavVC alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist && viewController.tabBarItem.tag>101) {   //游客模式
        LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
        [self presentViewController:login animated:YES completion:nil];
        return NO;
    }
    return YES;
    
}

-(void)skipMineWithIndex:(NSInteger)index
{
    [self setSelectedIndex:index];
}

// 使用MCTabBarController 自定义的 选中代理
- (void)mcTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2){
        [self rotationAnimation];
    }else {
        [self.mcTabbar.centerBtn.layer removeAllAnimations];
    }
}
//旋转动画
- (void)rotationAnimation{
    if ([@"key" isEqualToString:[self.mcTabbar.centerBtn.layer animationKeys].firstObject]){
        return;
    }
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 0.3;
    rotationAnimation.repeatCount = 1;
    [self.mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}
-(void)pushToOrderTab
{
    self.selectedIndex = 3;
}
-(void)presentToQN:(NSNotification *)noti
{
    
    NSDictionary *QNDic = noti.object;
    NSString *token = QNDic[@"token"];
    if (token.length>0) {
        self.auditionBtn.hidden = NO;
        self.roomDic = [NSMutableDictionary dictionary];
        [_roomDic addEntriesFromDictionary:QNDic];
       }else{
         self.auditionBtn.hidden = YES;
    }
 
}
-(void)joinRoom
{
    QNTestVC *qn = [QNTestVC new];
    qn.isCall = NO;
    qn.hisName = _roomDic[@"otherName"];
    qn.hisAvatar = _roomDic[@"otherHead"];
    qn.token = _roomDic[@"token"];
    qn.roomName = _roomDic[@"roomName"];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus != AVAuthorizationStatusAuthorized) {

        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
            if (granted) {
                [self presentViewController:qn animated:YES completion:nil];
            }
        }];

    } else {  //做你想做的（可以去打开设置的路径）
        [self presentViewController:qn animated:YES completion:nil];
    }
  
   
}
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
