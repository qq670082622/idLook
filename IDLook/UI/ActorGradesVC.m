//
//  ActorGradesVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/5/6.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorGradesVC.h"
#import "CheckGradeModel.h"
#import "ActorGradeCell.h"
@interface ActorGradesVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet CustomTableV *table;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation ActorGradesVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"评价"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    self.table.tableFooterView = [UIView new];
    [self loadData];
}
-(void)loadData
{
    NSDictionary *dic = @{
                          @"actorId":@(_actorId),
                          @"pageCount":@(30),
                          @"pageNumber":@(1),
                          @"userId":@([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA checkActorGradesWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSArray *comments = object[@"body"][@"commentList"];
            if (comments.count==0) {
                [self.table showWithNoDataType:NoDataTypeGrade];
                return ;
            }
            [self.table hideNoDataScene];
            for (NSDictionary *grade in comments) {
                CheckGradeModel *model = [CheckGradeModel yy_modelWithDictionary:grade];
                  NSArray *gradeStrings = [grade[@"tag"] componentsSeparatedByString:@"|"];
                 model.gradeStrings = gradeStrings;
                [self.dataSource addObject:model];
            }
            [self.table reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActorGradeCell *cell = [ActorGradeCell cellWithTableView:tableView];
    CheckGradeModel *model = self.dataSource[indexPath.row];
    cell.checkModel = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActorGradeCell *cell = [ActorGradeCell cellWithTableView:tableView];
    CheckGradeModel *model = self.dataSource[indexPath.row];
    cell.checkModel = model;
    return cell.cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    self.table.height-=34;
}
@end
