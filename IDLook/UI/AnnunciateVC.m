//
//  AnnunciateVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateVC.h"
#import "SharePopV.h"
#import "ShareManager.h"
#import "AnnunciateCell.h"
#import "AnnunciateModel.h"
#import "AnnunDetailVC.h"
#import "AnnunApplyvc.h"
#import "WriteFileManager.h"
@interface AnnunciateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet CustomTableV *table;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,assign)NSInteger page;
@end

@implementation AnnunciateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [WriteFileManager saveObject:@"yes" name:@"hadOpenAnnuciate"];
    NSArray *arr = self.navigationController.viewControllers;
    if (arr.count>1) {
         [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    }
  
    _page = 1;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"通告"]];
    self.table.tableFooterView = [UIView new];
     [_table addHeaderWithTarget:self action:@selector(pullDownToRefresh)];
    [_table addFooterWithTarget:self action:@selector(pullUpToAdd)];
 
    UIButton *shareBtn = [CustomNavVC getRightBarButtonItem2WithTarget:self action:@selector(share) normalImg:@"notice_nav_share_icon" hilightImg:@"notice_nav_share_icon"];
     shareBtn.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
     [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:shareBtn]];
    [self pullDownToRefresh];
}
-(void)pullDownToRefresh
{
    NSDictionary *dicArg = @{
                             @"pageCount":@(30),
                             @"pageNumber":@(1)
                             };
    [AFWebAPI_JAVA getAnnunciatesWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        [self.table headerEndRefreshing];
        if (success) {
            _page++;
            [self.data removeAllObjects];
            NSArray *shotBroadcastList = [object objectForKey:JSON_body][@"shotBroadcastList"];
            if (shotBroadcastList.count==0) {
                
                [self.table showWithNoDataType:NoDataTypeAnnunciate];
                return ;
            }
            [self.table hideNoDataScene];
            for (NSDictionary *dic in shotBroadcastList) {
                AnnunciateModel *model = [AnnunciateModel yy_modelWithDictionary:dic];
                [self.data addObject:model];
            }
            [self.table reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
 
}
-(void)pullUpToAdd
{
    NSDictionary *dicArg = @{
                             @"pageCount":@(30),
                             @"pageNumber":@(_page)
                             };
    [AFWebAPI_JAVA getAnnunciatesWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
         [self.table footerEndRefreshing];
        if (success) {
            _page++;
            NSArray *shotBroadcastList = [object objectForKey:JSON_body][@"shotBroadcastList"];
            for (NSDictionary *dic in shotBroadcastList) {
                AnnunciateModel *model = [AnnunciateModel yy_modelWithDictionary:dic];
                [self.data addObject:model];
            }
            [self.table reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    AnnunciateCell *cell = [AnnunciateCell cellWithTableView:tableView];
__block    AnnunciateModel *model = _data[indexPath.row];
    cell.model = model;
    cell.apply = ^(AnnunciateModel * _Nonnull model) {
        [weakself getAnnunciateDetailWithId:model.id andToDetail:YES];
    };
    cell.cellSelect = ^(AnnunciateModel * _Nonnull model) {
       [weakself getAnnunciateDetailWithId:model.id andToDetail:YES];
    };
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//      AnnunciateModel *model = _data[indexPath.row];
//    [self getAnnunciateDetailWithId:model.id andToDetail:YES];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
-(void)getAnnunciateDetailWithId:(NSInteger)anId andToDetail:(BOOL)toDetail//去详情还是报名页面
{
    NSDictionary *dic = @{
                          @"id":@(anId)
                          };
    [AFWebAPI_JAVA getAnnunDetailWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *detailInfo = [object objectForKey:JSON_body][@"detailInfo"];
            AnnunciateModel *model = [AnnunciateModel yy_modelWithDictionary:detailInfo];
            if (toDetail) {
                AnnunDetailVC *detail = [AnnunDetailVC new];
                detail.model = model;
                detail.hidesBottomBarWhenPushed = YES;
                 [self.navigationController pushViewController:detail animated:YES];
                return ;
            }
            AnnunApplyvc *ap = [AnnunApplyvc new];
            ap.model = model;
            ap.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ap animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
           
        }
    }];
   
}
//分享
-(void)share
{
    SharePopV *pop=[[SharePopV alloc]init];
    WeakSelf(self);
    pop.shareBlock=^(NSInteger tag)
    {
        NSString *test = @"http://192.168.1.81:8080/annunciate";
       NSString *production = @"http://www.idlook.com/idlook_h5/annunciate";
        [ShareManager shareAnnunciateWithType:tag Title:@"脸探今日通告报名链接" andDesc:@"海量角色有保障，接单量翻倍很轻松" andUrl:production andController:weakself];
    };
    
    [pop showBottomShare];
}
-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
