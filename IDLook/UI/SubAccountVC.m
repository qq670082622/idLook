//
//  SubAccountVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "SubAccountVC.h"
#import "SubAccountCell.h"
#import "AddSubAccountVC.h"
#import "EditSubAccountVC.h"

@interface SubAccountVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation SubAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"子账号管理"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//添加子账号
-(void)addSubAccountAction
{
    AddSubAccountVC *addVC = [[AddSubAccountVC alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
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
        _tableV.tableHeaderView=[self tableHeadV];
        
    }
    return _tableV;
}

-(UIView*)tableHeadV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 70)];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor=[UIColor whiteColor];
    addBtn.frame=CGRectMake(0, 11, UI_SCREEN_WIDTH, 48);
    [addBtn setTitle:@"添加子账号" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexString:@"#FF6600"] forState:UIControlStateNormal];
    addBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [addBtn setImage:[UIImage imageNamed:@"account_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addSubAccountAction) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:addBtn];
    addBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0,-2);
    if (IsBoldSize()) {
        addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 7);
    }
    return bg;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"SubAccountCell";
    SubAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[SubAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell reloadUI];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EditSubAccountVC *editVC = [[EditSubAccountVC alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // delete action
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                          {
                                              [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
                                              
                                              [self delectSubAccounteWithIndexPath:indexPath];
                                          }];
    return @[deleteAction];
}

//删除子账户
-(void)delectSubAccounteWithIndexPath:(NSIndexPath*)indexPath
{
    
}

@end
