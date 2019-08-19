//
//  RegionSelectStep2.m
//  IDLook
//
//  Created by HYH on 2018/7/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RegionSelectStep2.h"
#import "CityCellA.h"
#import "SelectedCityV.h"

@interface RegionSelectStep2 ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;    //城市数据
@property(nonatomic,strong)NSMutableArray *selectArray;     //已选择的城市
@property(nonatomic,strong)SelectedCityV *headV;  //头部选择的城市的view
@end

@implementation RegionSelectStep2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:self.model.city]];

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"完成" Target:self action:@selector(finish)]]];
    
    [self getData];
    
    [self headV];
    
    [self tableV];
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
    self.dataSource = [NSMutableArray array];
    self.selectArray=[NSMutableArray array];
    
    CityModel *model = [[CityModel alloc]init];
    model.isShowArrow=NO;
    model.isSelect=self.model.isSelect;
    model.city=self.model.city;
    [self.dataSource addObject:model];
    
    NSArray *cityArray =self.model.object[@"Cities"];

    for (int i =0; i<cityArray.count; i++) {
        NSDictionary *dic = cityArray[i];
        CityModel *model = [[CityModel alloc]init];
        model.isShowArrow=NO;
        model.isSelect=NO;
        model.city=dic[@"city"];
        [self.dataSource addObject:model];
    }
    
    if (self.model.isSelect) {
        [self.selectArray addObject:self.dataSource[0]];
    }
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
                CityModel *model1 =weakself.dataSource[i];
                if ([model.city isEqualToString:model1.city])
                {
                    model1.isSelect=NO;
                    [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:i inSection:0], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
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
    [cell reloadUIWithModel:self.dataSource[indexPath.row]];
    WeakSelf(self);
    cell.doSelectCity = ^{
        [weakself reloadHeadWithIndexPath:indexPath];
    };
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self reloadHeadWithIndexPath:indexPath];

}

-(void)reloadHeadWithIndexPath:(NSIndexPath*)indexPath
{
    CityModel *model = self.dataSource[indexPath.row];
    model.isSelect=!model.isSelect;

    if (indexPath.row==0) {
        for (int i =1; i<self.dataSource.count; i++) {

            CityModel *modelA = self.dataSource[i];
            modelA.isSelect=NO;
        }
        
        [self.selectArray removeAllObjects];
        if (model.isSelect) {
            [self.selectArray addObject:model];
        }

    }
    else
    {
        CityModel *modelA = self.dataSource[0];
        if ([self.selectArray containsObject:modelA]) {
            [self.selectArray removeObject:modelA];
        }
        modelA.isSelect=NO;

        
        if (model.isSelect) {
            [self.selectArray addObject:model];
        }
        else
        {
            if ([self.selectArray containsObject:model]) {
                [self.selectArray removeObject:model];
            }
        }
    }
    
    [self.tableV reloadData];
    
    [self refreshHead];
}


@end
