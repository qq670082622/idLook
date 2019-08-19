//
//  StoreViewController.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreModel.h"
#import "StoreCell.h"
#import "StoreTableHeaderView.h"
#import "StoreApplyView.h"
#import "SoreDetailViewController.h"
#import "SorceExplainViewController.h"
@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource,storeCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(nonatomic,strong)StoreTableHeaderView *header;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign) NSInteger integral;
@end

@implementation StoreViewController
//获取商城列表
//+(void)getStoreListWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
////获取买家积分
//+(void)getUserSorceWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
//积分兑换
//+(void)getSorceConvertWithArg:(id)arg callBack:(HttpCallBackWithObject)callBack;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"积分商城"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
     [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightBarButtonItem2WithTarget:self action:@selector(sorceExplain) normalImg:@"sorce" hilightImg:@"sorce"]]];
//    StoreTableHeaderView *header = [[StoreTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 238)];
// self.table.tableHeaderView = header;
//    self.header = header;
//    self.table.tableFooterView = [UIView new];
    
    //资金明细
//    WeakSelf(self);
//    header.soreDetail = ^{
//        SoreDetailViewController *detail = [SoreDetailViewController new];
//         detail.hidesBottomBarWhenPushed=YES;
//        [weakself.navigationController pushViewController:detail animated:YES];
//    };
  
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self loadData];
    StoreTableHeaderView *header = [[StoreTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 238)];
    self.table.tableHeaderView = header;
    self.header = header;
    self.table.tableFooterView = [UIView new];
    WeakSelf(self);
    header.soreDetail = ^{
        SoreDetailViewController *detail = [SoreDetailViewController new];
        detail.hidesBottomBarWhenPushed=YES;
        [weakself.navigationController pushViewController:detail animated:YES];
    };
}
-(void)loadData
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [AFWebAPI_JAVA getStoreListWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSArray *list = [[object objectForKey:JSON_body] objectForKey:@"shopItemList"];
            [self.dataSource removeAllObjects];
            for(int i = 0 ;i<list.count;i++){
                NSDictionary *dicM = list[i];
                StoreModel *model = [StoreModel yy_modelWithDictionary:dicM];
                [self.dataSource addObject:model];
            }
            [AFWebAPI_JAVA getUserSorceWithArg:[NSDictionary dictionaryWithObject:@([[UserInfoManager getUserUID]integerValue]) forKey:@"userId"] callBack:^(BOOL success, id  _Nonnull object) {
               [SVProgressHUD dismiss];
                if (success) {
                    NSDictionary *body = [object objectForKey:JSON_body];
                    NSInteger sorce = [[body objectForKey:@"point"] integerValue];
                    self.header.integral = sorce;
                    _integral = sorce;
                      self.table.tableHeaderView.height = 238;
                    [self.table reloadData];
                }
            }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}
//选中购买某项商品
-(void)selectWithModel:(StoreModel *)model
{
    StoreApplyView *apply = [[StoreApplyView alloc] init];
    [apply showWithProductName:model.itemName num:model.number andTotalSorce:model.number*model.point];
 //  __block NSInteger totalSorce = model.number*model.point;
    __block StoreModel *blockModel = model;
    WeakSelf(self);
    apply.apply = ^{//确认申请
//        if (blockModel.number*blockModel.point>weakself.integral) {
//            [SVProgressHUD showImage:nil status:@"您的积分不足，无法兑换该商品"];
//            return;
//        }
         [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:@([[UserInfoManager getUserUID]integerValue]) forKey:@"userId"];
        [dic setObject:model.itemName forKey:@"contactName"];
        [dic setObject:[UserInfoManager getUserMobile] forKey:@"contactPhone"];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@(blockModel.number),@"count",@(blockModel.itemId),@"itemId",nil];
        [dic setObject:[NSArray arrayWithObject:dic2] forKey:@"redeemList"];
        [AFWebAPI_JAVA getSorceConvertWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"已提交申请"];
                [weakself loadData];
            }else{
                [SVProgressHUD showErrorWithStatus:object];
            }
        }];
        [SVProgressHUD showSuccessWithStatus:@"已提交申请"];
      //  [apply hide];
    };
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCell *cell = [StoreCell cellWithTableView:tableView];
    StoreModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    cell.totalSorce =  self.header.integral;
    cell.delegate = self;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 139;
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
-(void)sorceExplain
{
    SorceExplainViewController *ex = [SorceExplainViewController new];
     ex.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ex animated:YES];
   
}
@end
