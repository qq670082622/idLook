//
//  EditHistoryVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/5/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "EditHistoryVC.h"
#import "historyModel.h"
#import "HistoryCell.h"
@interface EditHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation EditHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.tableFooterView = [UIView new];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改历史"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self loadData];
}
-(void)loadData
{
    NSDictionary *dic = @{
                          @"projectId": _projectId,
                          @"userId": @([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA checkProjectEditHistoryWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        NSDictionary *body = [object objectForKey:@"body"];
        NSArray *projectChangeList = body[@"projectChangeList"];
        [self.data removeAllObjects];
        if ([projectChangeList isKindOfClass:[NSNull class]]) {
            return ;
        }
        for (NSDictionary *hisDic in projectChangeList) {
            historyModel *hisM = [historyModel yy_modelWithDictionary:hisDic];
            [self.data insertObject:hisM atIndex:0];
        }
        [self.table reloadData];
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryCell *cell = [HistoryCell cellWithTableView:tableView];
    cell.model = _data[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryCell *cell = [HistoryCell cellWithTableView:tableView];
    cell.model = _data[indexPath.row];
    CGFloat cellh = cell.cellHeight;
    return cellh;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}
@end
