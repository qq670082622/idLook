//
//  RegionSelectVC.m
//  IDLook
//
//  Created by HYH on 2018/7/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RegionSelectStep1.h"
#import "CityCellA.h"
#import "CityModel.h"
#import "SelectedCityV.h"
#import "RegionSelectStep2.h"

@interface RegionSelectStep1 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;    //城市数据
@property(nonatomic,strong)NSMutableArray *sectionArray;   //组头
@property(nonatomic,strong)NSMutableArray *selectArray;     //已选择的城市
@property(nonatomic,strong)SelectedCityV *headV;  //头部选择的城市的view
@end

@implementation RegionSelectStep1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
        
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"完成" Target:self action:@selector(finish)]]];
    
    [self getData];
    
    [self headV];
    
    [self tableV];
    
    if (self.type==RegionTypeMirr)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"微出镜区域"]];
    }
    else if (self.type==RegionTypeTrial)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"素材使用区域"]];
    }
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)finish
{
    NSMutableArray *array=[NSMutableArray new];
    for (int i =0; i<self.selectArray.count; i++) {
        CityModel *model=self.selectArray[i];
        [array addObject:model.city];
    }
    NSString *str = [array componentsJoinedByString:@"、"];
    self.selectCity(str);
    [self onGoback];
    
    
}


-(void)getData
{
    self.sectionArray=[NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    self.selectArray=[NSMutableArray array];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];

    NSArray *array11 = @[@"中国大陆全区域",@"港澳台",@"海外其他",@"独家买断"];
    for (int i =0; i<array11.count; i++) {
        CityModel *model =[[CityModel alloc]init];
        model.city=array11[i];
        model.isSelect=NO;
        model.isShowArrow=NO;
        [array1 addObject:model];
    }

    
    [self.dataSource addObject:array1];
    [self.sectionArray addObject:@""];
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RegionCity" ofType:@"plist"];
    NSArray *array =  [[NSArray alloc] initWithContentsOfFile:plistPath];
    for (int i =0; i<array.count; i++)
    {
        NSDictionary *dic = array[i];
        NSArray *cityArray = dic[@"Cities"];
        
        CityModel *model = [[CityModel alloc]init];
        model.isSelect=NO;
        model.city=dic[@"State"];
        model.object=dic;
        
        if (cityArray.count==0)
        {
            model.isShowArrow=NO;
        }
        else
        {
            model.isShowArrow=YES;
        }
        [array2 addObject:model];

    }
    
    [self.dataSource addObject:array2];
    [self.sectionArray addObject:@"省份（按首字母排序）"];
  
}

-(SelectedCityV*)headV
{
    if (!_headV) {
        _headV=[[SelectedCityV alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 50+40)];
        [self.view addSubview:_headV];
        [_headV reloadUIWithArray:self.selectArray];
        WeakSelf(self);
        _headV.delectCity = ^(NSInteger index) {  //删除
            
            //改变城市的数据源，刷新ui
            CityModel *model = weakself.selectArray[index];
            for (int i =0; i<weakself.dataSource.count; i++) {
                NSArray *array = weakself.dataSource[i];
                for (int j=0; j<array.count; j++) {
                    CityModel *model1 =array[j];
                    if ([model.city isEqualToString:model1.city])
                    {
                        model1.isSelect=NO;
                        [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:j inSection:i], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                }
            }
            
            //head刷新
            [weakself.selectArray removeObjectAtIndex:index];
            [weakself refreshHead];
        };
    }
    return _headV;
}


-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.headV.mas_bottom);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    return _tableV;
}

//刷新头部已选中城市的head
-(void)refreshHead
{
    if (self.selectArray.count==0) {
        self.headV.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, 50+40);
    }
    else
    {
        self.headV.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, 50+40*((self.selectArray.count-1)/4+1));
    }
    [self.headV reloadUIWithArray:self.selectArray];
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return .1f;
    }
    return 30.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"CityCellA";
    CityCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[CityCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell reloadUIWithModel:self.dataSource[indexPath.section][indexPath.row]];
    WeakSelf(self);
    cell.doSelectCity = ^{
        [weakself reloadHeadWithIndexPath:indexPath];
    };
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"UITableViewHeaderFooterView";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    if(!headerView)
    {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifer];
        [headerView.backgroundView setBackgroundColor:[UIColor clearColor]];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14.0];
        label.tag = 0x26;
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.left.mas_equalTo(headerView).offset(20);
        }];
    }
    
    UILabel *label = (UILabel *)[headerView viewWithTag:0x26];
    label.text = self.sectionArray[section];
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CityModel *model = self.dataSource[indexPath.section][indexPath.row];
    if (model.isShowArrow) {
        RegionSelectStep2 *step2=[[RegionSelectStep2 alloc]init];
        step2.model=model;
        step2.selectCity = ^(NSString *city) {
            
        };
        [self.navigationController pushViewController:step2 animated:YES];
    }
    else
    {
        [self reloadHeadWithIndexPath:indexPath];
    }
    
    
}

-(void)reloadHeadWithIndexPath:(NSIndexPath*)indexPath
{
    CityModel *model = self.dataSource[indexPath.section][indexPath.row];
    model.isSelect=!model.isSelect;
    [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (model.isSelect) {
        [self.selectArray addObject:model];
    }
    else
    {
        if ([self.selectArray containsObject:model]) {
            [self.selectArray removeObject:model];
        }
    }
    [self refreshHead];
}


@end
