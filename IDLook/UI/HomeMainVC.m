//
//  HomeMainVC.m
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeMainVC.h"
#import "WordSearchVC.h"
#import "SearchMainVC.h"
#import "HomeService.h"
#import "UserInfoVC.h"
#import "RecommendVC.h"
#import "HomeMainVCM.h"
#import "HomeMirrorVC.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"
#import "LookPricePopV.h"
#import "LookPricePopV2.h"
#import "VideoPlayer.h"
#import "HomeMainCellD.h"
#import "PlaceShotOrderVC.h"
#import "PlaceAuditionOrderVC.h"
#import "AdvBannerView.h"
#import "BannerPopV.h"
#import "WorksModel.h"
#import "PublicWebVC.h"
#import "VideoMainVC.h"
#import "VideoListVC.h"
#import "HomeTopV.h"
#import "HomeBannerView.h"
#import "ActorCell.h"
#import "ActorVideoView.h"
#import "OfferTypePopV3.h"
#import "MassesActorViewController.h"
#import "RoleServiceApplyVC.h"
#import "InsuranceVC.h"
#import "VIPViewController.h"
#import "StoreViewController.h"
#import "LookBigImageVC.h"
#import "PublishGradeViewController.h"
#import "OrderProjectModel.h"
#import "AnnunciateVC.h"
#import "CouponPopV.h"
#import "CouponVC.h"
#import "AnnunciateModel.h"
#import "AnnunDetailVC.h"
#import "WriteFileManager.h"
#import "ReturnKeyShareVC.h"
#import "QNTestVC.h"
@interface HomeMainVC ()<HomeServiceDelegate,UIScrollViewDelegate>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)HomeService *service;
@property(nonatomic,strong)HomeMainVCM *dsm;   //viewmodel处理数据
@property(nonatomic,strong)NSIndexPath *currentIndexPath;
//@property(nonatomic,strong)AdvBannerView *bannerView;
@property(nonatomic,strong)HomeBannerView *bannerView;
@property(nonatomic,strong)HomeTopV *topV;


@end

@implementation HomeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor=Public_Background_Color;
  
 
    [self dsm];
    [self tableV];
    //收听appdelegate的push通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(getUserInfoWhenAppLauchFromForeignWithActorId:) name:@"HomeVCPush" object:nil];//此分享作app唤醒时的通知进指定页面。包含演员主页，优惠券兑换页，通告详情页
     [notiCenter addObserver:self selector:@selector(HomeVCReload) name:@"HomeVCReload" object:nil];//annuciatePush
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
   //   [self.navigationItem setTitleView:[CustomNavVC getHomeSearchButtonWithTarget:self action:@selector(wordsearch)]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player destroyPlayer];
    _player = nil;
   
    [self.navigationController setHidesBottomBarWhenPushed:NO];
}

-(void)HomeVCReload//无网启动后，骨架屏导致table不能下拉刷新的解决办法
{
    if (_dsm.ds.count==0) {
        [self pullDownToRefresh:nil];
    }
}
//输入框进入关键字搜索
-(void)wordsearch
{
    WordSearchVC *searchVC=[[WordSearchVC alloc]init];
    searchVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(HomeTopV*)topV
{
    if (!_topV) {
        _topV=[[HomeTopV alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
        [self.view addSubview:_topV];
        WeakSelf(self);
        _topV.selectWithType = ^(NSInteger type) {
            [weakself clickEntryVideoWithType:type];
        };
        _topV.hidden=YES;
    }
    return _topV;
}

-(HomeService*)service
{
    if (!_service) {
        _service=[[HomeService alloc]init];
        _service.delegate=self;
        _service.dsm=self.dsm;
    }
    return _service;
}

-(HomeMainVCM*)dsm
{
    if (!_dsm) {
        _dsm=[[HomeMainVCM alloc]init];
        WeakSelf(self);
        _dsm.newDataNeedRefreshed = ^(BOOL success) {
            if (success) {  //刷新ui
                weakself.tableV.animatedStyle = TABTableViewAnimationEnd;
                [weakself.tableV reloadData];
            }
            [weakself.tableV headerEndRefreshing];
            [weakself.tableV footerEndRefreshing];
        };
        _dsm.refreshBanner = ^(BOOL success) {
            if (success) {
              //  weakself.bannerView.rollInterval=2.0;
                // [weakself.bannerView setImagesWithBannerDatas:weakself.dsm.bannerArray];
                weakself.bannerView.dataSource = weakself.dsm.bannerArray;
            }
        };
    }
    return _dsm;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,-20,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT+20) style:UITableViewStyleGrouped];
        _tableV.delegate = self.service;
        _tableV.dataSource = self.service;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        _tableV.tableHeaderView=[self tableHeadV];
        
         self.tableV.animatedStyle = TABTableViewAnimationStart;
[_tableV addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
//        [_tableV addFooterWithTarget:self action:@selector(pullUpToRefresh:)];
    }
    
    return _tableV;
}

-(UIView*)tableHeadV
{
    CGFloat bgHeight = (UI_SCREEN_WIDTH-30)*0.3768;
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, bgHeight+228)];//300是搜索框高度 72是重合高度
    bg.backgroundColor=[UIColor whiteColor];
//    AdvBannerView *bannerView = [[AdvBannerView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, (260.0/750.0)*(UI_SCREEN_WIDTH))] ;
//    bannerView.rollInterval=2.0;
//    bannerView.animateInterval=0.5;
    HomeBannerView *bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0,10, UI_SCREEN_WIDTH, bgHeight+218)];//banner是bg的子视图 bg这个view才是headerView
    [bg addSubview:bannerView];
    WeakSelf(self);
    bannerView.blockLoginOut = ^{
                                LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
                                login.isHideClose=YES;
                [weakself.tabBarController setSelectedIndex:0];
                                [weakself presentViewController:login animated:YES completion:nil];
    };

    bannerView.clickBannerWithDictionary = ^(NSDictionary * _Nonnull dic) {
        NSString *url =@"";

        NSString *appenId;
        NSString *jumpUrl;
        if ([UserInfoManager getIsJavaService]) {
            appenId=dic[@"appendId"];
            jumpUrl=dic[@"jumpUrl"];
        }
        else
        {
            appenId=dic[@"appendid"];
            jumpUrl=dic[@"jumpurl"];
        }

        if ([appenId integerValue]==1) {
            url=[NSString stringWithFormat:@"%@?artistid=%@",jumpUrl,[UserInfoManager getUserUID]];
        }
        else
        {
            url=jumpUrl;
        }
        if ([jumpUrl isKindOfClass:[NSNull class]]) {
            return ;
        }
        NSInteger bannerId = [dic[@"id"] integerValue];
        [self staticsWithType:@"banner" bannerId:[NSString stringWithFormat:@"%ld",bannerId]];
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:dic[@"name"] url:url];
        webVC.hidesBottomBarWhenPushed=YES;
        [weakself.navigationController pushViewController:webVC animated:YES];
        
//             test
//            OfferTypePopV3 *popV= [[OfferTypePopV3 alloc]init];
//        NSMutableArray *priceArr = [NSMutableArray new];
//
//            PriceModel *pricem = [[PriceModel alloc] init];
//            pricem.type = 1;
//            pricem.singleprice = @"123";
//            [priceArr addObject:pricem];
//
//        PriceModel *select = [[PriceModel alloc] init];
//        select.type = 1;
//        select.day = 10;
//            [popV showOfferTypeWithPriceList:[priceArr copy] withSelectArray:[NSArray arrayWithObject:select] withUserModel:nil];
    };
    self.bannerView=bannerView;
    return bg;
}

-(void)pullDownToRefresh:(id)sender
{
    [self.dsm refreshHomeInfoWithSortPage:1 withRefreshType:RefreshTypePullDown];
}

-(void)pullUpToRefresh:(id)sender
{
    UserModel *info = [self.dsm.ds lastObject];
    [self.dsm refreshHomeInfoWithSortPage:info.sortpage+1 withRefreshType:RefreshTypePullUp];
}

#pragma mark---HomeServiceDelegate
//微代言，微出镜，招商项目
-(void)didClick1WithType:(NSInteger)type
{
    [SVProgressHUD showImage:nil status:@"功能正在开发中，敬请期待。"];
}

//按类型搜索
-(void)didClick2WithType:(NSInteger)type
{
    if (type<=3) {
        //按类型搜索
        SearchMainVC *searchVC=[[SearchMainVC alloc]init];
        searchVC.hidesBottomBarWhenPushed=YES;
        searchVC.type=type;
        [self.navigationController pushViewController:searchVC animated:YES];
    }
    else
    {
        [SVProgressHUD showImage:nil status:@"功能正在开发中，敬请期待。"];
    }
}

//进入广告，影视，外籍模特 群众演员页面  选角服务 意外险。积分商城 操作指南 vip申请
-(void)clickEntryVideoWithType:(NSInteger)type
{

//    WeakSelf(self);
    if (type==0) {
        VideoMainVC *videoVC=[[VideoMainVC alloc]init];
        videoVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:videoVC animated:YES];
    }else if (type == 1){//影视
                VideoListVC *listVC=[[VideoListVC alloc]init];
                listVC.hidesBottomBarWhenPushed=YES;
                listVC.masteryType=type+1;
                [self.navigationController pushViewController:listVC animated:YES];
    }else if (type == 2){//外籍模特
        VideoListVC *listVC=[[VideoListVC alloc]init];
        listVC.hidesBottomBarWhenPushed=YES;
        listVC.masteryType=type+1;
        [self.navigationController pushViewController:listVC animated:YES];
    }else if (type == 3){//前景演员
//        MassesActorViewController *masses = [MassesActorViewController new];
//                masses.hidesBottomBarWhenPushed = YES;
//                 [self.navigationController pushViewController:masses animated:YES];
        
//        NSDictionary *arg = @{
//                              @"orderId":@"201906191459244805",
//                              @"userId":@([[UserInfoManager getUserUID] integerValue])
//                              };
//        [AFWebAPI_JAVA lauchAuditionOnlineWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
//            NSDictionary *body = object[@"body"];
//            NSString *token = body[@"token"];
//            if (token.length>0) {
//                QNTestVC *qn = [QNTestVC new];
//                qn.isCall = YES;
//                qn.token = @"";
//                qn.hisAvatar = @"http://file.idlook.com/face_2018112315362543157_orgin.jpg";
//                qn.hisName = @"梁朝伟";
//                    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//                    if (authStatus != AVAuthorizationStatusAuthorized) {
//
//                        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                            NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
//                            if (granted) {
//                                    [self presentViewController:qn animated:YES completion:nil];
//                            }
//                        }];
//
//                    } else {  //做你想做的（可以去打开设置的路径）
//                   // [self navi :qn animated:YES completion:nil];
//                        [self.navigationController pushViewController:qn animated:YES];
//                    }
        
            
            
      //  }];
        
        VideoListVC *listVC=[[VideoListVC alloc]init];
        listVC.hidesBottomBarWhenPushed=YES;
        listVC.masteryType=type+1;
        [self.navigationController pushViewController:listVC animated:YES];
    }else if (type == 10){//选角服务
        if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {   //游客模式
            LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
            [self presentViewController:login animated:YES completion:nil];
            return;
        }
        [self staticsWithType:@"选角" bannerId:@""];
        RoleServiceApplyVC *auditVC = [RoleServiceApplyVC new];
                auditVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:auditVC animated:YES];
    }else if (type == 11){//意外险
        if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {   //游客模式
            LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
            [self presentViewController:login animated:YES completion:nil];
            return;
        }
         [self staticsWithType:@"保险" bannerId:@""];
        InsuranceVC *vc = [InsuranceVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (type == 12){//积分商城
        if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {   //游客模式
            LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
            [self presentViewController:login animated:YES completion:nil];
            return;
        }
         [self staticsWithType:@"商城" bannerId:@""];
        StoreViewController *store=[[StoreViewController alloc]init];
        store.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:store animated:YES];
    }else if (type == 13){//操作指南
        //www.test.idlook.com/app/handbook
         [self staticsWithType:@"指南" bannerId:@""];
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"操作指南" url:@"http://www.idlook.com/public/handbook/index.html"];
        webVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if (type == 14){//vip申请
        if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {   //游客模式
            LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
            [self presentViewController:login animated:YES completion:nil];
            return;
        }
         [self staticsWithType:@"vip" bannerId:@""];
        VIPViewController *vip=[[VIPViewController alloc]init];
        vip.hidesBottomBarWhenPushed=YES;
        vip.reloadUI = ^{
           // [weakself.tableV reloadData];
        };
        [self.navigationController pushViewController:vip animated:YES];
    }else if (type==20){//通告
       AnnunciateVC *annunc = [AnnunciateVC new];
        annunc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:annunc animated:YES];
    }
}

//进入艺人主页
-(void)didClickUser:(UserModel *)info withSelect:(NSString *)select
{
    UserInfoVC *userInfoVC=[[UserInfoVC alloc]init];
    userInfoVC.hidesBottomBarWhenPushed=YES;
    UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
    uInfo.actorId = info.actorId;
    uInfo.nickName = info.nickName;
    uInfo.sex = info.sex;
    uInfo.region = info.region;
    uInfo.avatar = info.actorHeadMini;
    userInfoVC.info =uInfo;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

-(void)playVideoWithModel:(WorksModel *)model withIndexPath:(NSIndexPath *)indexPath andPage:(NSInteger)page
{
//    self.currentIndexPath=indexPath;
//     HomeMainCellD *cell = [self.tableV cellForRowAtIndexPath:indexPath];
//    UIButton *timeBtn = [cell.contentView viewWithTag:999];
//        //page释义 1.cell横向滚动传值 来确定player的frame 2.table滚动传100，来告知该方法当前是table滚动
//    if (page==100) {//说明是滑动table，
//        if(_player.currentIndexPath == indexPath){//说明此次滚动并没有触发播放其他cell视频
//            return;
//            }
//        //需要播放其他cell视频。则销毁c重来,page置0
//         [self endDeceleratingPlay];
//        page = 0;
//    }else if(page<100){//是当前cell横向画滚动
//         [self endDeceleratingPlay];;
//    }
//
//    _player = [[VideoPlayer alloc] init];
//    UIScrollView *scr = [cell.contentView viewWithTag:555];
//   timeBtn.hidden = YES;
//    UIView *videoIcon = [scr viewWithTag:4000+page];
//    _player.frame = videoIcon.frame;
//    _player.isMute=[UserInfoManager getListPlayIsMute];
//    _player.videoUrl =model.video;
//
//    [_player playerBindTableView:self.tableV currentIndexPath:indexPath];
//
//    [scr addSubview:_player];
//
//    _player.completedPlayingBlock = ^(VideoPlayer *player) {
//        [player destroyPlayer];
//        player = nil;
//    };
//    WeakSelf(self);
//    _player.dowmLoadBlock = ^{
//        [weakself VideostatisticsWithWorkModel:model withType:2];
//    };
//    [self VideostatisticsWithWorkModel:model withType:1];
    self.currentIndexPath=indexPath;
         ActorCell *cell = [self.tableV cellForRowAtIndexPath:indexPath];
    if (page==100) {//说明是滑动table，
                if(_player.currentIndexPath == indexPath){//说明此次滚动并没有触发播放其他cell视频
                    return;
                    }
                //需要播放其他cell视频。则销毁c重来,page置0
                 [self endDeceleratingPlay];
                page = 0;
            }else if(page<100){//是当前cell横向画滚动
                 [self endDeceleratingPlay];;
            }
    _player = [[VideoPlayer alloc] init];
        UIScrollView *scr = [cell.contentView viewWithTag:555];
    ActorVideoView *videoIcon = [scr viewWithTag:4000+page];
    CGRect playerFrame = CGRectMake(videoIcon.x+15, 0, videoIcon.width-30, videoIcon.height);
     _player.frame = playerFrame;
    _player.isMute=[UserInfoManager getListPlayIsMute];
        _player.videoUrl =model.video;
    
        [_player playerBindTableView:self.tableV currentIndexPath:indexPath];
    _player.playerLayer.masksToBounds=YES;
    _player.playerLayer.cornerRadius=5.0;
    _player.layer.masksToBounds=YES;
    _player.layer.cornerRadius=5.0;
        [scr addSubview:_player];
    
        _player.completedPlayingBlock = ^(VideoPlayer *player) {
            [player destroyPlayer];
            player = nil;
        };
        WeakSelf(self);
        _player.dowmLoadBlock = ^{
            [weakself VideostatisticsWithWorkModel:model withType:2];
        };
        [self VideostatisticsWithWorkModel:model withType:1];
}

//结束播放
-(void)endDeceleratingPlay
{
    [_player.player.currentItem cancelPendingSeeks];
    [_player.player.currentItem.asset cancelLoading];
    [_player destroyPlayer];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
   [_player removeFromSuperview];
    _player =nil;
    
}

-(void)scrollViewEndScrollView
{
    if ([[NetworkNoti shareInstance]getNetworkStatus]==AFNetworkReachabilityStatusReachableViaWWAN && [UserInfoManager getWWanAuthPlay]==NO) {
        return;
    }
    else if ([[NetworkNoti shareInstance]getNetworkStatus]==AFNetworkReachabilityStatusReachableViaWiFi && [UserInfoManager getWifiAuthPlay]==NO)
    {
        return;
    }
    
    NSArray<NSIndexPath *> * cellArr = [self.tableV indexPathsForVisibleRows];
    if (cellArr.count>=2) {
        NSIndexPath * currentIndexPath = cellArr[cellArr.count - 2];
        if (self.currentIndexPath==currentIndexPath) {
            return;
        }
        if (cellArr.count==2 &&currentIndexPath.section==0) {
            return;
        }
        UserModel *info = self.dsm.ds[currentIndexPath.row];
        
        if (info.showList.count==0) {
            return;
        }
        long timeNow = (long)[[NSDate date] timeIntervalSince1970];
        long timeBefore = [UserInfoManager getLastedVideoPlayTime];
        if ((timeNow - timeBefore)>videoPlayMergin) {
            WorksModel *model = [[WorksModel alloc]init];
           NSDictionary *videoDic = [info.showList firstObject];
            ActorVideoViewModel *videoModel = [ActorVideoViewModel yy_modelWithDictionary:videoDic];
            model.workType = videoModel.vtype;
            model.creativeid = [NSString stringWithFormat:@"%ld",videoModel.id];
            model.video = videoModel.videoUrl;
            if (videoModel.videoUrl.length<2) {
                return;
            }
             [UserInfoManager setLastestVideoPlayTime:timeNow];
            [self playVideoWithModel:model withIndexPath:currentIndexPath andPage:100];
        }
        
    }
}

//scrollview滑动
-(void)scrollUpScreen
{
    CGFloat offY= self.tableV.contentOffset.y;
    if (offY<((260.0/750.0)*(UI_SCREEN_WIDTH)+130)) {
        self.topV.hidden=YES;
    }
    else
    {
        self.topV.hidden=NO;
    }
   
    [_player playerScrollIsSupportSmallWindowPlay:NO];
}

//查看报价
-(void)lookUserPriceInfo:(UserInfoM *)info
{
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {
        [SVProgressHUD showImage:nil status:@"登录后可查看报价！"];
        return;
    }
    
    //未认证成功，跳到认证界面
    if ([UserInfoManager getUserAuthState]!=1) {
        [SVProgressHUD showImage:nil status:@"认证后可查看报价！"];
        return;
    }
    
    [SVProgressHUD showImage:nil status:@"正在读取报价信息"];
    NSDictionary *dicArg = @{@"userid":info.UID};
    [AFWebAPI getQuotaListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array =[object objectForKey:JSON_data];
            if (array.count>0) {
                LookPricePopV2 *popV= [[LookPricePopV2 alloc]init];
                [popV showWithArray:array];
                popV.placeActionBlockWithAudition = ^(PriceModel * _Nonnull model) {
                    PlaceShotOrderVC *shotVC=[[PlaceShotOrderVC alloc]init];
                    model.day=1;
                    shotVC.info=info;
                    shotVC.pModel=model;
                    shotVC.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:shotVC animated:YES];
                };
                popV.placeActionBlockWithScreening = ^(OrderStructM * _Nonnull model) {
                    PlaceAuditionOrderVC *auditVC = [[PlaceAuditionOrderVC alloc]init];
                    auditVC.info=info;
                    auditVC.sModel=model;
                    auditVC.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:auditVC animated:YES];
                };
            }
            else
            {
                [SVProgressHUD showImage:nil status:@"暂无报价！"];
                return;
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
}

#pragma mark --未认证，先去认证
-(void)goAuth
{
    if ([UserInfoManager getUserAuthState]==3){  //审核中
        [SVProgressHUD showImage:nil status:@"你的认证信息正在审核中，通过后才能查看报价！"];
        return;
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"去认证" message:@"认证通过之后您才能查看报价！" preferredStyle:UIAlertControllerStyleAlert];
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
-(void)getUserInfoWhenAppLauchFromForeignWithActorId:(NSNotification *)noti
{
    WeakSelf(self);
      NSString *UID = noti.object;
    if ([UID containsString:@"returnCode"]) {
        if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {   //游客模式
            LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
            [self presentViewController:login animated:YES completion:nil];
            return ;
        }
        if ([UserInfoManager getUserType]==2) {
            ReturnKeyShareVC *rkvc = [ReturnKeyShareVC new];
            rkvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rkvc animated:YES];
            return;
        }
        [self.tabBarController setSelectedIndex:0];
        NSString *returnCode = [UID stringByReplacingOccurrencesOfString:@"returnCode=" withString:@""];
        
            CouponVC *couponVC = [[CouponVC alloc]init];
            couponVC.hidesBottomBarWhenPushed=YES;
            couponVC.returnCode = returnCode;
            [self.navigationController pushViewController:couponVC animated:YES];
        
    }else if ([UID containsString:@"annunciateId"]){
        if ([UserInfoManager getUserType]==1) {
            return;
        }//买家不能弹跳
        
        NSArray *vcs = self.navigationController.childViewControllers;//已经在通告不用弹跳
        for (id controller in vcs) {
            if ([controller isKindOfClass:[AnnunciateVC class]] || [controller isKindOfClass:[AnnunDetailVC class]]) {
                return;
            }
        }
         [self.tabBarController setSelectedIndex:0];
        NSString *annunciateId = [UID stringByReplacingOccurrencesOfString:@"annunciateId=" withString:@""];
        if (annunciateId.length>0) {
            NSDictionary *dic = @{
                                  @"id":@([annunciateId integerValue])
                                  };
            [AFWebAPI_JAVA getAnnunDetailWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    NSDictionary *detailInfo = [object objectForKey:JSON_body][@"detailInfo"];
                    AnnunciateModel *model = [AnnunciateModel yy_modelWithDictionary:detailInfo];

                        AnnunDetailVC *detail = [AnnunDetailVC new];
                        detail.model = model;
                        detail.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:detail animated:YES];

                }else{
                    [SVProgressHUD showErrorWithStatus:object];

                }
            }];
            return;
        }
    
      
        AnnunciateVC *anvc = [AnnunciateVC new];
        anvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:anvc animated:YES];
    }else if ([UID containsString:@"banner"]){
         [self.tabBarController setSelectedIndex:0];
        NSString *bannerStr = [UID stringByReplacingOccurrencesOfString:@"banner_" withString:@""];
        NSArray *bannerArr = [bannerStr componentsSeparatedByString:@"+"];
        NSString *bannerUrl = [bannerArr objectAtIndex:1];
        NSString *bannerTitle = [bannerArr objectAtIndex:0];
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:bannerTitle url:bannerUrl];
        webVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
         [self.tabBarController setSelectedIndex:0];
    UserInfoVC *userInfoVC=[[UserInfoVC alloc]init];
    userInfoVC.hidesBottomBarWhenPushed=YES;
    UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
    uInfo.actorId = [UID integerValue];
    userInfoVC.info =uInfo;
    [self.navigationController pushViewController:userInfoVC animated:YES];
    
    }
}
//查看图片大图
-(void)lookPictureWithModel:(WorksModel *)model withIndexPath:(NSIndexPath *)indexPath andPage:(NSInteger)page
{
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    [lookImage showWithImageArray:[NSArray arrayWithObject:model.cutvideo] curImgIndex:0 AbsRect:CGRectMake(0, 0,0,0)];
    lookImage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {  //下载回掉
        [self VideostatisticsWithWorkModel:model withType:2];
    };
}

//视频浏览量埋点统计
-(void)VideostatisticsWithWorkModel:(WorksModel*)model withType:(NSInteger)type
{
    if ([UserInfoManager getIsJavaService]) {
        NSDictionary *dicArg = @{@"vid":model.creativeid,
                                 @"vType":@(model.workType),
                                 @"numType":@(type),//播放 or 下载
                                 @"num":@(1)
                                 };
        [AFWebAPI_JAVA getVideoStatisticalWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
            }
            else{}
        }];
    }
    else
    {
    
    NSDictionary *dicArg = @{@"vid":model.creativeid,
                             @"vtype":@(model.workType),
                             @"type":@(type)};
    [AFWebAPI getVideoStatisticalWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
        }
        else{}
    }];
    }
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
//首页4入口+banner统计
-(void)staticsWithType:(NSString *)type bannerId:(NSString *)bannerId
{
    NSString *action;
    if ([type isEqualToString:@"选角"]) {
        action = @"chooseActorPage";
    }else if ([type isEqualToString:@"保险"]){
        action = @"insurancePage";
    }
    else if ([type isEqualToString:@"商城"]){
        action = @"pointShopPage";
    }
    else if ([type isEqualToString:@"指南"]){
        action = @"guidePage";
    }
    else if ([type isEqualToString:@"vip"]){
        action = @"vipPage";
    }
    else if ([type isEqualToString:@"banner"]){
        action = @"appBanner";
    }
    NSInteger uid;
    if([UserInfoManager getUserUID].length>0){
        uid = [[UserInfoManager getUserUID]integerValue];
    }else{
        uid = 0;
    }
    NSDictionary *dic;
    if (bannerId.length>0) {
       dic = @{
                               @"action":action,
                               @"userId":@(uid),
                               @"userType":@([UserInfoManager getUserType]),
                               @"target":@([bannerId integerValue])
                               };
        
    }else{
        dic = @{
                               @"action":action,
                               @"userId":@(uid),
                               @"userType":@([UserInfoManager getUserType])
                               };
        
    }
    [AFWebAPI_JAVA staticsWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSLog(@"----------obj is %@------------",object);
        }
    }];
 
}
@end
