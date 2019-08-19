//
//  CityChooseVC.m
//  IDLook
//
//  Created by HYH on 2018/7/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CitySelectStep1.h"
#import "CityCellA.h"
#import "CityModel.h"
#import "SelectedCityV.h"

@interface CitySelectStep1 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;    //城市数据
@property(nonatomic,strong)NSMutableArray *sectionArray;   //组头
@property(nonatomic,strong)NSMutableArray *selectArray;     //已选择的城市
@property(nonatomic,strong)SelectedCityV *headV;  //头部选择的城市的view
@end

@implementation CitySelectStep1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"拍摄城市"]];

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"完成" Target:self action:@selector(finish)]]];
    
    [self getData];

    [self headV];
    
    [self tableV];
    
    [self refreshHead];
    
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)finish
{
    if (self.selectArray.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择城市"];
        return;
    }
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
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ShotCity" ofType:@"plist"];
    NSArray *array =  [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    
    NSMutableArray *array111=[NSMutableArray array];
    
    for (int i =0; i<array.count; i++)
    {
        NSDictionary *dic = array[i];
        NSArray *cityArray = dic[@"Cities"];
        if (cityArray.count==0)
        {
            CityModel *model = [[CityModel alloc]init];
            model.isShowArrow=NO;
            model.isSelect=NO;
            model.city=dic[@"State"];
            [array1 addObject:model];
            if ([self.selectedArr containsObject:model.city]) {
                model.isSelect=YES;
                if (![model.city isEqualToString:self.artistRegin]) {
                    [self.selectArray addObject:model];
                }
            }
        }
        else
        {
            for (int j=0; j<cityArray.count; j++)
            {
                NSDictionary *dicA = cityArray[j];
                [array111 addObject:dicA[@"city"]];
            }
        }
    }
    
    //按首字母排序
    NSArray *result = [array111 sortedArrayUsingSelector:@selector(localizedCompare:)];
    for (int i =0; i<result.count; i++) {
        CityModel *model = [[CityModel alloc]init];
        model.isShowArrow=NO;
        model.isSelect=NO;
        model.city=result[i];
        [array2 addObject:model];
        if ([self.selectedArr containsObject:model.city]) {
            model.isSelect=YES;
            if (![model.city isEqualToString:self.artistRegin]) {
                [self.selectArray addObject:model];
            }
        }
    }
    
    if (self.artistRegin.length) {
        CityModel *model =[[CityModel alloc]init];
        model.city=[NSString stringWithFormat:@"%@",self.artistRegin];
        model.isSelect=NO;
        model.isShowArrow=NO;
        [self.dataSource addObject:@[model]];
        [self.sectionArray addObject:@"演员所在地"];
        if ([self.selectedArr containsObject:model.city]) {
            model.isSelect=YES;
            if (![self.selectArray containsObject:model]) {
                [self.selectArray addObject:model];
            }
        }
    }
    

    for (int i=0; i<array1.count; i++) {
        CityModel *model =array1[i];
        if ([model.city isEqualToString:self.artistRegin]) {
            if ([array1 containsObject:model]) {
                [array1 removeObject:model];
            }
        }
    }
    
    [self.dataSource addObject:array1];
    [self.sectionArray addObject:@"热门城市"];
    
    NSMutableArray *arraysss= [self sortObjectsAccordingToInitialWith:array2];
    for (int i =0; i<arraysss.count; i++) {
        NSMutableArray *arr11 = [NSMutableArray arrayWithArray:arraysss[i]];
        for (int j=0; j<[arr11 count]; j++)
        {
            CityModel *model =arr11[j];
            if ([model.city isEqualToString:self.artistRegin]) {
                if ([arr11 containsObject:model]) {
                    [arr11 removeObject:model];
                    break;
                }
            }
        }
        [self.dataSource addObject:arr11];
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

    [self reloadHeadWithIndexPath:indexPath];
}

-(void)reloadHeadWithIndexPath:(NSIndexPath*)indexPath
{
    CityModel *model = self.dataSource[indexPath.section][indexPath.row];

    if (self.selectArray.count>=4 && model.isSelect==NO) {
        [SVProgressHUD showImage:nil status:@"最多选择4个拍摄城市"];
        return;
    }
    
    model.isSelect=!model.isSelect;
    [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (model.isSelect) {
        if (![self.selectArray containsObject:model]) {
            [self.selectArray addObject:model];
        }
    }
    else
    {
        if ([self.selectArray containsObject:model]) {
            [self.selectArray removeObject:model];
        }
    }
    [self refreshHead];
}


#pragma mark--
#pragma mark---按首字母排序
-(NSMutableArray *)sortObjectsAccordingToInitialWith:(NSArray *)arr {
    
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    //初始化一个数组newSectionsArray用来存放最终的数据，我们最终要得到的数据模型应该形如@[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //初始化27个空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    //将每个名字分到某个section下
    for (CityModel *model in arr) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSInteger sectionNumber = [collation sectionForObject:model collationStringSelector:@selector(city)];
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:model];
    }
    
    //对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(city)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    //删除空的数组
    NSMutableArray *finalArr = [NSMutableArray new];
    
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        if (((NSMutableArray *)(newSectionsArray[index])).count != 0) {
            [finalArr addObject:newSectionsArray[index]];
            [self.sectionArray addObject:[collation sectionTitles][index]];
        }
    }
    return finalArr;
}

@end
