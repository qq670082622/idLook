//
//  VideoDetialVC.m
//  IDLook
//
//  Created by HYH on 2018/6/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoDetialVC.h"
#import "VideoPlayer.h"
#import "VideoDetialCellA.h"
#import "VideoDetialCellB.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"

@interface VideoDetialVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)CustomTableV *tableV;

@end

@implementation VideoDetialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftWhiteButtonWithTarget:self action:@selector(onGoback)]]];

    [self tableV];
//    [self initUI];

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
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
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
    
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    
    [_player destroyPlayer];
    _player = nil;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.scrollEnabled=NO;
        _tableV.pagingEnabled=NO;
        _tableV.backgroundColor=[UIColor clearColor];
        if ([UserInfoManager getUserType]==UserTypeResourcer) {
            _tableV.frame=CGRectMake(0,-64,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT+64);
        }
        else
        {
            _tableV.frame=CGRectMake(0,-64,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-50+64);
        }
    }
    return _tableV;
}


-(void)initUI
{
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

//下单
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

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
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
    if (indexPath.row==0) {
        return 250;
    }
    
    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        return (UI_SCREEN_HEIGHT-250-64+20);
    }
    else
    {
        return (UI_SCREEN_HEIGHT-250-64-50+20);
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *identifer = @"VideoDetialCellA";
        VideoDetialCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[VideoDetialCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        [cell reloadUIWithModel:self.model];
        return cell;
    }
    else
    {
        static NSString *identifer = @"VideoDetialCellB";
        VideoDetialCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[VideoDetialCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell reloadUIWithModel:self.model withCertUrl:self.model.microtype==1?self.info.authorization3:self.info.authorization4];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0)
    {
        [self showVideoPlayer:indexPath];
    }
}

- (void)showVideoPlayer:(NSIndexPath *)indexPath
{
    [_player destroyPlayer];
    _player = nil;
    
    UITableViewCell *cell = [self.tableV cellForRowAtIndexPath:indexPath];
    
    _player = [[VideoPlayer alloc] init];
    
    WorksModel *model =self.model;
    _player.videoUrl =model.url;
    
    [_player playerBindTableView:self.tableV currentIndexPath:indexPath];
    _player.frame = CGRectMake(0,0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height);
    
    [cell.contentView addSubview:_player];
    
    _player.completedPlayingBlock = ^(VideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
    _player.dowmLoadBlock = ^{};
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

@end