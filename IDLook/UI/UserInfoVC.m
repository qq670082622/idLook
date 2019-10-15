//
//  UserInfoVC.m
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserInfoVC.h"
#import "UserInfoVC+Action.h"
#import "UserService.h"
#import "UserInfoTopV.h"
#import "UInfoBottomV.h"
#import "UserDetialInfoVC.h"
#import "UserInfoVCM.h"
#import "VideoDetialVC.h"
#import "LookBigImageVC.h"
#import "UserHeaderV.h"
#import "VideoPlayer.h"
#import "PlaceAuditionOrderVC.h"
#import "PlaceShotOrderVC.h"
#import "SharePopV.h"
#import "ShareManager.h"
#import "UserWorkModel.h"
#import "UserInfoCellC.h"
#import "OfferTypePopV3.h"
#import "UserLookPricePopV.h"
#import "OfferTypePopV4.h"
#import "VIPViewController.h"
#import "AskCalendarVC.h"
#import "PublishGradeViewController.h"
#import "AskPriceView.h"
#import "ActorGradesVC.h"
#import "ActorPriceListVC.h"
#import "AskCalendarPriceModel.h"
#import "UnAuthLookCountView.h"
#import "AuthBuyerVC.h"
#import "ChatVC.h"
@interface UserInfoVC ()<UIScrollViewDelegate,UserServiceDelegate,UserHeaderVDelegate,ActorPriceListVCDelegate>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)UserService *service;
@property (nonatomic,strong)UserInfoVCM *dataM;
@property(nonatomic,strong)UserInfoTopV *topV;          //头部大头像
@property(nonatomic,strong)UInfoBottomV *bottomV;     //底部订单视图
@property(nonatomic,strong)UIButton *collectBtn;    //收藏按钮
@property(nonatomic,strong)UIButton *praiseBtn;    //点赞按钮
@property(nonatomic,strong)UIButton *moreBtn;    //更多按钮
@property(nonatomic,strong)UIButton *shareBtn;    //分享按钮
@property(nonatomic,strong)UserHeaderV *headView;   //类型切换
@property(nonatomic,assign)NSInteger selectIndex;   //当前类型
@property(nonatomic,strong)UIButton *backTopBtn;    //回到顶部
@property(nonatomic,assign)NSInteger topHeight;  //顶部高度
@property(nonatomic,strong)NSDictionary *priceDic ;  //选择的类别
@property(nonatomic,assign)NSInteger selectDay;   //选中的天数

/**********询档相关***********/
@property(nonatomic,strong)NSArray *selectArray;//选择了哪些项目 pricemodel数组
@property(nonatomic,assign)NSInteger orderYear;//肖像年限
@property(nonatomic,assign)NSInteger orderRegion;//肖像范围
@property(nonatomic,assign)NSInteger otherArea;//异地拍摄
@property(nonatomic,assign)NSInteger total_vip;//vip总价
@property(nonatomic,assign)NSInteger total_normal;//普通总价
@end

@implementation UserInfoVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
    
//    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc]initWithCustomView:self.moreBtn],[[UIBarButtonItem alloc]initWithCustomView:self.shareBtn],[[UIBarButtonItem alloc]initWithCustomView:self.praiseBtn],[[UIBarButtonItem alloc]initWithCustomView:self.collectBtn]]];
    
    self.selectIndex=0;
    self.topHeight=198;
    [self tableV];
    
    [self bottomV];
    [self backTopBtn];
  }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(self.tableV.contentOffset.y / SafeAreaTopHeight)>0.99?0.99:(self.tableV.contentOffset.y /SafeAreaTopHeight)]] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [_player destroyPlayer];
    _player = nil;
}


-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIButton*)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectBtn.frame = CGRectMake(0, 0, 30, 30);
        [_collectBtn setImage:[UIImage imageNamed:@"u_info_collect_n"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"u_info_collect_h"] forState:UIControlStateSelected];
        [_collectBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

-(UIButton*)praiseBtn
{
    if (!_praiseBtn) {
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseBtn.frame = CGRectMake(0, 0, 30, 30);
        [_praiseBtn setImage:[UIImage imageNamed:@"u_info_praise_n"] forState:UIControlStateNormal];
        [_praiseBtn setImage:[UIImage imageNamed:@"u_info_praise_h"] forState:UIControlStateSelected];
        [_praiseBtn addTarget:self action:@selector(praiseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseBtn;
}

-(UIButton*)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(0, 0, 30, 30);
        [_shareBtn setImage:[UIImage imageNamed:@"u_info_share_n"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"u_info_share_n"] forState:UIControlStateSelected];
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

-(UIButton*)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame = CGRectMake(0, 0, 30, 30);
        [_moreBtn setImage:[UIImage imageNamed:@"u_info_more_n"] forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"u_info_more_n"] forState:UIControlStateSelected];
        [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

-(UIButton*)backTopBtn
{
    if (!_backTopBtn) {
        _backTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat originY = 0;
        if (self.bottomV.hidden==YES) {
            originY=UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-70;
        }
        else
        {
            originY=UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-70-54;
        }
        _backTopBtn.frame = CGRectMake(UI_SCREEN_WIDTH-64,originY, 44, 44);
        [self.view addSubview:_backTopBtn];
        _backTopBtn.layer.cornerRadius=22;
        _backTopBtn.layer.masksToBounds=YES;
        _backTopBtn.layer.borderColor=Public_DetailTextLabelColor.CGColor;
        _backTopBtn.layer.borderWidth=1.0;
        _backTopBtn.backgroundColor=[UIColor whiteColor];
        [_backTopBtn setTitle:@"顶部" forState:UIControlStateNormal];
        [_backTopBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        _backTopBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        [_backTopBtn setImage:[UIImage imageNamed:@"u_info_goTop"] forState:UIControlStateNormal];
        [_backTopBtn setImage:[UIImage imageNamed:@"u_info_goTop"] forState:UIControlStateSelected];
        [_backTopBtn addTarget:self action:@selector(backToTopAction) forControlEvents:UIControlEventTouchUpInside];
        
        _backTopBtn.titleLabel.backgroundColor = _backTopBtn.backgroundColor;
        _backTopBtn.imageView.backgroundColor = _backTopBtn.backgroundColor;
        CGSize titleSize = _backTopBtn.titleLabel.bounds.size;
        CGSize imageSize = _backTopBtn.imageView.bounds.size;
        CGFloat interval = 1;
        [_backTopBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width + interval))];
        [_backTopBtn setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval + 5, -(imageSize.width + interval), 0, 0)];
        _backTopBtn.hidden=YES;
    }
    return _backTopBtn;
}

- (UserInfoVCM *)dataM
{
    if (!_dataM)
    {
        _dataM = [[UserInfoVCM alloc] init];
        _dataM.info=self.info;
        WeakSelf(self);
        _dataM.newDataNeedRefreshed = ^{   //加载出数据，刷新ui
            [weakself.topV reloadUIWithInfo:weakself.dataM.info];
            weakself.headView.typeViewArray=weakself.dataM.typeDataSource[weakself.selectIndex];
            weakself.service.selectIndex=weakself.selectIndex;
            [weakself refreshHeadView];
            [weakself.tableV reloadData];
            weakself.collectBtn.selected=weakself.dataM.info.isCollect;
            weakself.praiseBtn.selected=weakself.dataM.info.isPraise;
            [weakself.bottomV reloadUIWithInfo:weakself.dataM.info];
            [weakself autoSwitchWork];
            if (weakself.isCheckPrice) {//这里是其他页面的未认证用户要查看价格
                [weakself lookPrice2];
            }
        };
    }
    return _dataM;
}

-(UserService*)service
{
    if (!_service) {
        _service = [[UserService alloc]init];
        _service.dataM=self.dataM;
        _service.delegate=self;
    }
    return _service;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableV.delegate = self.service;
        _tableV.dataSource = self.service;
        _tableV.bounces=YES;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor whiteColor];
        _tableV.tableHeaderView = [self tableHeadV];
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.bottomV.mas_top);
        }];

    }
    return _tableV;
}

-(UIView*)tableHeadV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, self.topHeight)];
    UserInfoTopV *view = [[UserInfoTopV alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH,self.topHeight)];
    WeakSelf(self);
    view.UserInfoTopVDetialInfo = ^{  //用户详情
        [weakself entryUserDetialInfo];
    };
    view.UserInfoTopVLookPrice = ^{  //查看报价
        [weakself lookUserPrice];
    };
    view.UserInfoTopVvipApplyfor = ^{  //vip申请
        [weakself vipApplyfor];
    };
    view.lookAllEvaluateBlock = ^{  //查看全部评价
        ActorGradesVC *gradeVC = [[ActorGradesVC alloc]init];
        gradeVC.actorId=weakself.info.actorId;
        [weakself.navigationController pushViewController:gradeVC animated:YES];
    };
    [view reloadUIWithInfo:self.dataM.info];
    [bg addSubview:view];
    self.topV=view;
    return bg;
}

-(UserHeaderV*)headView
{
    if (!_headView) {
        _headView = [[UserHeaderV alloc]initWithFrame:CGRectMake(0,self.topHeight, UI_SCREEN_WIDTH,96)];
        [self.tableV addSubview:_headView];
        _headView.delegate=self;
    }
    return _headView;
}

-(UInfoBottomV*)bottomV
{
    if (!_bottomV) {
        _bottomV = [[UInfoBottomV alloc]init];
        [self.view addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-SafeAreaTabBarHeight_IphoneX);
            make.height.mas_equalTo(54);
        }];
        WeakSelf(self);
        _bottomV.phoneActionBlock = ^{  //客服
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            });
//            ChatVC *caht = [ChatVC new];
//                      caht.hidesBottomBarWhenPushed = YES;
//                      [weakself.navigationController pushViewController:caht animated:YES];

        };
        _bottomV.evaluateActionBlock = ^{   //评价
            if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist)
            {
                [weakself goLogin];
                return;
            }
            PublishGradeViewController *vc = [PublishGradeViewController new];
            vc.userModel = weakself.dataM.info;
            vc.gradeSuccessReferesh = ^{
                
            };
            vc.hidesBottomBarWhenPushed=YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        _bottomV.auditionActionBlock = ^{   //试镜下单
          [weakself PlaceorderWithType:0];
        };
        _bottomV.shotActionBlock = ^{   //拍摄下单
            if ([weakself.dataM.info.priceInfo[@"startPrice"] integerValue]==0) {
                AskPriceView *ap  = [[AskPriceView alloc] init];
                [ap showWithTitle:@"咨询价格" desc:@"此演员价格受拍摄日期，脚本影响较大，无固定价格。具体价格请拨打400-833-6969咨询脸探副导。" leftBtn:@"" rightBtn:@"" phoneNum:@"4008336969"];
                return;
            }
            [weakself PlaceorderWithType:1];
        };
        _bottomV.askScheduleBlock = ^{  //询问档期
//            UserInfoM *info = [[UserInfoM alloc]init];
//            info.UID = [NSString stringWithFormat:@"%ld",weakself.dataM.info.actorId];
//            AskCalendarVC *ask=[[AskCalendarVC alloc]init];
//            ask.info=weakself.dataM.info;
//            if (self.priceDic!=nil) {
//                ask.priceDic=@{@"dic":weakself.priceDic,@"day":@(weakself.selectDay)};
//            }
//            [weakself.navigationController pushViewController:ask animated:YES];
            
            if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {
                [SVProgressHUD showImage:nil status:@"登录后可询问档期！"];
                return;
            }
            
            //未认证成功，跳到认证界面
            if ([UserInfoManager getUserAuthState]!=1) {
                [SVProgressHUD showImage:nil status:@"认证后可询问档期！"];
                return;
            }
            if ([weakself.dataM.info.priceInfo[@"startPrice"] integerValue]==0) {
                AskPriceView *ap  = [[AskPriceView alloc] init];
                [ap showWithTitle:@"咨询价格" desc:@"此演员价格受拍摄日期，脚本影响较大，无固定价格。具体价格请拨打400-833-6969咨询脸探副导。" leftBtn:@"" rightBtn:@"" phoneNum:@"4008336969"];
                return;
            }
            if (_selectArray.count==0 || [_selectArray isKindOfClass:[NSNull class]]) {//没有选择项目，进入项目选择页面
                ActorPriceListVC *apvc = [ActorPriceListVC new];
                apvc.hidesBottomBarWhenPushed = YES;
                apvc.actorId = weakself.dataM.info.actorId;
                apvc.projectId = @"";
                apvc.delegate = weakself;
                apvc.selectArr = [NSArray new];
                apvc.year = 0;
                apvc.region = 0;
                apvc.yidi = 0;
                apvc.pushType = 2;
                
                apvc.info = weakself.dataM.info;
                [weakself.navigationController pushViewController:apvc animated:YES];
            }else if (_selectArray.count>0){//已经选择了拍摄项目，直接进入询档页面
                AskCalendarVC *ask=[[AskCalendarVC alloc]init];
                ask.info = weakself.dataM.info;
                ask.selectArray = weakself.selectArray;
                ask.orderYear = weakself.orderYear;
                ask.orderRegion = weakself.orderRegion;
                ask.otherArea = weakself.otherArea;
                ask.total_vip = weakself.total_vip;
                ask.total_normal = weakself.total_normal;
                if (self.priceDic!=nil) {
                    ask.priceDic=@{@"dic":weakself.priceDic,@"day":@(weakself.selectDay)};
                }
                [weakself.navigationController pushViewController:ask animated:YES];
            }
        };
        _bottomV.collectBlock = ^{  //收藏
            [weakself collectionAction];
        };
        _bottomV.praiseBlock = ^{ //分享
            [weakself praiseAction];
        };
        //只有购买方才显示下单视图
//        if ([UserInfoManager getUserType]==UserTypeResourcer) {
//            _bottomV.hidden=YES;
//            [_bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(0);
//            }];
//        }
//        else
//        {
//            _bottomV.hidden=NO;
//            [_bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(54);
//            }];
//        }
    }
    return _bottomV;
}
#pragma -mark ActorPriceListVCDelegate 报价新版页面回调代理
-(void)selectPrices:(NSArray *)prices andYear:(NSInteger)year andRegion:(NSInteger)region andYidi:(NSInteger)yidi andTotal_vip:(NSInteger)total_vip andTotalNormal:(NSInteger)totalNormal
{
//    NSMutableArray *modelArr = [NSMutableArray new];
//    for (AskCalendarPriceModel *akcM in prices) {
//        PriceModel_java *priM = [PriceModel_java new];
//        priM.days = akcM.day;
//        priM.advertType = akcM.type;
//        priM.singlePrice = akcM.price;
//        [modelArr addObject:priM];
//    }
    self.selectArray = prices;//[modelArr copy];
    self.orderYear = year;
    self.orderRegion = region;
    self.otherArea = yidi;
    self.total_vip = total_vip;
    self.total_normal = totalNormal;
    //不知道报价UI在哪一行 [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableV reloadData];
}
//个人详情
-(void)entryUserDetialInfo
{
    UserDetialInfoVC *infoVC=[[UserDetialInfoVC alloc]init];
    infoVC.info=self.dataM.info;
    [self.navigationController pushViewController:infoVC animated:YES];
}

#pragma mark--刷新头部视图
-(void)refreshHeadView
{
    self.topHeight=198;
    //报价一栏高度
    if ([UserInfoManager getUserType]!=UserTypeResourcer) {
        self.topHeight+=44;
    }
    
    //评分内容
    if (self.dataM.info.commentInfo!=nil) {
        self.topHeight+=44;
    }

    //vip申请一栏
    if ([UserInfoManager getUserType]==UserTypePurchaser&&([UserInfoManager getUserStatus]<=200&&[UserInfoManager getUserStatus]!=105)) {
        self.topHeight+=40;
    }
    
    
    //评价
    if (self.dataM.info.lastComment!=nil) {
        NSString *content = self.dataM.info.lastComment[@"content"];  //评价内容
        NSString *tags = self.dataM.info.lastComment[@"tags"];  //标签
        CGFloat contentHeight = [self heighOfString:content font:[UIFont systemFontOfSize:14] width:(UI_SCREEN_WIDTH-68)];
        CGFloat tagHeight =  [self heighOfString:tags font:[UIFont systemFontOfSize:14] width:(UI_SCREEN_WIDTH-84)];
        self.topHeight=self.topHeight+10+105+contentHeight+tagHeight;
    }

    self.headView.frame=CGRectMake(0,self.topHeight, UI_SCREEN_WIDTH,96);
    self.tableV.tableHeaderView=[self tableHeadV];
}

//vip申请
-(void)vipApplyfor
{
    if ([UserInfoManager getUserLoginType]) {
        [SVProgressHUD showImage:nil status:@"请先完成登录！"];
        return;
    }
    
    //未认证成功，跳到认证界面
    if ([UserInfoManager getUserAuthState]!=1) {
        [SVProgressHUD showImage:nil status:@"请先完成认证！"];
        return;
    }
    
    WeakSelf(self);
    VIPViewController *vip=[[VIPViewController alloc]init];
    vip.reloadUI = ^{
        [weakself.topV reloadUIWithInfo:weakself.dataM.info];
    };
    [self.navigationController pushViewController:vip animated:YES];
}

//查看报价
#pragma mark 此处是直接从底部弹出项目选择 ，用法和以前一样，类名OfferTypePopV3
-(void)lookUserPrice
{
  
    if ([UserInfoManager getUserLoginType]) {
        [SVProgressHUD showImage:nil status:@"登录后可查看报价！"];
        return;
    }
    
    //未认证成功，弹窗
    if (_info.unlockingPrice==NO) {
        NSDictionary *arg = @{
                                                            @"actorId":@(_info.actorId),
                                                            @"query":@(YES)
                                                            };
                                      [AFWebAPI_JAVA canLookPriceWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
                                          if (success) {
                                              NSDictionary *body = object[@"body"];
                                              NSString *message = body[@"message"];
                                              BOOL consultPrice = [body[@"consultPrice"] boolValue];
                                              //        弹窗
                                              UnAuthLookCountView *ualcv = [[UnAuthLookCountView alloc] init];
                                              ualcv.actionType = ^(NSString * _Nonnull type) {
                                                  if ([type isEqualToString:@"认证"]) {
                                                      AuthBuyerVC *authVC=[[AuthBuyerVC alloc]init];
                                                      authVC.hidesBottomBarWhenPushed=YES;
                                                      [self.navigationController pushViewController:authVC animated:YES];
                                                  }else if ([type isEqualToString:@"查看价格"]){
                                                  
                                                      NSDictionary *arg = @{
                                                                            @"actorId":@(_info.actorId),
                                                                            @"query":@(NO)
                                                                            };
                                                      [AFWebAPI_JAVA canLookPriceWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
                                                          NSLog(@"确认查看报价后的回调%@",object);
                                                          _info.unlockingPrice = YES;
                                                          self.dataM.info.unlockingPrice = YES;
                                                          [self.topV reloadUIWithInfo:self.dataM.info];
                                                          self.hadCheckUserPrice();
                                                          [self lookPrice2];
//                                                          [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:<#(NSInteger)#> inSection:<#(NSInteger)#>]] withRowAnimation:(UITableViewRowAnimationFade)];
                                                      }];

                                                  }
                              
                                              };
                                              [ualcv showWithString:message andCanLook:consultPrice];
                                          }
                                      }];
    }else{

    
    [self lookPrice2];
    }
    
//    WeakSelf(self);
//    UserInfoM *info = [[UserInfoM alloc]init];
//    info.UID = [NSString stringWithFormat:@"%ld",self.dataM.info.actorId];
//    NSInteger acotorId = [info.UID integerValue];
//    [SVProgressHUD showImage:nil status:@"正在读取报价信息"];
//    NSDictionary *dicArg = @{@"userId":@([[UserInfoManager getUserUID] integerValue]),
//                             @"actorId":@(acotorId)
//                             };
//    [AFWebAPI_JAVA getQuotaListWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
//        if (success) {
//            [SVProgressHUD dismiss];
//            NSDictionary *dic = [object objectForKey:JSON_body];
//            NSArray *prList = dic[@"quotationList"];
//            if (prList.count>0) {
//                UserLookPricePopV *popV = [[UserLookPricePopV alloc]init];
//                [popV showOfferTypeWithPriceList:prList withSelectDic:self.priceDic withDay:self.selectDay withMastery:self.dataM.info.mastery withType:0];
//                popV.typeSelectBlock = ^(NSDictionary * _Nonnull dic, NSInteger day) {
//                    weakself.priceDic=dic;
//                    weakself.selectDay=day;
//                    [weakself.topV reloadTopPriceUIWithDic:dic withDay:day];
//                };
//                popV.confrimActionBlock = ^(NSDictionary * _Nonnull dic, NSInteger day) {
//                    [weakself PlaceorderWithType:1];
//                };
//            }else{
//                [SVProgressHUD showImage:nil status:@"暂无报价！"];
//                return;
//            }
//    }}];

}
-(void)lookPrice2//这里才是真的查价格 前面排出未登录 未认证的问题
{
    if ([self.dataM.info.priceInfo[@"startPrice"] integerValue]==0) {
        AskPriceView *ap  = [[AskPriceView alloc] init];
        [ap showWithTitle:@"咨询价格" desc:@"此演员价格受拍摄日期，脚本影响较大，无固定价格。具体价格请拨打400-833-6969咨询脸探副导。" leftBtn:@"" rightBtn:@"" phoneNum:@"4008336969"];
        return;
    }
    ActorPriceListVC *apvc = [ActorPriceListVC new];
    apvc.hidesBottomBarWhenPushed = YES;
    apvc.actorId = self.dataM.info.actorId;
    apvc.projectId = @"";
    apvc.delegate = self;
    apvc.pushType = 1;
    if (_selectArray.count==0 || [_selectArray isKindOfClass:[NSNull class]]) {//没有选择项目
        
        apvc.selectArr = [NSArray new];
        apvc.year = 0;
        apvc.region = 0;
        apvc.yidi = 0;
        
    }else if (_selectArray.count>0){//已经选择了拍摄项目，
        apvc.selectArr = _selectArray;
        apvc.year = _orderYear;
        apvc.region = _orderRegion;
        apvc.yidi = _otherArea;
        
    }
    if (_isCheckPrice) {
        NSDictionary *arg = @{
                              @"actorId":@(_info.actorId),
                              @"query":@(NO)
                              };
        [AFWebAPI_JAVA canLookPriceWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            NSLog(@"确认查看报价后的回调%@",object);
        }];
    }
    [self.navigationController pushViewController:apvc animated:YES];
}
#pragma mark--UserHeaderVDelegate
//作品切换
-(void)clickWorkWithIndex:(NSInteger)index
{
    self.selectIndex=index;
    self.service.selectIndex=index;
    self.headView.typeViewArray=self.dataM.typeDataSource[self.selectIndex];
    [self.tableV reloadData];
    if (self.tableV.contentOffset.y>(self.topHeight-SafeAreaTopHeight)) {
        [self.tableV setContentOffset:CGPointMake(0, self.topHeight-SafeAreaTopHeight) animated:YES];
    }
    [_player destroyPlayer];
    _player=nil;
}

//类型切换
-(void)clickTypeViewWithIndex:(NSInteger)index
{
    NSArray *typeArr = self.dataM.typeDataSource[self.selectIndex];
    NSArray *array = self.dataM.ds[self.selectIndex];
    NSInteger type = 0;
    for (int i=0; i<array.count; i++) {
        UserWorkModel *model =array[i];
        if ([typeArr[index] isEqualToString:model.tag]) {
            type=i;
            break;
        }
    }
    [self.tableV setContentOffset:CGPointMake(0,self.topHeight-SafeAreaTopHeight + 208 *type) animated:YES];
}

//自动切换作品
-(void)autoSwitchWork
{
    //循环看该类型作品是否没有
    for (int i=0; i<self.dataM.ds.count; i++) {
        NSArray *array = self.dataM.ds[i];
        if (array.count) {
            self.selectIndex=i;
            break;
        }
    }
    
    if (self.dataM.info.mastery==3) {//外模切换到模特卡
        self.selectIndex=3;
    }
    [self.headView moveSlideWorkType:self.selectIndex];
}


#pragma mark ---UserServiceDelegate
//查看作品详情
-(void)lookWorkDetialWithIndex:(NSInteger)index
{
    NSArray *array = self.dataM.ds[self.selectIndex];
    //模特卡
    if (self.selectIndex==3) {
        [self lookPhotoWithArray:array WithIndex:index];
    }
    else  //其他作品
    {
        UserWorkModel *model = array[index];
        if (model.url.length==0) {  //图片
            [self lookPhotoWithArray:@[model] WithIndex:0];
        }
        else  //视频
        {
            [self playWorkVideoWithModel:model withIndex:index];
        }
    }
}

//查看图片大图
-(void)lookPhotoWithArray:(NSArray*)array WithIndex:(NSInteger)index
{
    NSMutableArray *dataS = [NSMutableArray new];
    for (int i=0; i<array.count; i++) {
        UserWorkModel *model = array[i];
        [dataS addObject:model.coverUrl];
        [self VideostatisticsWithWorkModel:model withType:1];
    }
    
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    [lookImage showWithImageArray:dataS curImgIndex:index AbsRect:CGRectMake(0, 0,0,0)];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {  //下载回掉
        [self VideostatisticsWithWorkModel:array[index] withType:2];
    };

}

//播放视频组
-(void)playWorkVideoWithModel:(UserWorkModel*)model withIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UserInfoCellC *cell = [self.tableV cellForRowAtIndexPath:indexPath];

    [_player destroyPlayer];
    _player = nil;
    
    _player = [[VideoPlayer alloc] init];
    _player.videoUrl =model.url;
 
    [_player playerBindTableView:self.tableV currentIndexPath:indexPath];
    _player.frame = CGRectMake(15,15, cell.contentView.bounds.size.width-30, cell.contentView.bounds.size.height-15);
    
    [cell.contentView addSubview:_player];
    
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

//下单
-(void)PlaceorderWithType:(NSInteger)type
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
    
    UserInfoM *info = [[UserInfoM alloc]init];
    info.UID = [NSString stringWithFormat:@"%ld",self.dataM.info.actorId];
    if (type==0) { //试镜
        PlaceAuditionOrderVC *auditVC = [[PlaceAuditionOrderVC alloc]init];
        auditVC.info=info;
        [self.navigationController pushViewController:auditVC animated:YES];
    }
    else if (type==1)
    {
        PlaceShotOrderVC *shotVC=[[PlaceShotOrderVC alloc]init];
        shotVC.info=info;
        if (self.priceDic!=nil) {
            shotVC.videoTypeDic=@{@"dic":self.priceDic,@"day":@(self.selectDay)};
        }
        [self.navigationController pushViewController:shotVC animated:YES];
    }
}


//table偏移
-(void)scrolloffY:(CGFloat)offY
{
    [_player playerScrollIsSupportSmallWindowPlay:NO];
    if(offY<144)
    {
        [self.navigationItem setTitleView:nil];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
        
        [self.collectBtn setImage:[UIImage imageNamed:@"u_info_collect_n"] forState:UIControlStateNormal];
        [self.collectBtn setImage:[UIImage imageNamed:@"u_info_collect_h"] forState:UIControlStateSelected];
        [self.praiseBtn setImage:[UIImage imageNamed:@"u_info_praise_n"] forState:UIControlStateNormal];
        [self.praiseBtn setImage:[UIImage imageNamed:@"u_info_praise_h"] forState:UIControlStateSelected];
        [self.shareBtn setImage:[UIImage imageNamed:@"u_info_share_n"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"u_info_share_n"] forState:UIControlStateSelected];
        [self.moreBtn setImage:[UIImage imageNamed:@"u_info_more_n"] forState:UIControlStateNormal];
        [self.moreBtn setImage:[UIImage imageNamed:@"u_info_more_n"] forState:UIControlStateSelected];
        
    }
    else
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:self.dataM.info.nickName]];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
        
        [self.collectBtn setImage:[UIImage imageNamed:@"u_info_collect_top_n"] forState:UIControlStateNormal];
        [self.collectBtn setImage:[UIImage imageNamed:@"u_info_collect_top_h"] forState:UIControlStateSelected];
        [self.praiseBtn setImage:[UIImage imageNamed:@"u_info_praise_top_n"] forState:UIControlStateNormal];
        [self.praiseBtn setImage:[UIImage imageNamed:@"u_info_praise_top_h"] forState:UIControlStateSelected];
        [self.shareBtn setImage:[UIImage imageNamed:@"u_info_share_h"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"u_info_share_h"] forState:UIControlStateSelected];
        [self.moreBtn setImage:[UIImage imageNamed:@"u_info_more_h"] forState:UIControlStateNormal];
        [self.moreBtn setImage:[UIImage imageNamed:@"u_info_more_h"] forState:UIControlStateSelected];
    }
    
    if(offY<self.topHeight-SafeAreaTopHeight)
    {
        self.headView.frame=CGRectMake(0,self.topHeight,UI_SCREEN_WIDTH,96);
        self.backTopBtn.hidden=YES;
    }
    else
    {
        self.headView.frame=CGRectMake(0,offY+SafeAreaTopHeight, UI_SCREEN_WIDTH, 96);
        self.backTopBtn.hidden=NO;
        
        NSInteger index = (int)(offY - (self.topHeight-SafeAreaTopHeight)) / 208;
        NSArray *typeArr = self.dataM.typeDataSource[self.selectIndex];
        NSArray *array = self.dataM.ds[self.selectIndex];
        
        if (index<array.count) {
            UserWorkModel *model =array[index];
            NSInteger type=0;
            for (int i=0; i<typeArr.count; i++) {
                if ([typeArr[i] isEqualToString:model.tag]) {
                    type=i;
                }
            }
            [self.headView moveSliderToPage:type];
        }
    }
    
    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc]initWithCustomView:self.moreBtn],[[UIBarButtonItem alloc]initWithCustomView:self.shareBtn]]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc]initWithCustomView:self.moreBtn],[[UIBarButtonItem alloc]initWithCustomView:self.shareBtn],[[UIBarButtonItem alloc]initWithCustomView:self.praiseBtn],[[UIBarButtonItem alloc]initWithCustomView:self.collectBtn]]];
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(offY/(144))>0.99?0.99:(offY /(144))]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    if (offY>0) {
        return;
    }
    [self.topV changeImageFrameWithOffY:offY];
    
}


#pragma mark --Action
//分享
-(void)shareAction
{
    SharePopV *pop=[[SharePopV alloc]init];
    WeakSelf(self);
    pop.shareBlock=^(NSInteger tag)
    {
        [ShareManager shareWithType:tag withUserInfo:self.dataM.info withViewControll:weakself];
    };
    
    [pop showBottomShare];
}

//收藏
-(void)collectionAction
{
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist)
    {
        [self goLogin];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dicArg= @{@"userId":[UserInfoManager getUserUID],
                            @"actorId":@(self.info.actorId),
                            @"operateType":@(!self.dataM.info.isCollect)};
    [AFWebAPI_JAVA setCollectionArtistWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            if (!self.dataM.info.isCollect) {
                [SVProgressHUD showImage:[UIImage imageNamed:@"collect_pur_h"] status:@"收藏成功"];
                self.dataM.info.isCollect=YES;
                self.dataM.info.collect+=1;
            }
            else
            {
                [SVProgressHUD showImage:nil status:@"取消收藏"];
                self.dataM.info.isCollect=NO;
                self.dataM.info.collect-=1;
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"collectArtist" object:nil];  //收藏/取消成功，通知刷新收藏页面

            self.collectBtn.selected=self.dataM.info.isCollect;
            [self.topV reloadUIWithInfo:self.dataM.info];
            [self.bottomV reloadUIWithInfo:self.dataM.info];
        }else{
            AF_SHOW_JAVA_ERROR
        }
        
    }];
}

//点赞
-(void)praiseAction
{
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist)
    {
        [self goLogin];
        return;
    }
    
    if (self.dataM.info.isPraise==YES) {
        [SVProgressHUD showImage:nil status:@"您已经点赞过了，无法重复点赞和取消哦"];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *dicArg= @{@"userId":[UserInfoManager getUserUID],
                            @"actorId":@(self.info.actorId),
                            @"operateType":@(!self.dataM.info.isPraise)};
    [AFWebAPI_JAVA getPraiseArtistWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showImage:[UIImage imageNamed:@"praise_pur_h"] status:@"点赞成功"];
            self.dataM.info.isPraise=YES;
            self.dataM.info.praise+=1;

            self.praiseBtn.selected=self.dataM.info.isPraise;
            [self.bottomV reloadUIWithInfo:self.dataM.info];

        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
        [self.topV reloadUIWithInfo:self.dataM.info];
    }];
}

//回到顶部
-(void)backToTopAction
{
    [self.tableV setContentOffset:CGPointMake(0, -SafeAreaTopHeight) animated:YES];
}

//评价内容文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
//    contentLab.lineSpacing = 5;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    if (ceilf(size.height)<60) {
        return ceilf(size.height);
    }
    else
    {
        return 60;
    }

}

@end
