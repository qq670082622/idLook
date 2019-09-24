//
//  CustomzOrderListVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CustomzOrderListVC.h"
#import "CustomizedOrderCell.h"
#import "CustomizedOrderModel.h"
#import "CustomzOrderDetailVC.h"
@interface CustomzOrderListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation CustomzOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"带货达人订单"]];
    _data = [NSMutableArray new];
    NSDictionary *dig = @{
                          @"pageCount":@(100),
                          @"pageNumber":@(1)
                          };
    [AFWebAPI_JAVA getCustomizedOrderListWithArg:dig callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSArray *body = object[@"body"];
            for (NSDictionary *dic in body) {
                CustomizedOrderModel *model = [CustomizedOrderModel yy_modelWithDictionary:dic];
                [_data addObject:model];
            }
            if (_data.count==0) {
                [_tableV showWithNoDataType:NoDataTypeOrder];
            }
            [_tableV reloadData];
        }
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomizedOrderCell *cell = [CustomizedOrderCell cellWithTableView:tableView];
    CustomizedOrderModel *model = _data[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 133;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count>0?1:0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     CustomizedOrderModel *model = _data[indexPath.row];
    CustomzOrderDetailVC *detailVC = [CustomzOrderDetailVC new];
    detailVC.orderId_ = model.orderId;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
