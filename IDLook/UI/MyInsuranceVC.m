//
//  MyInsuranceVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/17.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyInsuranceVC.h"
#import "InsuranceModel.h"
#import "MyInsuranceCell.h"
#import "InsuranceOrderDetailVC.h"
#import "InsuranceCompensateVC.h"
#import "AskPriceView.h"
@interface MyInsuranceVC ()<UITableViewDelegate,UITableViewDataSource,MyInsuranceCellDelegate>
@property (weak, nonatomic) IBOutlet CustomTableV *table;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation MyInsuranceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.tableFooterView = [UIView new];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"我的保险"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *dic = @{
                          @"userId":@([[UserInfoManager getUserUID]integerValue])
                          };
    [AFWebAPI_JAVA getInsuranceListWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [self.dataSource removeAllObjects];
            NSArray *orderList = [object objectForKey:JSON_body];
            if (orderList.count>0) {
                [self.table hideNoDataScene];
            }else{
                [self.table showWithNoDataType:NoDataTypeOrder];
            }
            for (NSDictionary *orderDic in orderList) {
                InsuranceModel *model = [InsuranceModel yy_modelWithDictionary:orderDic];
                [self.dataSource addObject:model];
            }
            [self.table reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInsuranceCell *cell = [MyInsuranceCell cellWithTableView:tableView];
    cell.model = _dataSource[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InsuranceOrderDetailVC *vc = [InsuranceOrderDetailVC new];
    vc.model = _dataSource[indexPath.row];
//    vc.type = 1;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 198;
}
#pragma -mark cellDelegate
-(void)compensateWithModel:(InsuranceModel *)model
{
//    InsuranceCompensateVC  *vc = [InsuranceCompensateVC new];
//    vc.model = model;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    AskPriceView *ap  = [[AskPriceView alloc] init];
    [ap showWithTitle:@"申请理赔" desc:@"请拨打平安业务部门报案电话：021-20662618，沟通理赔相关注意事项及理赔所需材料" leftBtn:@"" rightBtn:@"" phoneNum:@"02120662618"];
}
-(void)checkWithModel:(InsuranceModel *)model
{
    InsuranceOrderDetailVC  *vc = [InsuranceOrderDetailVC new];
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)ticketWithModel:(InsuranceModel *)model
{
    
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
@end
