//
//  AnnunciateDetialVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateDetialVC.h"
#import "AnnunciateDetialCellA.h"
#import "AnnunciateDetialCellB.h"
#import "AnnunciateDetialCellC.h"
#import "VideoPlayer.h"

@interface AnnunciateDetialVC ()<UITableViewDelegate,UITableViewDataSource>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSDictionary *annunciateInfo;
@end

@implementation AnnunciateDetialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"通告详情"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self tableV];
    [self getData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_player destroyPlayer];
    _player = nil;
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    NSDictionary *dicArg = @{@"actorId":[UserInfoManager getUserUID],
                             @"applyId":@(self.applyId)
                             };
    [AFWebAPI_JAVA gettArtistAnnunciateDetialWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            self.annunciateInfo = [object objectForKey:JSON_body];
            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
    
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0.5,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
    }
    return _tableV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 54;
    }
    else if (indexPath.section==1)
    {
        return 167;
    }
    NSArray *myWorkFileList = self.annunciateInfo[@"myWorkFileList"];
    NSDictionary *shotBroadcastRoleInfo = self.annunciateInfo[@"shotBroadcastRoleInfo"];
    NSString *str=shotBroadcastRoleInfo[@"remark"];
    return 235*myWorkFileList.count+66+[self heighOfString:str font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-80];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *identifer = @"AnnunciateDetialCellA";
        AnnunciateDetialCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AnnunciateDetialCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithDic:self.annunciateInfo];
        return cell;
    }
    else if (indexPath.section==1)
    {
        static NSString *identifer = @"AnnunciateDetialCellB";
        AnnunciateDetialCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AnnunciateDetialCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithDic:self.annunciateInfo];
        return cell;
    }
    else
    {
        static NSString *identifer = @"AnnunciateDetialCellC";
        AnnunciateDetialCellC *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AnnunciateDetialCellC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithDic:self.annunciateInfo];
        WeakSelf(self);
        cell.clickSourceWithInfoBlock = ^(NSDictionary *dic) {  //查看图片或视频
            [weakself lookPhotoOrVideoWithDic:dic];
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//查看图片或视频
-(void)lookPhotoOrVideoWithDic:(NSDictionary*)dic
{
    NSInteger fileType = [dic[@"fileType"]integerValue]; //文件类型 1：图片；2：视频
    if (fileType==1) {
        NSArray *dataS = @[dic[@"url"]];
        LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
        lookImage.isShowDown=YES;
        [lookImage showWithImageArray:dataS curImgIndex:0 AbsRect:CGRectMake(0, 0,0,0)];
        [self.navigationController pushViewController:lookImage animated:YES];
        lookImage.downPhotoBlock = ^(NSInteger index) {};
    }
    else if (fileType==2)
    {
        [_player destroyPlayer];
        _player = nil;
        _player = [[VideoPlayer alloc] init];
        _player.videoUrl =dic[@"url"];
        _player.onlyFullScreen=YES;
        _player.completedPlayingBlock = ^(VideoPlayer *player) {
            [player destroyPlayer];
            player = nil;
        };
        _player.dowmLoadBlock = ^{};
    }
}

//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 5;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<24.0?24.0:ceilf(size.height);
}

@end
