//
//  RoleServiceVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "RoleServiceVC.h"
#import "AuditionServiceCell.h"
#import "RoleServiceDetialVC.h"
#import "PayWaysVC.h"

@interface RoleServiceVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation RoleServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选角服务"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.dataSource= [NSMutableArray new];
    [self tableV];
    [self getData];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID]};
    [AFWebAPI_JAVA getRoleServiceListWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_body];
            NSArray *array = (NSArray*)safeObjectForKey(dic, @"chooseActorServiceOrderList");
            [self.dataSource removeAllObjects];
            for (int i=0; i<array.count; i++) {
                RoleServiceModel *model = [RoleServiceModel yy_modelWithDictionary:array[i]];
                [self.dataSource addObject:model];
            }
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeOrder];
            }

            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeNetwork];
            }
        }
    }];
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 148;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"AuditionServiceCell";
    AuditionServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[AuditionServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=Public_Background_Color;
    }
    RoleServiceModel *model = self.dataSource[indexPath.section];
    [cell reloadUIWithModel:model];
    WeakSelf(self);
    cell.AuditionServiceCellPayBlock = ^{  //去支付
        [weakself payActionWithModel:model];
    };
    cell.AuditionServiceCellContactBlock = ^{  //联系脸探
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        });
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RoleServiceModel *model = self.dataSource[indexPath.section];
    RoleServiceDetialVC *detialVC = [[RoleServiceDetialVC alloc]init];
    detialVC.model=model;
    [self.navigationController pushViewController:detialVC animated:YES];
    WeakSelf(self);
    detialVC.refreshDataBlock = ^{
        [weakself getData];
    };
}

//去支付
-(void)payActionWithModel:(RoleServiceModel*)model
{
    PayWaysVC *payVC=[[PayWaysVC alloc]init];
    payVC.orderids=model.orderId;
    payVC.totalPrice=model.totalPrice;
    WeakSelf(self);
    payVC.refreshData = ^{
        [weakself paySuccessBackWithModel:model];
    };
    [self.navigationController pushViewController:payVC animated:YES];
}

-(void)paySuccessBackWithModel:(RoleServiceModel*)model
{
    NSDictionary *dicArg = @{@"orderIdList":@[model.orderId],
                             @"orderType":@(11),
                             @"status":@"paied",
                             @"userId":[UserInfoManager getUserUID]
                             };
    [AFWebAPI_JAVA getPaySuccessBackWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [self getData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

@end
