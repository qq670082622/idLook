//
//  ActorTopListVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorTopListVC.h"
#import "ActorTopCell.h"
#import "ActorTopModel.h"
#import "ActorTopV.h"
#import "VideoPlayer.h"
@interface ActorTopListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    VideoPlayer *_player;
}
@property (weak, nonatomic) IBOutlet CustomTableV *tableV;
@property(nonatomic,assign)NSInteger topHeight;  //顶部高度
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)ActorTopV *topV;
@property(nonatomic,assign)NSInteger sortpage;

@end

@implementation ActorTopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    WeakSelf(self);
     [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
    BOOL isX = [UIApplication sharedApplication].statusBarFrame.size.height==20?NO:YES;
    if (isX) {
        _tableV.y-=25;
        _tableV.height+=30;
    }
    
 
    self.topHeight=200;
 ActorTopV *topv = [[ActorTopV alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, _topHeight)];
    topv.height = _topHeight;
    topv.selectPlat = ^(NSInteger plat) {
        [weakself refreshDataWithSortPage:_sortpage andPlatform:plat];
    };
    self.tableV.tableHeaderView = topv;
    self.topV = topv;
  [AFWebAPI_JAVA getPlatformListWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            topv.data = object[@"body"];
            NSArray *plats = object[@"body"];
            NSDictionary *firstPlats = plats[0];
            NSInteger platId = [[firstPlats objectForKey:@"id"]integerValue];
            [self refreshDataWithSortPage:_sortpage andPlatform:platId];
        }
    }];
    _data = [NSMutableArray new];
    _sortpage = 1;
    //[_tableV addFooterWithTarget:self action:@selector(pullUpToRefresh:)];
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
 }
-(void)pullUpToRefresh:(id)sender
{
 //[self refreshDataWithSortPage:_sortpage ];
}
-(void)refreshDataWithSortPage:(NSInteger)sortpage andPlatform:(NSInteger)platform
{
    NSDictionary *arg = @{
                          @"pageCount":@(100),
                          @"pageNumber":@(1),
                          @"source":@(platform)
                          };
    [AFWebAPI_JAVA getRangeListWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [self.data removeAllObjects];
            for (NSDictionary *platDic in object[@"body"]) {
                ActorTopModel *model = [ActorTopModel yy_modelWithDictionary:platDic];
                [self.data addObject:model];
            }
            [self.tableV reloadData];
}
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    self.navigationController.navigationBar.hidden = YES;
    ActorTopModel *model = _data[indexPath.row];
    _player = [[VideoPlayer alloc] init];
   _player.trillMode = YES;
    _player.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    _player.isMute=[UserInfoManager getListPlayIsMute];
    _player.videoUrl =model.videoUrl;
    [_player playerBindTableView:self.tableV currentIndexPath:indexPath];
    _player.playerLayer.masksToBounds=YES;
    _player.playerLayer.cornerRadius=5.0;
    _player.layer.masksToBounds=YES;
    _player.layer.cornerRadius=5.0;
    [self.view addSubview:_player];
    _player.completedPlayingBlock = ^(VideoPlayer *player) {
        [weakself endDeceleratingPlay];
    };

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActorTopCell *cell = [ActorTopCell cellWithTableView:tableView];
   
      cell.model = _data[indexPath.row];
   
   return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_data.count==0) {
        return 0;
    }else{
        return _data.count;
    }
   
    return 0;
}
//结束播放
-(void)endDeceleratingPlay
{
      self.navigationController.navigationBar.hidden = NO;
    [_player.player.currentItem cancelPendingSeeks];
    [_player.player.currentItem.asset cancelLoading];
    [_player destroyPlayer];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [_player removeFromSuperview];
    _player =nil;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self scrolloffY:scrollView.contentOffset.y];
    
}
//table偏移
-(void)scrolloffY:(CGFloat)offY
{
   
    if(offY<144)
    {
        [self.navigationItem setTitleView:nil];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
       
        
    }
    else
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"排行榜"]];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
     
    }
    
   
  
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(offY/(144))>0.99?0.99:(offY /(144))]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    if (offY>0) {
        return;
    }
   
    
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
