//
//  PriceMainVC.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PriceMainVC.h"
#import "PriceMainCell.h"
#import "AddPriceVC.h"
#import "PriceManger.h"
#import "PriceModel.h"

@interface PriceMainVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)PriceManger *dsm;
@end

@implementation PriceMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"报价管理"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];

    [self dsm];
    [self tableV];
    [self addBtn];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}


//新增报价
-(void)addPrice
{
    BOOL isFull = false;
//    if (_dsm.ds.count==2) {
//        NSDictionary *dic = [_dsm.ds objectAtIndex:0];
//        NSDictionary *dic2 = [_dsm.ds objectAtIndex:1];
//        NSArray *arr1 = [dic objectForKey:@"data"];
//          NSArray *arr2 = [dic2 objectForKey:@"data"];
//        if (arr1.count==3 && arr2.count==3) {
//            isFull = YES;
//        }
//    }
    if (_dsm.ds.count==3) {
        isFull = YES;
    }
    if (isFull) {
        [SVProgressHUD showErrorWithStatus:@"已设置全部报价，无法新增!"];
        return;
    }
//    NSMutableArray *existArr = [NSMutableArray new];
//    for (int i=0; i<self.dsm.ds.count; i++) {
//        NSArray *array = [self.dsm.ds[i] objectForKey:@"data"];
//        for (int j=0; j<array.count; j++) {
//            PriceModel *model = array[j];
//            [existArr addObject:@(model.subType)];
//        }
//    }
    NSMutableArray *existArr = [NSMutableArray new];
    NSArray *types = @[@"1",@"2",@"4"];
    for (int i=0; i<self.dsm.ds.count; i++) {
        NSDictionary *dic = self.dsm.ds[i];
        NSInteger dicType = [dic[@"advertType"] integerValue];
        if ([types containsObject:[NSString stringWithFormat:@"%d",dicType]]) {
            [existArr addObject:[NSString stringWithFormat:@"%d",dicType]];
        }
    }
    PriceModel *model = [[PriceModel alloc]init];
    AddPriceVC *priceVC=[[AddPriceVC alloc]init];
    priceVC.type=AddPriceTypeAdd;
    priceVC.model=model;
    priceVC.existArray =existArr;
    WeakSelf(self);
    priceVC.addPriceBlock = ^{
        [weakself.dsm refreshPriceInfo];
    };
    [self.navigationController pushViewController:priceVC animated:YES];
}

-(UIButton*)addBtn
{
    if (!_addBtn) {
        _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"icon_newAdd"] forState:UIControlStateNormal];
        [_addBtn setTitle:@"新增报价" forState:UIControlStateNormal];
        _addBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        _addBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 6, 0, -6);
        _addBtn.backgroundColor=Public_Red_Color;
        [self.view addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
            make.height.mas_equalTo(50);
        }];
        [_addBtn addTarget:self action:@selector(addPrice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(PriceManger*)dsm
{
    if (!_dsm) {
        _dsm=[[PriceManger alloc]init];
        WeakSelf(self);
        _dsm.newDataNeedRefreshed = ^{
            [weakself.tableV reloadData];
            [weakself.tableV hideNoDataScene];
            if (weakself.dsm.ds.count==0) {
                [weakself.tableV showWithNoDataType:NoDataTypePrice];
            }
        };
    }
    return _dsm;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
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
        _tableV.backgroundColor=[UIColor clearColor];
    }
    return _tableV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 46.f;
//}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return self.dsm.ds.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSDictionary *dic =self.dsm.ds[section];
//
//    return [[dic objectForKey:@"data"] count];
    return _dsm.ds.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    PriceMainCell *cell = [PriceMainCell cellWithTableView:tableView];
   NSDictionary *dic =self.dsm.ds[indexPath.row];
   PriceModel *model = [PriceModel yy_modelWithDictionary:dic];
   cell.model = model;
    return cell;
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *identifer = @"UITableViewHeaderFooterView";
//    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
//    if(!headerView)
//    {
//        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifer];
//        [headerView.backgroundView setBackgroundColor:[UIColor clearColor]];
//
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.textColor =  Public_Text_Color;
//        titleLabel.tag=100;
//        titleLabel.font=[UIFont boldSystemFontOfSize:15];
//        [headerView addSubview:titleLabel];
//        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(headerView).offset(25);
//            make.left.mas_equalTo(headerView).offset(15);
//        }];
//    }
//    NSDictionary *dic =self.dsm.ds[section];
//    UILabel *lab = (UILabel*)[headerView viewWithTag:100];
//    lab.text = dic[@"title"];
//
//    return headerView;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSDictionary *dic =self.dsm.ds[indexPath.section];
//    NSArray *array = [dic objectForKey:@"data"];
//    PriceModel *model = array[indexPath.row];
    BOOL canEdit = false;
//    //删除审核：status==1 /增加审核 status==0 examinestate==1  /修改审核 status==4 examinestate==1
//    if (model.waitPrice == 0 && model.examinestate == 1) {//增加审核中
//        [SVProgressHUD showImage:nil status:@"请审核通过后再修改。"];
//    }else if (model.waitPrice > 0 && model.examinestate == 1){//修改审核
//        canEdit = YES;
//    }else if (model.status==1){//删除审核
//         [SVProgressHUD showImage:nil status:@"删除中的报价不可修改。"];
//    }else{//正常
//         canEdit = YES;
//
//    }
    NSDictionary *dic =self.dsm.ds[indexPath.row];
    PriceModel *model = [PriceModel yy_modelWithDictionary:dic];
    if (model.examineState==11) {//增加审核中
       [SVProgressHUD showImage:nil status:@"请审核通过后再修改。"];
        
    }else if (model.examineState==12){//修改审核
        canEdit = YES;
        
    }else if (model.examineState==13){//删除审核
         [SVProgressHUD showImage:nil status:@"删除中的报价不可修改。"];
    }else{//正常
        canEdit = YES;
    }
    if (canEdit == YES) {
        AddPriceVC *priceVC=[[AddPriceVC alloc]init];
        priceVC.type=AddPriceTypeModify;
        if (model.advertType==1) {
            model.title = @"视频";
            model.advertType = 1;
        }else if (model.advertType==2){
            model.title = @"平面";
            model.advertType = 2;
        }else{
            model.title = @"套拍";
            model.advertType = 4;
        }
        priceVC.model=model;
        priceVC.priceArray = model.detailInfoList;
        WeakSelf(self);
        priceVC.addPriceBlock = ^{
            [weakself.dsm refreshPriceInfo];
        };
        [self.navigationController pushViewController:priceVC animated:YES];
    }
   
   
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // delete action
   
    NSDictionary *dic = self.dsm.ds[indexPath.section];
    NSArray *Models = [dic objectForKey:@"data"];
    PriceModel *model = Models[indexPath.row];
    if (model.examineState==11) {//新增审核
        return [NSArray new];
    }else if (model.examineState==12){//修改审核
        return [NSArray new];
    }else if (model.examineState==13){//删除审核
         return [NSArray new];
    }
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                          {
                                              [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
                                        
                                              [self delectPriceWithIndexPath:indexPath];
                                          }];
    return @[deleteAction];
}

//删除报价
-(void)delectPriceWithIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary *dic =self.dsm.ds[indexPath.row];
    PriceModel *model = [PriceModel yy_modelWithDictionary:dic];
    
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dicArg =@{@"userId":@([[UserInfoManager getUserUID] integerValue]),
                            @"quotationId":@(model.quotationId)};
    [AFWebAPI_JAVA delectQuotaWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self.dsm refreshPriceInfo];
        }
        else
        {
             [SVProgressHUD showErrorWithStatus:@"审核中无法删除"];
            //AF_SHOW_RESULT_ERROR
        }
    }];
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    [self.addBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-34);
    }];
   // self.tableV.frame = CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-84);
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.addBtn.mas_top);
    }];
}
@end
