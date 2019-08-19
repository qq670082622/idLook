//
//  AuthChooseIdentityVC.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthChooseIdentityVC.h"
#import "IDTypeModel.h"
#import "AuthIDChooseHeadV.h"
#import "AuthIDChooseCell.h"

@interface AuthChooseIdentityVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableV;
@property (nonatomic,strong)NSMutableArray *dataS;
@end

@implementation AuthChooseIdentityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选择公司类型"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self tableV];
}

-(NSMutableArray*)dataS
{
    if (!_dataS) {
        _dataS = [[NSMutableArray alloc]initWithArray:[IDTypeModel getData]];
    }
    return _dataS;
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)tableV
{
    if(!_tableV)
    {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        _tableV.tableHeaderView=[self tableHeadV];
    }
    return _tableV;
}

-(UIView*)tableHeadV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 35)];
    bg.backgroundColor=[UIColor colorWithHexString:@"#FFF7EA"];
    
    UILabel *headState= [[UILabel alloc]init];
    headState.font=[UIFont systemFontOfSize:13.0];
    headState.textColor=[UIColor colorWithHexString:@"#FFB540"];
    headState.text=@"选择后不可更改，请准确选择您的身份。";
    headState.textAlignment=NSTextAlignmentCenter;
    [bg addSubview:headState];
    [headState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.centerY.mas_equalTo(bg);
    }];
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
    return 48.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataS.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    IDTypeStructModel *model = self.dataS[section];
    if (model.isShowRow) {
        return model.array.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"AuthIDChooseHeadV";
    AuthIDChooseHeadV *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    if(!headerView)
    {
        headerView = [[AuthIDChooseHeadV alloc] initWithReuseIdentifier:identifer];
        [headerView.backgroundView setBackgroundColor:[UIColor whiteColor]];
    }
    IDTypeStructModel *model=self.dataS[section];
    [headerView reloadUIWithModel:model];
    WeakSelf(self);
    headerView.showDetialBlock = ^{
        if (model.isShowArrow) {
            model.isShowRow=!model.isShowRow;
            [weakself.tableV reloadSections:[[NSIndexSet alloc]initWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else
        {
            NSDictionary *dic = [model.array firstObject];
            if (weakself.chooseIDTypeBlock) {
                weakself.chooseIDTypeBlock([dic[@"UserSubType"]integerValue], dic[@"UserSubTypeName"]);
            }
            [weakself onGoback];
        }
    };
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"AuthIDChooseCell";
    AuthIDChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[AuthIDChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.backgroundColor=[UIColor whiteColor];
    }
    IDTypeStructModel *model = self.dataS[indexPath.section];
    
    [cell reloadUIWithDic:model.array[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    IDTypeStructModel *model = self.dataS[indexPath.section];
    NSDictionary *dic = model.array[indexPath.row];
    if (self.chooseIDTypeBlock) {
        self.chooseIDTypeBlock([dic[@"UserSubType"]integerValue], dic[@"UserSubTypeName"]);
    }
    [self onGoback];
}


@end