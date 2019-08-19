//
//  SoreDetailViewController.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "SoreDetailViewController.h"
#import "SorceModel.h"
#import "SorceCell.h"
@interface SoreDetailViewController ()<UITabBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger page;
@property (weak, nonatomic) IBOutlet UIImageView *noDataSourceImage;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@end

@implementation SoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"积分明细"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];

//    SorceModel *model = [SorceModel yy_modelWithDictionary:dic];
//    [self.dataSource addObject:model];
    
    [_table addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
    [_table addFooterWithTarget:self action:@selector(pullUpToRefresh:)];
    self.table.tableFooterView = [UIView new];
    self.page = 1;
    [self refreshDataWithSortPage:_page withRefreshType:RefreshTypePullDown];
}
-(void)refreshDataWithSortPage:(NSInteger)page withRefreshType:(RefreshType)type
{
    if (type==RefreshTypePullDown) {
        page = 1;
    }
    NSDictionary *dic = @{
                        @"pageCount":@(30),
                        @"pageNumber":@(page),
                        @"userId":@([[UserInfoManager getUserUID]integerValue])
                        };
    [AFWebAPI_JAVA getSorceListWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            if (type==RefreshTypePullDown) {
                [_dataSource removeAllObjects];
            }
            NSDictionary *body = [object objectForKey:JSON_body];
            NSArray *historyList = body[@"historyList"];
            for(int i = 0;i<historyList.count;i++){
                NSDictionary *mDic = historyList[i];
                SorceModel *model = [SorceModel yy_modelWithDictionary:mDic];
                [self.dataSource addObject:model];
            }
            [self.table reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
        if (_dataSource.count==0) {
            self.noDataSourceImage.hidden = NO;
            self.noDataLabel.hidden = NO;
        }else{
            self.noDataSourceImage.hidden = YES;
               self.noDataLabel.hidden = YES;
        }
        [self.table headerEndRefreshing];
        [self.table footerEndRefreshing];
  
    }];
}
////获取买家积分明细
//+(void)getSorceListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SorceCell *cell = [SorceCell cellWithTableView:tableView];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)pullDownToRefresh:(id)sender
{

    _page = 1;
    [self refreshDataWithSortPage:_page withRefreshType:RefreshTypePullDown];
}

-(void)pullUpToRefresh:(id)sender
{
 
    _page++;
    [self refreshDataWithSortPage:_page withRefreshType:RefreshTypePullUp];
}
@end
