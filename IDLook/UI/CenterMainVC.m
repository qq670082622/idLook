//
//  CenterMainVC.m
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CenterMainVC.h"
#import "CenterOrderView.h"
#import "CenterMainCell.h"
#import "PersonalInfoVC.h"
#import "MyWorksVC.h"
#import "UserCenterVC.h"
#import "AssetsMainVC.h"
#import "PriceMainVC.h"
#import "MyCertificateVC.h"
#import "SettingMainVC.h"
#import "MyOrderMainVC.h"
#import "MyAuthStateVC.h"
#import "MyAuthSuccessVC.h"
#import "SystemMsgVC.h"
#import "PublicWebVC.h"
#import "AuthBuyerVC.h"
#import "AuthResourcerVC.h"
#import "SharePopV.h"
#import "ShareManager.h"
#import "ContactVC.h"
#import "AuthBuyerSelectPopV.h"
#import "MyProjectVC2.h"
#import "MyProjectVC.h"
#import "StoreViewController.h"
#import "PublishGradeViewController.h"
#import "VIPViewController.h"
#import "SubAccountVC.h"
#import "RoleServiceVC.h"
#import "CouponVC.h"
#import "MyInsuranceVC.h"
#import "CouponPopV.h"
#import "AnnunciateListVC.h"
#import "CheckGradeViewController.h"
#import "ReturnKeyShareVC.h"
#import "ProjectMainVC.h"
#import "CustomzOrderListVC.h"
@interface CenterMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView *bg;
@property (nonatomic,strong)UIImageView *head;
@property (nonatomic,strong)UILabel *nick;
@property (nonatomic,strong)UILabel *countLab;
@property (nonatomic,strong)UILabel *headState;
@property (nonatomic,strong)UIImageView *bottomV;
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong) UIImageView *vipImg;

@end

@implementation CenterMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;

   // [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self tableV];
    
    [self initUI];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    //设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(self.tableV.contentOffset.y / SafeAreaTopHeight)>0.99?0.99:(self.tableV.contentOffset.y /SafeAreaTopHeight)]] forBarMetrics:UIBarMetricsDefault];
//    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    //    如果不想让其他页面的导航栏变为透明 需要重置
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}

//设置
-(void)setting
{
    SettingMainVC *settingVC=[[SettingMainVC alloc]init];
    settingVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}

//系统消息
-(void)message
{
    SystemMsgVC *msgVC=[[SystemMsgVC alloc]init];
    msgVC.hidesBottomBarWhenPushed=YES;
    WeakSelf(self);
    msgVC.refreshUIBlock = ^{
        [weakself refreshUI];
    };
    [self.navigationController pushViewController:msgVC animated:YES];
}

//刷新ui
-(void)refreshUI
{
    NSString *headUrl;
    if ([UserInfoManager getUserHeadstatus]==1) {
        headUrl = [UserInfoManager getUserMiniaudit];
        self.headState.hidden=NO;
    }
    else
    {
        headUrl = [UserInfoManager getUserHead];
        self.headState.hidden=YES;
    }
    
    [self.head sd_setImageWithUrlStr:headUrl placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    if ([UserInfoManager getUnreadCount]==0) {
        self.countLab.hidden=YES;
    }
    else
    {
        self.countLab.hidden=NO;
        self.countLab.text=[NSString stringWithFormat:@"%ld",[UserInfoManager getUnreadCount]];
    }
 
    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        self.nick.text=[UserInfoManager getUserNick];
          self.vipImg.hidden = YES;
    }
    else
    {
        if ([UserInfoManager getUserSubType]==UserSubTypePurPersonal) {
            self.nick.text=[UserInfoManager getUserBuyerName];
        }
        else
        {
            self.nick.text=[UserInfoManager getUserCompanyName];
        }
          NSInteger state = [UserInfoManager getUserStatus];
        if (state>200) {
            self.vipImg.hidden = NO;
        }else{
            self.vipImg.hidden = YES;
        }
     
    }
    [self.tableV reloadData];
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,-UI_STATUS_BAR_HEIGHT,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT+UI_STATUS_BAR_HEIGHT) style:UITableViewStyleGrouped];
      
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
        _tableV.tableHeaderView = [self tableHeadV];
        _tableV.tableFooterView = [self tableFootV];
        [_tableV addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
    }
    return _tableV;
}

-(UIView*)tableHeadV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 307)];

    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 214)];
    imageV.image=[UIImage imageNamed:@"center_head_bg"];
    imageV.contentMode=UIViewContentModeScaleAspectFill;
    [bg addSubview:imageV];
    self.bg=imageV;
    
    CenterOrderView *orderView = [[CenterOrderView alloc]initWithFrame:CGRectMake(8,170,UI_SCREEN_WIDTH-16,138)];
    [bg addSubview:orderView];
    orderView.backgroundColor=[UIColor whiteColor];
    orderView.layer.cornerRadius=5.0;
    orderView.layer.shadowOffset = CGSizeMake(5, 5);
    orderView.layer.shadowOpacity = 0.8;
    orderView.layer.shadowColor = [[UIColor colorWithHexString:@"#BAA6A6"] colorWithAlphaComponent:1.0].CGColor;
    [orderView layoutIfNeeded];
    WeakSelf(self);
    orderView.orderClickTypeBlock = ^(NSInteger type) {
        MyOrderMainVC *order = [[MyOrderMainVC alloc]init];
        order.currIndex=type;
        order.hidesBottomBarWhenPushed=YES;
        [weakself.navigationController pushViewController:order animated:YES];
    };

    UIImageView *headV = [[UIImageView alloc]init];
    headV.userInteractionEnabled=YES;
    headV.layer.masksToBounds=YES;
    headV.layer.cornerRadius=33;
    headV.clipsToBounds=YES;
    headV.backgroundColor=[UIColor grayColor];
    headV.contentMode=UIViewContentModeScaleAspectFill;
    [bg addSubview:headV];
    [headV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(35);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHead)];
    [headV addGestureRecognizer:tap];
    self.head=headV;
    
    UILabel *headState= [[UILabel alloc]init];
    headState.font=[UIFont systemFontOfSize:12.0];
    headState.textColor=[UIColor whiteColor];
    headState.text=@"审核中";
    headState.textAlignment=NSTextAlignmentCenter;
    headState.backgroundColor=[[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.6];
    [headV addSubview:headState];
    [headState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headV);
        make.bottom.mas_equalTo(headV.mas_bottom);
        make.left.mas_equalTo(headV);
        make.height.mas_equalTo(25);
    }];
    self.headState=headState;
    
    UILabel *nameLab= [[UILabel alloc]init];
    nameLab.font=[UIFont systemFontOfSize:17.0];
    nameLab.textColor=[UIColor colorWithHexString:@"#FFFFFF"];
    [bg addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(headV.mas_bottom).offset(15);
    }];
    self.nick=nameLab;
    
    UIImageView *vipImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_vipuser"]];
    [bg addSubview:vipImg];
    [vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLab);
        make.left.mas_equalTo(nameLab.mas_right).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(14);
    }];
    self.vipImg = vipImg;
    
    UILabel *useridLab= [[UILabel alloc]init];
    useridLab.font=[UIFont systemFontOfSize:12.0];
    useridLab.textColor=[[UIColor colorWithHexString:@"#FFFFFF"] colorWithAlphaComponent:0.8];
    useridLab.text= [NSString stringWithFormat:@"脸探肖像ID：%@",[UserInfoManager getUserUID]];
    [bg addSubview:useridLab];
    [useridLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(nameLab.mas_bottom).offset(12);
    }];
    
    [self refreshUI];
    
    return bg;
}

-(UIView*)tableFootV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [bg addSubview:button];
    [button setTitle:@"客服电话：400-833-6969" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#47AEFF"] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:13];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.centerY.mas_equalTo(bg);
    }];
    [button addTarget:self action:@selector(TakePhoneAction) forControlEvents:UIControlEventTouchUpInside];
    return bg;
}

//打电话
-(void)TakePhoneAction
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
}

-(void)pullDownToRefresh:(id)sender
{
    
    //用户更新版本，而老版本没有token会导致鉴权失败，所以启动时获取token
    NSDictionary *param = @{@"userId":[UserInfoManager getUserUID]};
    [AFWebAPI_JAVA getCenterNewDataWithArg:param callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            UserInfoM *uinfo = [[UserInfoM alloc] initJavaDataWithDic:[object objectForKey:JSON_body]];
            [UserInfoManager setUserStatus:uinfo.status];
            [UserInfoManager setUserDiscount:uinfo.discount];
        }
    }];
    
    
    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                             @"usertype":@([UserInfoManager getUserType])
                             };
    
//    [AFWebAPI_JAVA getCenterNewDataWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
//        if (success) {
//            NSDictionary *dic = [object objectForKey:JSON_body];
//
//            UserInfoM *uinfo = [[UserInfoM alloc] initJavaDataWithDic:dic];
//
//            [UserInfoManager setUserLoginfo:uinfo];
//            [UserInfoManager setUserLoginType:UserLoginTypeMobile];
//        }
//        else
//        {
//            AF_SHOW_JAVA_ERROR
//        }
//        [self.tableV headerEndRefreshing];
//    }];
//
//    return;
    [AFWebAPI getCenterNewDataWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            
            NSDictionary *dic = [object objectForKey:JSON_data];
            UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
            
            [UserInfoManager setUserLoginfo:uinfo];
            [UserInfoManager setUserLoginType:UserLoginTypeMobile];

            [self refreshUI];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
        [self.tableV headerEndRefreshing];
    }];
}

-(void)initUI
{
    UIButton *messageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:messageBtn];
    [messageBtn setImage:[UIImage imageNamed:@"center_message"] forState:UIControlStateNormal];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(33);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [messageBtn addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *settingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:settingBtn];
    [settingBtn setImage:[UIImage imageNamed:@"center_setting"] forState:UIControlStateNormal];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(33);
        make.right.mas_equalTo(messageBtn.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [settingBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *countLab= [[UILabel alloc]init];
    countLab.font=[UIFont systemFontOfSize:8.0];
    countLab.backgroundColor=[UIColor whiteColor];
    countLab.layer.masksToBounds=YES;
    countLab.layer.cornerRadius=6.0;
    countLab.textAlignment=NSTextAlignmentCenter;
    countLab.textColor=Public_Red_Color;
    countLab.text=[NSString stringWithFormat:@"%ld",[UserInfoManager getUnreadCount]];
    [self.view addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(messageBtn.mas_right).offset(-5);
        make.top.mas_equalTo(messageBtn.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    self.countLab=countLab;
    if ([UserInfoManager getUnreadCount]==0) {
        self.countLab.hidden=YES;
    }
    
    UIImageView *bottmV= [[UIImageView alloc]init];
    bottmV.image=[UIImage imageNamed:@"center_bottom"];
    [self.view addSubview:bottmV];
    bottmV.hidden=YES;
    bottmV.userInteractionEnabled=YES;
    [bottmV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(20);
    }];
    self.bottomV=bottmV;
    
    UIImageView *icon1= [[UIImageView alloc]init];
    icon1.image=[UIImage imageNamed:@"center_prompt_01"];
    [bottmV addSubview:icon1];
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottmV).offset(27);
        make.left.mas_equalTo(bottmV).offset(30);
    }];
    
    UILabel *lab= [[UILabel alloc]init];
    lab.font=[UIFont systemFontOfSize:14];
    lab.textColor=[UIColor whiteColor];
    lab.text=@"您还没有实名认证，赶快去认证吧。";
    [bottmV addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon1);
        make.left.mas_equalTo(icon1.mas_right).offset(6);
    }];
    
    UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [bottmV addSubview:closeBtn];
    [closeBtn setImage:[UIImage imageNamed:@"center_close"] forState:UIControlStateNormal];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon1);
        make.right.mas_equalTo(bottmV).offset(-30);
    }];
    [closeBtn addTarget:self action:@selector(closeBottom) forControlEvents:UIControlEventTouchUpInside];
    
    if ([UserInfoManager getUserType]==UserTypeResourcer && [UserInfoManager getUserAuthState]==0) {
        if ([UserInfoManager getAuthBottom]==YES) {
            self.bottomV.hidden=NO;
        }
    }
}

-(void)closeBottom
{
    self.bottomV.hidden=YES;
    [UserInfoManager setAuthBottomShow:NO];
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UserInfoManager getUserType]==UserTypePurchaser) {
        return 255;//180;
    }
    return 255;//170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"CenterMainCell";
    CenterMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[CenterMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    __weak __typeof(self)ws=self;
    cell.CenterMainCellBlock = ^(NSInteger type) {
        [ws clcikWithType:type];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self jugeAlpha];
    float offsetY = self.tableV.contentOffset.y;
    CGFloat offsetH = -SafeAreaTopHeight- offsetY;
    
    if (offsetH < 0) return;
    
}

//table偏移
-(void)jugeAlpha
{
    float offsetY = self.tableV.contentOffset.y;
    if (offsetY<=(-UI_STATUS_BAR_HEIGHT))
    {
        self.bg.frame=CGRectMake(0,offsetY+UI_STATUS_BAR_HEIGHT,UI_SCREEN_WIDTH,214-UI_STATUS_BAR_HEIGHT-offsetY);
    }
    else
    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    }
}

-(void)clickHead
{
    PersonalInfoVC *VC=[[PersonalInfoVC alloc]init];
    VC.hidesBottomBarWhenPushed=YES;
    WeakSelf(self);
    VC.EditInfosBlock = ^{
        [weakself refreshUI];
    };
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)clcikWithType:(NSInteger)type
{
     WeakSelf(self);
    //个人中心
    if (type==CenterMainTypePersonal) {
        UserCenterVC *VC=[[UserCenterVC alloc]init];
        VC.hidesBottomBarWhenPushed=YES;
       VC.saveRefreshUI = ^{
            [weakself refreshUI];
        };
        [self.navigationController pushViewController:VC animated:YES];
    }
    //我的项目
    if (type==CenterMainTypeMyProject) {
        MyProjectVC2 *VC=[[MyProjectVC2 alloc]init];
        VC.hidesBottomBarWhenPushed=YES;
      [self.navigationController pushViewController:VC animated:YES];
    }
    //我的vip
    else if (type==CenterMainTypeVIP)
    {
      NSDictionary *dic = @{
                @"action":@"vipPage",
                @"userId":@([[UserInfoManager getUserUID] integerValue]),
                @"userType":@(1)
                };
        [AFWebAPI_JAVA staticsWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSLog(@"-----------obj is %@ ----------",object);
            }
        }];
        VIPViewController *vip=[[VIPViewController alloc]init];
        vip.hidesBottomBarWhenPushed=YES;
        vip.reloadUI = ^{
             [weakself refreshUI];
        };
       [self.navigationController pushViewController:vip animated:YES];
    }
    //我的作品
    else if (type==CenterMainTypeWorksUpload)
    {
        MyWorksVC *workVC=[[MyWorksVC alloc]init];
        workVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:workVC animated:YES];
    }
    
    //资产管理
    else if (type==CenterMainTypeAssets)
    {
        AssetsMainVC *VC=[[AssetsMainVC alloc]init];
        VC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    //报价管理
    else if (type==CenterMainTypePrice)
    {
        PriceMainVC *VC=[[PriceMainVC alloc]init];
        VC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    //我的认证
    else if (type==CenterMainTypeAuth)
    {
        [self authAction];
    }
    else if (type==CenterMainTypeMyProject)
    {
    //    [self projectAction];
    }
    //我的授权书
    else if (type==CenterMainTypeCertificate)
    {
        MyCertificateVC *VC=[[MyCertificateVC alloc]init];
        VC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    //联系脸探肖像
    else if (type==CenterMainTypeContact)
    {
        ContactVC *contactVC = [[ContactVC alloc] init];
        contactVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:contactVC animated:YES];
    }
    
    //脸探攻略
    else if (type==CenterMainTypeStrategy)
    {
        NSString *url = @"";
        if ([UserInfoManager getUserType]==UserTypePurchaser) {
            url=@"http://www.idlook.com/public/purchaser-help/html/index.html";
        }
        else if ([UserInfoManager getUserType]==UserTypeResourcer)
        {
            url=@"http://www.idlook.com/public/performer-help/html/index.html";
        }
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"脸探攻略" url:url];
        webVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    //分享脸探
    else if (type==CenterMainTypeShare)
    {
        SharePopV *pop=[[SharePopV alloc]init];
        WeakSelf(self);
        pop.shareBlock=^(NSInteger tag)
        {
            [ShareManager shareAppWithType:tag withViewControll:weakself];
        };
        
        [pop showBottomShare];
    }
    //项目管理
    else if (type==CenterMainTypeProjectManage)
    {
        ProjectMainVC *pmvc = [ProjectMainVC new];
        pmvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pmvc animated:YES];
    }
    else if (type==CenterMainTypeCustomizedOrders)
    {
        CustomzOrderListVC *listVC = [CustomzOrderListVC new];
        listVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVC animated:YES];
    }
    //积分商城
    else if (type==CenterMainTypeStore)
    {
        StoreViewController *store=[[StoreViewController alloc]init];
        store.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:store animated:YES];
    }
    //工作室
    else if (type==CenterMainTypeStudio)
    {
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"个人工作室" url:[NSString stringWithFormat: @"http://www.idlook.com/public/studio-reg/html/index.html?artistid=%@",[UserInfoManager getUserUID]]];
        webVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    //子账号管理
    else if (type==CenterMainTypeSubAccounts)
    {
        SubAccountVC *accountVC=[[SubAccountVC alloc]init];
        accountVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    //选角服务
    else if (type==CenterMainTypeRole)
    {
        RoleServiceVC *auditionVC = [[RoleServiceVC alloc]init];
        auditionVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:auditionVC animated:YES];
    }
    //优惠券
    else if (type==CenterMainTypeCoupon)
    {
        if ([UserInfoManager getPopupCoupon]) {  //是否弹出说明窗
            CouponPopV *popV=[[CouponPopV alloc]init];
            [popV show];
            popV.convertBlock = ^{
                CouponVC *couponVC = [[CouponVC alloc]init];
                couponVC.hidesBottomBarWhenPushed=YES;
                [weakself.navigationController pushViewController:couponVC animated:YES];
            };
        }
        else
        {
            CouponVC *couponVC = [[CouponVC alloc]init];
            couponVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:couponVC animated:YES];
        }
    }
    else if (type==CenterMainTypeReturnShare)//返现码分享
    {
        ReturnKeyShareVC *rv = [ReturnKeyShareVC new];
        rv.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:rv animated:YES];
    }
    else if (type==CenterMainTypeGrade){
        CheckGradeViewController *check = [CheckGradeViewController new];
        check.hidesBottomBarWhenPushed = YES;
        check.isMy = YES;
        [self.navigationController pushViewController:check animated:YES];
    }
    //我的保险
    else if (type==CenterMainTypeInsurance)
    {
        MyInsuranceVC *inVC = [MyInsuranceVC new];
        inVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:inVC animated:YES];
    }
    //通告
    else if (type==CenterMainTypeAnnunciate)
    {
        AnnunciateListVC *annunciateVC= [[AnnunciateListVC alloc]init];
        annunciateVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:annunciateVC animated:YES];
    }
}

//去认证
-(void)goAuth
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"去认证" message:@"您的身份还未进行认证，去认证吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"去认证"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self authAction];
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}

-(void)authAction
{
//    //购买方认证
//    AuthResourcerVC *buyVC = [[AuthResourcerVC alloc]init];
//    buyVC.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:buyVC animated:YES];
//    return;
    
    if ([UserInfoManager getUserAuthState]==0) {
        
        if ([UserInfoManager getUserType]==UserTypeResourcer) {
            AuthResourcerVC *authVC=[[AuthResourcerVC alloc]init];
            authVC.hidesBottomBarWhenPushed=YES;
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
    else if ([UserInfoManager getUserAuthState]==2 || [UserInfoManager getUserAuthState]==3)
    {
        MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
        stateVC.authState=[UserInfoManager getUserAuthState];
        stateVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:stateVC animated:YES];
    }
    else if ([UserInfoManager getUserAuthState]==1)
    {
        MyAuthSuccessVC *successVC=[[MyAuthSuccessVC alloc]init];
        successVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:successVC animated:YES];
    }
}

@end
