//
//  AnnunciateListVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateListVC.h"
#import "AnnunciateListCell.h"
#import "AnnunciateTopV.h"
#import "AnnunciateDetialVC.h"
#import "AnnunciateListModel.h"

@interface AnnunciateListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)AnnunciateTopV *topV;
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger cureIndex;
@end

@implementation AnnunciateListVC

-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@[],@[],@[],@[], nil];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"通告报名"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self topV];
    [self tableV];
    [self getData];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    NSDictionary *dicArg = @{@"actorId":[UserInfoManager getUserUID],
                             @"status":@"0"
                             };
    [AFWebAPI_JAVA getArtistAnnunciateListWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSArray *array = [object objectForKey:JSON_body][@"myApplyList"];
            
            [self.dataSource removeAllObjects];
            NSMutableArray *sec0 = [NSMutableArray new];  //全部
            NSMutableArray *sec1 = [NSMutableArray new];  //已选中
            NSMutableArray *sec2 = [NSMutableArray new];  //进行中
            NSMutableArray *sec3 = [NSMutableArray new];  //未选中
            
            for (int i=0; i<array.count; i++) {
                AnnunciateListModel *model = [AnnunciateListModel yy_modelWithDictionary:array[i]];
                [sec0 addObject:model];
                
                if (model.status==1) { //已选中
                    [sec1 addObject:model];
                }
                else if (model.status==3)  //进行中
                {
                    [sec2 addObject:model];
                }
                else if (model.status==2) //未选中
                {
                    [sec3 addObject:model];

                }
            }
            
            [self.dataSource addObject:sec0];
            [self.dataSource addObject:sec1];
            [self.dataSource addObject:sec2];
            [self.dataSource addObject:sec3];

            [self.tableV reloadData];
            [self reloadTableView];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
            [self.tableV hideNoDataScene];
            [self.tableV showWithNoDataType:NoDataTypeNetwork];

        }
    }];
}

-(AnnunciateTopV*)topV
{
    if (!_topV) {
        _topV=[[AnnunciateTopV alloc]init];
        [self.view addSubview:_topV];
        [_topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view);
            make.height.mas_equalTo(44);
        }];
        WeakSelf(self);
        _topV.AnnunciateTopVBlock = ^(NSInteger type) {
            weakself.cureIndex = type;
            [weakself.tableV reloadData];
            [weakself reloadTableView];
        };
    }
    return _topV;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,44,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-44) style:UITableViewStyleGrouped];
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
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource[self.cureIndex] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"AnnunciateListCell";
    AnnunciateListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[AnnunciateListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    [cell reloadUIWithModel:self.dataSource[self.cureIndex][indexPath.section]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AnnunciateListModel *model =self.dataSource[self.cureIndex][indexPath.section];
    AnnunciateDetialVC *detialVC=[[AnnunciateDetialVC alloc]init];
    detialVC.applyId=model.applyId;
    [self.navigationController pushViewController:detialVC animated:YES];
}

-(void)reloadTableView
{
    NSArray *array = self.dataSource[self.cureIndex];
    [self.tableV hideNoDataScene];
    if (array.count==0) {
        [self.tableV showWithNoDataType:NoDataTypeAnnunciate];
    }
}

@end
