//
//  ProjectMainVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectMainVC.h"
#import "ProjectMainVC+Action.h"
#import "ProjectMainTopV.h"
#import "ProjectMainCellA.h"
#import "SwitchProjectPopV.h"
#import "ProjectDetailVC2.h"
#import "ServiceExplainPopV.h"
#import "ProjectOrderDetialVC.h"
#import "VideoPlayer.h"
#import "ProjectModel2.h"
#import "ProjectDetailVC2.h"
#import "ProjectBottomV.h"

@interface ProjectMainVC ()<UITableViewDataSource,UITableViewDelegate,ProjectDetailVC2Delegate>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)ProjectMainTopV *topV;
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,assign)NSInteger currIndexState;  //当前状态
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,strong)UIView *bgView;  //该项目无进度时的背景图
@property(nonatomic,strong)ProjectBottomV *bottomV;
@end

@implementation ProjectMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=Public_Background_Color;
    
    self.projectId=@"";
    [self topV];
    [self tableV];
    [self dsm];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.dsm getNewProjectWithProjectId:self.projectId];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [_player destroyPlayer];
    _player = nil;
}

-(ProjectMainVCM*)dsm
{
    if (!_dsm) {
        _dsm=[[ProjectMainVCM alloc]init];
        WeakSelf(self);
        _dsm.newDataNeedRefreshed = ^{
//            weakself.currIndexState=0;
            [weakself reloadTopUI];
            [weakself switProjectState];
            [weakself.tableV headerEndRefreshing];
        };
    }
    return _dsm;
}


-(ProjectMainTopV*)topV
{
    if (!_topV) {
        _topV=[[ProjectMainTopV alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH,SafeAreaTopHeight)];
        [self.view addSubview:_topV];
        [_topV reloadUIWithType:0 withProjectInfo:nil withState:self.currIndexState];
        WeakSelf(self);
        _topV.switchProjectBlock = ^{  //切换项目
            [weakself switchProject];
        };
        _topV.addNewProjectBlock = ^{   //新建项目
            [weakself addNewProject];
        };
        _topV.serviceExplainBlock = ^{  //服务费说明
            ServiceExplainPopV *popV = [[ServiceExplainPopV alloc]init];
            NSInteger serviceFee = [weakself.dsm.projectInfo[@"projectServiceFeePerDay"]integerValue];  //服务费
            NSInteger projectDays = [weakself.dsm.projectInfo[@"projectDays"]integerValue];  //项目天数
            [popV showWithDay:projectDays withFreePrice:serviceFee];
        };
        _topV.switchProjectStateBlock = ^(NSInteger state) {  //切换项目状态
            weakself.currIndexState=state;
            [weakself switProjectState];
        };
        _topV.canelBlcok = ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        };
        _topV.lookProjectdetialBlock = ^{  //查看项目
            NSDictionary *diaArg = @{
                                     @"projectId":weakself.dsm.projectInfo[@"projectId"],
                                     @"userId": @([[UserInfoManager getUserUID] integerValue])
                                     };
            [AFWebAPI_JAVA getProjectDetialWithArg:diaArg callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    NSDictionary *moDic = [object objectForKey:JSON_body];
                    ProjectModel2 *model2 = [ProjectModel2 yy_modelWithDictionary:moDic];
                    ProjectDetailVC2 *PDVC = [ProjectDetailVC2 new];
                    PDVC.hidesBottomBarWhenPushed=YES;
                    PDVC.model = model2;
                    PDVC.type = 3;
                    [weakself.navigationController pushViewController:PDVC animated:YES];
                }
            }];
        };
    }
    return _topV;
}

-(ProjectBottomV*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[ProjectBottomV alloc]init];
        [self.view addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            make.height.mas_equalTo(54);
        }];
        WeakSelf(self);
        _bottomV.closeViewBlock = ^{
            weakself.bottomV.hidden=YES;
        };
        _bottomV.hidden=YES;
    }
    return _bottomV;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,SafeAreaTopHeight,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        [_tableV showWithNoDataType:NoDataTypeProject];
        
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        _tableV.backgroundView = self.bgView;
        [_tableV addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
    }
    return _tableV;
}

-(UIView*)bgView
{
    if (!_bgView) {
        _bgView=[[UIView alloc]init];
        _bgView.hidden=YES;
        UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(12, 0, UI_SCREEN_WIDTH-24, UI_SCREEN_HEIGHT-(120+SafeAreaTabBarHeight_IphoneX)-SafeAreaTopHeight-10)];
        [_bgView addSubview:bg];
        bg.backgroundColor=[UIColor whiteColor];
        bg.layer.cornerRadius=6;
        bg.layer.masksToBounds=YES;
        
        UIImageView *imageV= [[UIImageView alloc]init];
        [bg addSubview:imageV];
        imageV.image =[UIImage imageNamed:@"project_nodata"];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bg);
            make.centerY.mas_equalTo(bg).offset(-30);
        }];
        
        UILabel *lab=[[UILabel alloc]init];
        lab.font=[UIFont systemFontOfSize:14];
        lab.text=@"暂无相关进度";
        lab.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
        [bg addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bg);
            make.top.mas_equalTo(imageV.mas_bottom).offset(14);
        }];
    }
    return _bgView;
}

-(void)pullDownToRefresh:(id)sender
{
    [self.dsm getNewProjectWithProjectId:self.projectId];
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
    if (self.dsm.ds.count==0) {
        return 0;
    }
    NSArray *array  = self.dsm.ds[self.currIndexState][@"projectOrderList"];
    return array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array  = self.dsm.ds[self.currIndexState][@"projectOrderList"];
    NSDictionary *dic = array[indexPath.section];
    ProjectOrderInfoM *info = [[ProjectOrderInfoM alloc]initWithDic:dic];
    return [self.dsm getCellHeightWithOrderInfo:info];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    
    static NSString *identifer = @"ProjectMainCellA";
    ProjectMainCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[ProjectMainCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    NSArray *array  = self.dsm.ds[self.currIndexState][@"projectOrderList"];
    ProjectOrderInfoM *info=[[ProjectOrderInfoM alloc]initWithDic:array[sec]];

    [cell reloadUIWithProjectOrderInfo:info];
    WeakSelf(self);
    cell.buttonClickBlock = ^(NSInteger type,UIButton *sender) {
        [weakself BottomButtonAction:type withProjectInfo:info withProjectDic:weakself.dsm.projectInfo];
//        NSLog(@"--%@--%@",NSStringFromCGRect(sender.frame),NSStringFromCGRect(cell.frame));
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSArray *array  = self.dsm.ds[self.currIndexState][@"projectOrderList"];
    ProjectOrderInfoM *info=[[ProjectOrderInfoM alloc]initWithDic:array[indexPath.section]];
    
    ProjectOrderDetialVC *detialVC = [[ProjectOrderDetialVC alloc]init];
    detialVC.hidesBottomBarWhenPushed=YES;
    detialVC.orderId=info.orderId;
    [self.navigationController pushViewController:detialVC animated:YES];
}

//刷新顶部ui
-(void)reloadTopUI
{
    if (self.dsm.ds.count==0) {
        [self.topV reloadUIWithType:0 withProjectInfo:nil withState:self.currIndexState];
        self.topV.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH,SafeAreaTopHeight);
        self.tableV.frame=CGRectMake(0,SafeAreaTopHeight,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight);
        [self.tableV showWithNoDataType:NoDataTypeProject];
    }
    else
    {
        [self.topV reloadUIWithType:1 withProjectInfo:self.dsm.projectInfo withState:self.currIndexState];
        self.topV.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH,190+SafeAreaTabBarHeight_IphoneX);
        self.tableV.frame=CGRectMake(0,120+SafeAreaTabBarHeight_IphoneX,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-(120+SafeAreaTabBarHeight_IphoneX)-SafeAreaTopHeight);
        [self.tableV hideNoDataScene];
    }
}

//切换项目状态
-(void)switProjectState
{
    if (self.dsm.ds.count>0) {
        NSArray *array  = self.dsm.ds[self.currIndexState][@"projectOrderList"];
        if (array.count==0) {
            self.bgView.hidden=NO;
        }
        else
        {
            self.bgView.hidden=YES;
        }
        
        if (array.count==0 &&self.currIndexState==0) {
            self.bottomV.hidden=NO;
        }
        else
        {
            self.bottomV.hidden=YES;

        }
    }
    [self.tableV reloadData];
}


#pragma mark---Action
//切换项目
-(void)switchProject
{
    [SVProgressHUD showWithStatus:@"正在加载项目。。。"];
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID],
                             @"pageNumber":@(1),
                             @"pageCount":@(1000)};
    
    [AFWebAPI_JAVA getProjectListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            NSArray *array =[object objectForKey:JSON_body][@"projectList"];
            SwitchProjectPopV *popV = [[SwitchProjectPopV alloc]init];
            [popV showWithArray:array withProjectId:self.dsm.projectInfo[@"projectId"]];
            WeakSelf(self);
            popV.switchProjectWithIdBlock = ^(NSString * _Nonnull projectId) {
                [weakself.dsm getNewProjectWithProjectId:projectId];
//                 weakself.currIndexState=0;
                weakself.projectId=projectId;
            };
            [SVProgressHUD dismiss];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

//新建项目
-(void)addNewProject
{
    ProjectDetailVC2 *PDVC = [ProjectDetailVC2 new];
    PDVC.hidesBottomBarWhenPushed=YES;
    PDVC.delegate = self;
    PDVC.type = 1;
    [self.navigationController pushViewController:PDVC animated:YES];
}

#pragma mark---ProjectDetailVC2Delegate
-(void)VCReferesh
{
    
}

//播放视频
-(void)playVideoWithUrl:(NSString *)url
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
    WeakSelf(self);
    _player.dowmLoadBlock = ^{
        
    };
    
}

@end
