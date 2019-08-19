//
//  ProjectOrderDetialVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOrderDetialVC.h"
#import "ProjectOrderDetialVCM.h"
#import "PlaceAuditCellD.h"
#import "ProjectOrderDetialCellA.h"
#import "ProjectOrderDetialCellB.h"
#import "ProjectOrderDetialCellC.h"
#import "ProjectOrderDetialCellD.h"
#import "ProjectOrderDetialCellE.h"
#import "ProjectOrderInfoM.h"
#import "LookBigImageVC.h"
#import "VideoPlayer.h"
#import "PublicWebVC.h"

@interface ProjectOrderDetialVC ()<UITableViewDataSource,UITableViewDelegate>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)ProjectOrderDetialVCM *dsm;

@end

@implementation ProjectOrderDetialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"订单详情"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self dsm];
    [self tableV];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player destroyPlayer];
    _player = nil;
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(ProjectOrderDetialVCM*)dsm
{
    if (!_dsm) {
        _dsm=[[ProjectOrderDetialVCM alloc]init];
        [_dsm refreshDataWithOrderId:self.orderId];
        WeakSelf(self);
        _dsm.newDataNeedRefreshed = ^{
            [weakself.tableV reloadData];
        };
    }
    return _dsm;
}

-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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
        _tableV.backgroundColor=[UIColor clearColor];
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
    return 1.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dsm.ds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[(NSDictionary *)self.dsm.ds[indexPath.section] objectForKey:kProjectOrderDetialVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    
    NSString *classStr = [(NSDictionary *)self.dsm.ds[sec] objectForKey:kProjectOrderDetialVCMCellClass];
    ProjectOrderDetialCellType type = [[(NSDictionary *)self.dsm.ds[sec] objectForKey:kProjectOrderDetialVCMCellType] integerValue];

    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }

    WeakSelf(self);
    if (type==ProjectOrderDetialCellTypeState) {  //状态栏
        ProjectOrderDetialCellA *cell = (ProjectOrderDetialCellA*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        [cell reloadUIWithInfo:self.dsm.info];
    }
    else if (type==ProjectOrderDetialCellTypeProjectInfo) //项目信息
    {
        ProjectOrderDetialCellB *cell = (ProjectOrderDetialCellB*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        [cell reloadUIWithInfo:self.dsm.info];
        cell.lookScriptBlock = ^(NSInteger tag) {  //查看脚本
            if (tag<self.dsm.info.projectScriptList.count) {
                [weakself lookScriptWithIndex:tag];
            }
        };
    }
    else if (type==ProjectOrderDetialCellTypeAskScheduleInfo )   //询档信息,试镜信息，拍摄信息，定妆信息
    {
        NSDictionary *dic = [(NSDictionary *)self.dsm.ds[sec] objectForKey:kProjectOrderDetialVCMCellData];
        
        ProjectOrderDetialCellE *cell = (ProjectOrderDetialCellE*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        [cell reloadUIWithInfo:self.dsm.info withDic:dic];
        cell.lookLastPhotoBlock = ^(NSInteger tag) {  //查看最新照片
            [weakself lookLastPhotoWithIndex:tag];
        };
    }
    else if (type==ProjectOrderDetialCellTypeScheduleGuarantee)  //档期保障
    {
        ProjectOrderDetialCellD *cell = (ProjectOrderDetialCellD*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        [cell reloadUIWithInfo:self.dsm.info];
        cell.explainScheduleBlock = ^{
            [weakself lookScheduleProtocol];
        };
    }
    else if (type==ProjectOrderDetialCellTypeInsurance)  //保险
    {
        PlaceAuditCellD *cell = (PlaceAuditCellD*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        [cell reloadUI];

    }
    else if (type==ProjectOrderDetialCellTypeOrderInfo)  //订单信息
    {
        ProjectOrderDetialCellC *cell = (ProjectOrderDetialCellC*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        [cell reloadUIWithInfo:self.dsm.info];
    }
    return obj;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger sec = indexPath.section;
    
    ProjectOrderDetialCellType type = [[(NSDictionary *)self.dsm.ds[sec] objectForKey:kProjectOrderDetialVCMCellType] integerValue];
    if (type==ProjectOrderDetialCellTypeInsurance)  //保险
    {
        //http://page.idlook.com/public/protocol/html/index.html?num_id=   正式
        //http://www.pre.idlook.com/public/protocol/html/index.html?num_id=  测试
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"保单详情" url:[NSString stringWithFormat:@"http://www.idlook.com/public/protocol/html/index.html?num_id=%@",@""]];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

//查看档期预约金协议
-(void)lookScheduleProtocol
{
    PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"档期预约金服务协议" url:@"http://www.idlook.com/public/appointment-money/index.html"];
    [self.navigationController pushViewController:webVC animated:YES];
}

//查看脚本
-(void)lookScriptWithIndex:(NSInteger)index
{
    NSDictionary *dic = self.dsm.info.projectScriptList[index];
    NSInteger uType  = [dic[@"type"] integerValue];
    if (uType==1) {  //1:图片;
        NSMutableArray *array = [NSMutableArray new];
        for (int i=0; i<self.dsm.info.projectScriptList.count; i++) {
            NSDictionary *dicA = self.dsm.info.projectScriptList[i];
            NSInteger type  = [dicA[@"type"] integerValue];
            if (type==1) {
                [array addObject:dicA[@"url"]];
                if ([dic[@"url"] isEqualToString:dicA[@"url"]]) {
                    index = array.count-1;
                }
            }
        }
         [self lookPhotoWithArray:array withIndex:index];
    }
    else //2:视频
    {
        NSString *url = dic[@"url"];
        [self lookVideoWithUrl:url];
    }
}

//最新照片
-(void)lookLastPhotoWithIndex:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *latestPhotoList = (NSArray*)safeObjectForKey(self.dsm.info.askScheduleInfo, @"latestPhotoList");
    for (int i=0; i<latestPhotoList.count; i++) {
        NSDictionary *dic = latestPhotoList[i];
        [array addObject:dic[@"url"]];
    }
    [self lookPhotoWithArray:array withIndex:index];
}

//查看图片
-(void)lookPhotoWithArray:(NSArray*)array withIndex:(NSInteger)index
{
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    [lookImage showWithImageArray:array curImgIndex:index AbsRect:CGRectMake(0,0,0,0)];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {};
}

//查看视频
-(void)lookVideoWithUrl:(NSString*)url
{
    [_player destroyPlayer];
    _player = nil;
    
    _player = [[VideoPlayer alloc] init];
    _player.videoUrl =url;
    _player.onlyFullScreen=YES;
    
    _player.completedPlayingBlock = ^(VideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
    _player.dowmLoadBlock = ^{
        
    };
}

@end
