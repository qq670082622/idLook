//
//  ProjectCastingListVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/10.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectCastingListVC.h"
#import "CastingCell.h"
#import "ProjectCastingAddVC.h"
@interface ProjectCastingListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet CustomTableV *table;
- (IBAction)add:(id)sender;
@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation ProjectCastingListVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.table.tableFooterView = [UIView new];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选择角色"]];
  
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    // Do any additional setup after loading the view from its nib.
     [_table addHeaderWithTarget:self action:@selector(pullDownToRefresh)];
  //  self.table.animatedStyle = TABTableViewAnimationStart;
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self pullDownToRefresh];
}
-(void)pullDownToRefresh
{
   
    NSMutableDictionary *dicArg = [NSMutableDictionary new];
    NSString *uid = [UserInfoManager getUserUID];
    [dicArg setObject:@([uid integerValue]) forKey:@"userId"];
    [dicArg setObject:_projectId forKey:@"projectId"];
   
 
    [AFWebAPI_JAVA getCastingListWithArg:dicArg callBack:^(BOOL success, id object) {
    //     self.table.animatedStyle = TABTableViewAnimationEnd;
        if (success) {
           NSArray *array =[object objectForKey:JSON_body][@"roleList"];
            [self.data removeAllObjects];
         if ([array isKindOfClass:[NSNull class]]) {
                 [self.table showWithNoDataType:NoDataTypeRole];
               [self.table headerEndRefreshing];
                return ;
            }
            for (NSDictionary *roleDic in array) {
                CastingModel *cm = [CastingModel yy_modelWithDictionary:roleDic];
                [self.data addObject:cm];
            }
        [self.table headerEndRefreshing];
            if ( _data.count==0) {//试镜
                [self.table showWithNoDataType:NoDataTypeRole];
            }else{
                [self.table hideNoDataScene];
            }
            [self.table reloadData];
            }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    CastingCell *cell = [CastingCell cellWithTableView:tableView];
   
    if (tableView.animatedStyle != TABTableViewAnimationStart) {
   __block    CastingModel *model = _data[indexPath.row];
        cell.model = model;
    cell.cellAction = ^(CastingModel * _Nonnull model) {
//        if (weakself.type==1) {
//            weakself.selectCasting(model);
//            [weakself.navigationController popViewControllerAnimated:YES];
//            return ;
//            }
            ProjectCastingAddVC *add = [ProjectCastingAddVC new];
            add.type=2;
        add.fromAsk = YES;
            add.model = model;
        add.projectId = weakself.projectId;
            add.VCAdd = ^(CastingModel * _Nonnull infoModel, NSInteger type) {
                [weakself pullDownToRefresh];
                if (type==2) {
                    weakself.selectCasting(infoModel);
                }
            };
            add.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:add animated:YES];
         
        };
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (self.type==1) {
    CastingModel *model = _data[indexPath.row];
    self.selectCasting(model);
    [self.navigationController popViewControllerAnimated:YES];
     }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}

- (IBAction)add:(id)sender {
    WeakSelf(self);
    ProjectCastingAddVC *add = [ProjectCastingAddVC new];
    add.type=1;
    add.fromAsk = YES;
    add.projectId = _projectId;
   add.hidesBottomBarWhenPushed = YES;
    add.VCAdd = ^(CastingModel * _Nonnull infoModel, NSInteger type) {
        [weakself pullDownToRefresh];
    };
     [self.navigationController pushViewController:add animated:YES];
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
