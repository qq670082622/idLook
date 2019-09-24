//
//  BuyerHomeVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/12.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "BuyerHomeVC.h"
#import "BuyerHomeBanner.h"
#import "BuyerConditionModel.h"
#import "PublicWebVC.h"
#import "BuyerHomeCell.h"
#import "ActorTopListVC.h"
#import "ActorSearchListvc.h"
#import "ReturnKeyShareVC.h"
#import "CouponVC.h"
#import "AnnunciateVC.h"
#import "AnnunciateModel.h"
#import "AnnunDetailVC.h"
@interface BuyerHomeVC ()<UITableViewDelegate,UITableViewDataSource>
//@property(nonatomic,strong)CustomTableV *tableV;

@property (weak, nonatomic) IBOutlet CustomTableV *tableV;
@property(nonatomic,strong)BuyerHomeBanner *bannerView;
@property(nonatomic,strong)BuyerConditionModel *conditionModel;
@property(nonatomic,strong)NSArray *bannerArray;
@property(nonatomic,strong)NSArray *tipArray;
@end

@implementation BuyerHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=Public_Background_Color;
    self.conditionModel = [BuyerConditionModel new];
    _conditionModel.tags = [NSMutableArray new];
    _conditionModel.regions = [NSMutableArray new];
    _conditionModel.platTypes = [NSMutableArray new];
    _conditionModel.sex = -1;
    
    CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height==20?-20:-44;
    CGFloat hei = [UIApplication sharedApplication].statusBarFrame.size.height==20?-46:-103;
    _tableV.frame = CGRectMake(0,y,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT+hei);
    _tableV.height = UI_SCREEN_HEIGHT+hei;
     _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableV.showsVerticalScrollIndicator=NO;
    _tableV.showsHorizontalScrollIndicator=NO;
    _tableV.backgroundColor=[UIColor clearColor];
    _tableV.tableHeaderView=[self tableHeadV];
    [self getData];
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    //收听appdelegate的push通知
    NSString *userType = [WriteFileManager userDefaultForKey:@"userType"];
    //    userType 户自定义类型 0=未选择 1=电商 2=制片 3=演员
    if ([userType isEqualToString:@"1"]) {
        [notiCenter addObserver:self selector:@selector(getUserInfoWhenAppLauchFromForeignWithActorId:) name:@"HomeVCPush" object:nil];//此分享作app唤醒时的通知进指定页面。包含演员主页，优惠券兑换页，通告详情页
    }
  //  self.tableV.animatedStyle = TABTableViewAnimationStart;
}
-(void)getData
{
    //banner
    NSDictionary *dicArg = @{@"userType":@([UserInfoManager getUserType])};
    [AFWebAPI_JAVA getAppBannerWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            NSArray *list = [[object objectForKey:JSON_body] objectForKey:@"bannerList"];
            self.bannerArray = list;
            
             _bannerView.bannerData = _bannerArray;
        }
        else
        {
            // [SVProgressHUD showErrorWithStatus:@"首页下拉刷新获取信息失败"]; 后端这个接口间歇性报错，很挫 所以不提示
        }
      
    }];
    
    //公告
    [AFWebAPI_JAVA getBulletinListWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSArray *bulletinList = object[@"body"];
            NSMutableArray *muArr = [NSMutableArray new];
            for (NSDictionary *tipDic in bulletinList) {
                [muArr addObject:tipDic[@"content"]];
            }
            _tipArray = [muArr copy];
             _bannerView.tipsData = _tipArray;
        }
    }];
    
    [AFWebAPI_JAVA getBuyerHomeConfigWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *body = object[@"body"];
            [WriteFileManager saveObject:body name:@"homeConfig"];
        }
    }];
}
-(UIView*)tableHeadV
{
  UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 330)];//300是搜索框高度 72是重合高度
    bg.backgroundColor=[UIColor whiteColor];
 BuyerHomeBanner *bannerView = [[BuyerHomeBanner alloc] initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 330)];//banner是bg的子视图 bg这个view才是headerView
    bannerView.tipsData = _tipArray;
    bannerView.bannerData = _bannerArray;
   [bg addSubview:bannerView];
    WeakSelf(self);
    bannerView.topAction = ^{
        ActorTopListVC *topL = [ActorTopListVC new];
        topL.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:topL animated:YES];
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
    
    PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:dic[@"name"] url:url];
        webVC.hidesBottomBarWhenPushed=YES;
        [weakself.navigationController pushViewController:webVC animated:YES];

    };
    self.bannerView=bannerView;
    return bg;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    BuyerHomeCell *cell = [BuyerHomeCell cellWithTableView:tableView];
    cell.model = _conditionModel;
    cell.cellSelectCondition = ^(BuyerConditionModel * _Nonnull model) {
        ActorSearchListvc *searchList = [ActorSearchListvc new];
        searchList.conditionModel = weakself.conditionModel;
        searchList.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:searchList animated:YES];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    };
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyerHomeCell *cell = [BuyerHomeCell cellWithTableView:tableView];
    cell.model = _conditionModel;
    return cell.cellHei;
}
//-(void)pullDownToRefresh:(id)sender
//{
//    [self refreshHomeInfoWithSortPage:1 withRefreshType:RefreshTypePullDown];
//}
//
//-(void)pullUpToRefresh:(id)sender
//{
//    UserModel *info = [self.dsm.ds lastObject];
//    [self refreshHomeInfoWithSortPage:info.sortpage+1 withRefreshType:RefreshTypePullUp];
//}
//-(void)refreshHomeInfoWithSortPage:(NSInteger)sortpage withRefreshType:(RefreshType)type
//{
//
//}
-(void)getUserInfoWhenAppLauchFromForeignWithActorId:(NSNotification *)noti
{
  //  WeakSelf(self);
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
 
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setHidesBottomBarWhenPushed:NO];
}


@end
