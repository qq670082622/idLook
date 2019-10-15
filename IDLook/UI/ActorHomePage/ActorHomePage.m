//
//  ActorHomePage.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/19.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorHomePage.h"
#import "ActorHomePageTopV.h"
#import "VideoPlayer.h"
#import "UserInfoCellC.h"
#import "UserWorkModel.h"
#import "ReportUserVC.h"
#import "SharePopV.h"
#import "ShareManager.h"
#import "PublishGradeViewController.h"
#import "ActorOrderVC.h"
#import "NoDataFootV.h"
#import "UserDetialInfoVC.h"
#import "ActorGradesVC.h"
#import "ChatVC.h"
@interface ActorHomePage ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    VideoPlayer *_player;
}
@property (weak, nonatomic) IBOutlet CustomTableV *tableV;
@property(nonatomic,strong)UIButton *collectBtn;    //收藏按钮
@property(nonatomic,strong)UIButton *praiseBtn;    //点赞按钮
@property(nonatomic,strong)UIButton *moreBtn;    //更多按钮
@property(nonatomic,strong)UIButton *shareBtn;    //分享按钮
@property (weak, nonatomic) IBOutlet UIView *bottmView;
- (IBAction)kefu:(id)sender;
- (IBAction)pingjia:(id)sender;
- (IBAction)order:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property(nonatomic,assign)NSInteger selectIndex;   //当前类型 视频还是摩卡
@property(nonatomic,copy)NSString *selectType;//里面子类型
@property(nonatomic,strong)UIButton *backTopBtn;    //回到顶部
@property(nonatomic,assign)NSInteger topHeight;  //顶部高度
@property(nonatomic,strong)ActorHomePageTopV *topV;

@property(nonatomic,strong)NSDictionary *typeVideoDic;
@property(nonatomic,strong)NSDictionary *videoDic;
@property(nonatomic,strong)NSDictionary *modelCardDic;

@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (weak, nonatomic) IBOutlet UILabel *typeVideoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *modelCardLabel;

- (IBAction)typeVideoAction:(id)sender;
- (IBAction)videoAction:(id)sender;
- (IBAction)modelCardAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIScrollView *typeScroll;

@end

@implementation ActorHomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf(self);
//    self.orderBtn.layer.cornerRadius = 6;
//    self.orderBtn.layer.masksToBounds = YES;
    self.typeVideoTitle.text = [NSString stringWithFormat:@"%@视频",_searchTag];
    if (!_searchTag) {
        self.typeVideoTitle.text = @"全部视频";
        _searchTag = @"";
    }
    _videoDic = [NSDictionary new];
    _modelCardDic = [NSDictionary new];
    _typeVideoDic = [NSDictionary new];
    self.line.center = CGPointMake(_typeVideoTitle.center.x, 45);

    if (public_isX) {
       _tableV.height-=15;
        _bottmView.y-=15;
    }
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
    self.selectIndex=0;
     [self backTopBtn];
    self.topHeight=418;//359
  
    self.topV = [[ActorHomePageTopV alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, _topHeight)];
    _topV.introDetail = ^{
        UserDetialInfoVC *infoVC=[[UserDetialInfoVC alloc]init];
        infoVC.info=weakself.userModel;
        [weakself.navigationController pushViewController:infoVC animated:YES];
    };
    _topV.checkGrade = ^{
        ActorGradesVC *gradeVC = [[ActorGradesVC alloc]init];
        gradeVC.actorId=weakself.userModel.actorId;
        [weakself.navigationController pushViewController:gradeVC animated:YES];
    };
    NSDictionary *arg = @{
                          @"actorId":@(_actorId),
                          @"userId":@([[UserInfoManager getUserUID] integerValue]),
                          @"tags":[NSArray arrayWithObject:_searchTag]
                          };
    [AFWebAPI_JAVA getActorInfoWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *body = object[@"body"];
            UserDetialInfoM *model = [[UserDetialInfoM alloc]initWithDic:body];;
            _userModel = model;
            _topV.model = _userModel;
              _topV.height =  _topV.topVHei;
            if (model.isCollect) {
                [_collectBtn setSelected:YES];
            }
            if (model.isPraise) {
                [_praiseBtn setSelected:YES];
            }
            self.tableV.tableHeaderView = _topV;
            NSArray *workList = body[@"worksList"];
            for (NSDictionary *workDic in workList) {
                NSString *workType = workDic[@"workType"];
                if ([workType isEqualToString:@"模特卡"]) {
                    self.modelCardDic = workDic;
                }else if ([workType isEqualToString:@"其他视频"]){
                    self.videoDic = workDic;
                    if ([_typeVideoTitle.text isEqualToString:@"全部视频"]) {
                          self.typeVideoDic = workDic;
                    }
                }else if ([workType isEqualToString:_typeVideoTitle.text]){
                    self.typeVideoDic = workDic;
                }
            }
            NSArray *taglist = _typeVideoDic[@"tagList"];
            for(int i = 0;i<taglist.count;i++){
                NSString *type = taglist[i];
                UIButton *typebtn = [UIButton buttonWithType:0];
                [typebtn setTitle:type forState:0];
                typebtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [typebtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:0];
                if (i==0) {
                    [typebtn setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
                     [typebtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
                    typebtn.layer.cornerRadius = 14;
                    typebtn.layer.masksToBounds = YES;
                    _selectType = type;
                }
                //CGFloat mergin = 4;
                CGFloat x = 15+(59+4)*i;
                typebtn.frame = CGRectMake(x, 11, 59, 28);
                [typebtn addTarget:self action:@selector(typeSelect:) forControlEvents:UIControlEventTouchUpInside];
                [typebtn setTag:i+100];
                [self.typeScroll addSubview:typebtn];
                self.typeScroll.contentSize = CGSizeMake(typebtn.right+20, 50);
            }
            [self.tableV reloadData];
        }
    }];
  
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
//type按钮点击了
-(void)typeSelect:(id)sender
{
    UIButton *typeBtn = (UIButton *)sender;
    NSString *btnTitle = typeBtn.titleLabel.text;
    if ([_selectType isEqualToString:btnTitle]) {
        return;
    }
    //改scroll里的UI
    for (UIButton *tyBtn in _typeScroll.subviews) {
        if (![tyBtn isKindOfClass:[UIButton class]]) {
            continue;//scroll里可能不止button
        }
        if ([tyBtn.titleLabel.text isEqualToString:btnTitle]) {
            [tyBtn setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
            [tyBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
            tyBtn.layer.cornerRadius = 14;
            tyBtn.layer.masksToBounds = YES;
            _selectType = btnTitle;
        }else{
            tyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [tyBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:0];
            [tyBtn setBackgroundColor:[UIColor whiteColor]];
        }
    }
    //改cell的offset
    NSMutableArray *listMu = [NSMutableArray new];
    if (_selectIndex==0) {//视频
        NSArray *videoList = _videoDic[@"videoList"];
        for (NSDictionary *videoDic in videoList) {
            UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
            [listMu addObject:workModel];
        }
    }else if (_selectIndex==1){//模特卡
        NSArray *videoList = _modelCardDic[@"videoList"];
        for (NSDictionary *videoDic in videoList) {
            UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
            [listMu addObject:workModel];
        }
    }
    for(int i =0;i<listMu.count;i++){
        UserWorkModel *workModel = listMu[i];
        if ([workModel.tag isEqualToString:_selectType]) {
//            if (i==0) {
//
//                _tableV.contentOffset = CGPointMake(0,100);
//            }else{
            [self.tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//            }
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSMutableArray *listMu = [NSMutableArray new];
    if (_selectIndex==0) {//分类视频
        NSArray *videoList = _typeVideoDic[@"videoList"];
       for (NSDictionary *videoDic in videoList) {
            UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
            [listMu addObject:workModel];
        }
    }else if (_selectIndex==1){//其他视频
       NSArray *videoList = _videoDic[@"videoList"];
             for (NSDictionary *videoDic in videoList) {
                  UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                  [listMu addObject:workModel];
              }
    }else if (_selectIndex==2)//摩卡
    {
        NSArray *videoList = _modelCardDic[@"videoList"];
               for (NSDictionary *videoDic in videoList) {
                   UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                   [listMu addObject:workModel];
               }
    }
    UserInfoCellC *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell = [[UserInfoCellC alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"reuseIdentifier"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell reloadUIWithWorksModel:listMu[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 96;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *listMu = [NSMutableArray new];
    if (_selectIndex==0) {//分类视频
           NSArray *videoList = _typeVideoDic[@"videoList"];
          for (NSDictionary *videoDic in videoList) {
               UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
               [listMu addObject:workModel];
           }
       }else if (_selectIndex==1){//其他视频
          NSArray *videoList = _videoDic[@"videoList"];
                for (NSDictionary *videoDic in videoList) {
                     UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                     [listMu addObject:workModel];
                 }
       }else if (_selectIndex==2)//摩卡
       {
           NSArray *videoList = _modelCardDic[@"videoList"];
                  for (NSDictionary *videoDic in videoList) {
                      UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                      [listMu addObject:workModel];
                  }
       }
    if (listMu.count) {
        return listMu.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 208;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _sectionView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSMutableArray *listMu = [NSMutableArray new];
    if (_selectIndex==0) {//分类视频
           NSArray *videoList = _typeVideoDic[@"videoList"];
          for (NSDictionary *videoDic in videoList) {
               UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
               [listMu addObject:workModel];
           }
       }else if (_selectIndex==1){//其他视频
          NSArray *videoList = _videoDic[@"videoList"];
                for (NSDictionary *videoDic in videoList) {
                     UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                     [listMu addObject:workModel];
                 }
       }else if (_selectIndex==2)//摩卡
       {
           NSArray *videoList = _modelCardDic[@"videoList"];
                  for (NSDictionary *videoDic in videoList) {
                      UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                      [listMu addObject:workModel];
                  }
       }
    if (listMu.count==0) {
        static NSString *identifer = @"UITableViewHeaderFooterView";
        NoDataFootV *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
        if(!footerView)
        {
            footerView = [[NoDataFootV alloc] initWithReuseIdentifier:identifer];
            [footerView.backgroundView setBackgroundColor:[UIColor clearColor]];
        }
        [footerView reloadUI];
        return footerView;
    }
//    else{
//        UIView *footer = [UIView new];
//        footer.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
//        footer.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 207);
//        return footer;
//    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSMutableArray *listMu = [NSMutableArray new];
    if (_selectIndex==0) {//分类视频
           NSArray *videoList = _typeVideoDic[@"videoList"];
          for (NSDictionary *videoDic in videoList) {
               UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
               [listMu addObject:workModel];
           }
       }else if (_selectIndex==1){//其他视频
          NSArray *videoList = _videoDic[@"videoList"];
                for (NSDictionary *videoDic in videoList) {
                     UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                     [listMu addObject:workModel];
                 }
       }else if (_selectIndex==2)//摩卡
       {
           NSArray *videoList = _modelCardDic[@"videoList"];
                  for (NSDictionary *videoDic in videoList) {
                      UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                      [listMu addObject:workModel];
                  }
       }
   if(listMu.count==0) {
        if ([UserInfoManager getUserType]==UserTypePurchaser) {
            return (UI_SCREEN_HEIGHT-50-SafeAreaTopHeight-SafeAreaTabBarHeight_IphoneX-96);
        }
        else
        {
            return  (UI_SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaTabBarHeight_IphoneX-96);
        }
   }
//   else{
//       return 207;
//   }
    return .1f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *listMu = [NSMutableArray new];
    if (_selectIndex==0) {//标签视频视频
       NSArray *videoList = _typeVideoDic[@"videoList"];
                    for (NSDictionary *videoDic in videoList) {
                        UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                        [listMu addObject:workModel];
                    }
                    UserWorkModel *selectModel = listMu[indexPath.row];
                      [self playWorkVideoWithModel:selectModel withIndex:indexPath.row];
   
    }else if (_selectIndex==1){//其他视频
        NSArray *videoList = _videoDic[@"videoList"];
               for (NSDictionary *videoDic in videoList) {
                   UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
                   [listMu addObject:workModel];
               }
               UserWorkModel *selectModel = listMu[indexPath.row];
                 [self playWorkVideoWithModel:selectModel withIndex:indexPath.row];
       
    }else if (_selectIndex==2){//模特卡
        NSArray *videoList = _modelCardDic[@"videoList"];
        for (NSDictionary *videoDic in videoList) {
            UserWorkModel *workModel = [UserWorkModel yy_modelWithDictionary:videoDic];
            [listMu addObject:workModel];
        }
          [self lookPhotoWithArray:listMu WithIndex:indexPath.row];
    }
  
 
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
      
    };
    
  
}
//查看图片大图
-(void)lookPhotoWithArray:(NSArray*)array WithIndex:(NSInteger)index
{
    NSMutableArray *dataS = [NSMutableArray new];
    for (int i=0; i<array.count; i++) {
        UserWorkModel *model = array[i];
        [dataS addObject:model.coverUrl];
       }
    
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    [lookImage showWithImageArray:dataS curImgIndex:index AbsRect:CGRectMake(0, 0,0,0)];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {  //下载回掉
       
    };
    
}
//table偏移
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
      CGFloat offY = scrollView.contentOffset.y;
    [_player playerScrollIsSupportSmallWindowPlay:NO];
    if(offY<124)
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
        self.backTopBtn.hidden = YES;
    }
    else
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:self.userModel.nickName]];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
        
        [self.collectBtn setImage:[UIImage imageNamed:@"u_info_collect_top_n"] forState:UIControlStateNormal];
        [self.collectBtn setImage:[UIImage imageNamed:@"u_info_collect_top_h"] forState:UIControlStateSelected];
        [self.praiseBtn setImage:[UIImage imageNamed:@"u_info_praise_top_n"] forState:UIControlStateNormal];
        [self.praiseBtn setImage:[UIImage imageNamed:@"u_info_praise_top_h"] forState:UIControlStateSelected];
        [self.shareBtn setImage:[UIImage imageNamed:@"u_info_share_h"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"u_info_share_h"] forState:UIControlStateSelected];
        [self.moreBtn setImage:[UIImage imageNamed:@"u_info_more_h"] forState:UIControlStateNormal];
        [self.moreBtn setImage:[UIImage imageNamed:@"u_info_more_h"] forState:UIControlStateSelected];
        self.backTopBtn.hidden = NO;
    }
    
   
    
    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc]initWithCustomView:self.moreBtn],[[UIBarButtonItem alloc]initWithCustomView:self.shareBtn]]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc]initWithCustomView:self.moreBtn],[[UIBarButtonItem alloc]initWithCustomView:self.shareBtn],[[UIBarButtonItem alloc]initWithCustomView:self.praiseBtn],[[UIBarButtonItem alloc]initWithCustomView:self.collectBtn]]];
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(offY/(124))>0.99?0.99:(offY /(124))]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
  
    //    [self.topV changeImageFrameWithOffY:offY];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView//自动停止滚动
{
    [self scrollEndScrollWithOffY:scrollView.contentOffset.y];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate//手动停止滚动
{
    [self scrollEndScrollWithOffY:scrollView.contentOffset.y];
}
-(void)scrollEndScrollWithOffY:(CGFloat)offY
{
    NSLog(@"%f",offY);//cell=208
    
    NSInteger passCount = (offY-481)/208;
    passCount++;
    //快要显示哪个cell，对应的scroll里的小按钮就被选中
    for (UIButton *tyBtn in _typeScroll.subviews) {
        if (![tyBtn isKindOfClass:[UIButton class]]) {
            continue;//scroll里可能不止button
        }
        
        NSLog(@"btn.tag is %ld,滚动到第%ld个",tyBtn.tag,passCount);
        if (tyBtn.tag-100==passCount) {
            [tyBtn setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
            [tyBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
            tyBtn.layer.cornerRadius = 14;
            tyBtn.layer.masksToBounds = YES;
            
        }else{
            tyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [tyBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:0];
            [tyBtn setBackgroundColor:[UIColor whiteColor]];
        }
    }
    if (offY>0) {
        return;
    }
    
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
//        if (self.bottomV.hidden==YES) {
//            originY=UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-70;
//        }
//        else
//        {
            originY=UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-70-54;
//        }
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
-(void)backToTopAction
{
   [self.tableV setContentOffset:CGPointMake(0,-SafeAreaTopHeight) animated:YES];
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)typeVideoAction:(id)sender {
    [_player destroyPlayer];
       _player=nil;
       [UIView animateWithDuration:0.3 animations:^{
           self.line.center = CGPointMake(_typeVideoTitle.center.x,45);
       }];
       _selectIndex = 0;
    _typeVideoTitle.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
       self.videoTitle.font = [UIFont systemFontOfSize:15];
       self.modelCardLabel.font = [UIFont systemFontOfSize:15];
       [self changeScrollTags];
       [self.tableV reloadData];
}

- (IBAction)videoAction:(id)sender {
    [_player destroyPlayer];
    _player=nil;
    [UIView animateWithDuration:0.3 animations:^{
        self.line.center = CGPointMake(_videoTitle.center.x,45);
    }];
    _selectIndex = 1;
    self.typeVideoTitle.font = [UIFont systemFontOfSize:15];
     self.videoTitle.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    self.modelCardLabel.font = [UIFont systemFontOfSize:15];
    [self changeScrollTags];
    [self.tableV reloadData];
}

- (IBAction)modelCardAction:(id)sender {
    [_player destroyPlayer];
    _player=nil;
    [UIView animateWithDuration:0.3 animations:^{
        self.line.center = CGPointMake(_modelCardLabel.center.x,45);
    }];
    _selectIndex = 2;
      self.typeVideoTitle.font = [UIFont systemFontOfSize:15];
     self.videoTitle.font = [UIFont systemFontOfSize:15];
    self.modelCardLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
   [self changeScrollTags];
    [self.tableV reloadData];
}
-(void)changeScrollTags
{
    for (UIButton *typeBtn in _typeScroll.subviews) {
        [typeBtn removeFromSuperview];
    }
    NSArray *taglist ;
    if (_selectIndex==0) {
        taglist = _typeVideoDic[@"tagList"];
    }else if (_selectIndex==1){
         taglist = _videoDic[@"tagList"];
    }else if (_selectIndex==2){
          taglist = _modelCardDic[@"tagList"];
    }
    for(int i = 0;i<taglist.count;i++){
        NSString *type = taglist[i];
        UIButton *typebtn = [UIButton buttonWithType:0];
        [typebtn setTitle:type forState:0];
        typebtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [typebtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:0];
        if (i==0) {
            [typebtn setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
            [typebtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
            typebtn.layer.cornerRadius = 14;
            typebtn.layer.masksToBounds = YES;
        }
        //CGFloat mergin = 4;
        CGFloat x = 15+(59+4)*i;
        typebtn.frame = CGRectMake(x, 11, 59, 28);
        [typebtn addTarget:self action:@selector(typeSelect:) forControlEvents:UIControlEventTouchUpInside];
         [typebtn setTag:i+100];
        [self.typeScroll addSubview:typebtn];
        self.typeScroll.contentSize = CGSizeMake(typebtn.right+20, 50);
    }
}
#pragma mark --Action
- (IBAction)kefu:(id)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
//    ChatVC *caht = [ChatVC new];
//    caht.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:caht animated:YES];
}

- (IBAction)pingjia:(id)sender {
    PublishGradeViewController *vc = [PublishGradeViewController new];
    vc.userModel = _userModel;
    vc.gradeSuccessReferesh = ^{
        
    };
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)order:(id)sender {
    ActorOrderVC *aoVC = [ActorOrderVC new];
    aoVC.userModel = _userModel;
    aoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aoVC animated:YES];
}
//分享
-(void)shareAction
{
    SharePopV *pop=[[SharePopV alloc]init];
    WeakSelf(self);
    pop.shareBlock=^(NSInteger tag)
    {
        [ShareManager shareWithType:tag withUserInfo:self.userModel withViewControll:weakself];
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
                            @"actorId":@(self.userModel.actorId),
                            @"operateType":@(!self.userModel.isCollect)};
    [AFWebAPI_JAVA setCollectionArtistWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            if (!self.userModel.isCollect) {
                [SVProgressHUD showImage:[UIImage imageNamed:@"collect_pur_h"] status:@"收藏成功"];
                self.userModel.isCollect=YES;
                self.userModel.collect+=1;
                self.reModel(@"收藏", YES);
            }
            else
            {
                [SVProgressHUD showImage:nil status:@"取消收藏"];
                self.userModel.isCollect=NO;
                self.userModel.collect-=1;
                 self.reModel(@"收藏", NO);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"collectArtist" object:nil];  //收藏/取消成功，通知刷新收藏页面
            
            self.collectBtn.selected=self.userModel.isCollect;
           _topV.model = self.userModel;
           
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
    
    if (self.userModel.isPraise==YES) {
        [SVProgressHUD showImage:nil status:@"您已经点赞过了，无法重复点赞和取消哦"];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *dicArg= @{@"userId":[UserInfoManager getUserUID],
                            @"actorId":@(self.userModel.actorId),
                            @"operateType":@(!self.userModel.isPraise)};
    [AFWebAPI_JAVA getPraiseArtistWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showImage:[UIImage imageNamed:@"praise_pur_h"] status:@"点赞成功"];
            self.userModel.isPraise=YES;
            self.userModel.praise+=1;
            
            self.praiseBtn.selected=self.userModel.isPraise;
              self.reModel(@"点赞", YES);
           }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
        _topV.model = _userModel;
    }];
}
//更多
-(void)moreAction
{
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist)
    {
        [self goLogin];
        return;
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"更多操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"举报"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self reportUser];
                                                    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拉黑"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self PullblackUser];
                                                    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    
    [self presentViewController:alert animated:YES completion:^{}];
}


//拉黑
-(void)PullblackUser
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确定要拉黑TA吗？" message:@"拉黑后你将不再看到对方的资料" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拉黑"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        
                                                        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                                                        if ([UserInfoManager getIsJavaService]) {//java后台
                                                            NSDictionary *dicArg = @{@"userId":@([[UserInfoManager getUserUID] integerValue]),
                                                                                     @"otherUserId":@(self.userModel.actorId),
                                                                                     @"operateType":@"1"};
                                                            [AFWebAPI_JAVA getPullBlackUserWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
                                                                if (success) {
                                                                    [SVProgressHUD showSuccessWithStatus:@"用户已拉黑"];
                                                                }
                                                                else
                                                                {
                                                                    AF_SHOW_JAVA_ERROR
                                                                }
                                                            }];
                                                        }else{
                                                            NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                                                                                     @"creativeid":@(self.userModel.actorId),
                                                                                     @"type":@(1)};
                                                            [AFWebAPI getPullBlackUserWithArg:dicArg callBack:^(BOOL success, id object) {
                                                                if (success) {
                                                                    [SVProgressHUD showSuccessWithStatus:@"用户已拉黑"];
                                                                }
                                                                else
                                                                {
                                                                    AF_SHOW_RESULT_ERROR
                                                                }
                                                            }];
                                                            
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


//举报
-(void)reportUser
{
    ReportUserVC *reportVC=[[ReportUserVC alloc]init];
    reportVC.info=self.userModel;
    [self.navigationController pushViewController:reportVC animated:YES];
}
#pragma mark---未登录，先去登录
-(void)goLogin
{
    LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
    [self presentViewController:login animated:YES completion:nil];
}
@end
