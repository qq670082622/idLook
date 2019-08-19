//
//  CountryChooseVC.m
//  IDLook
//
//  Created by Mr Hu on 2018/12/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CountryChooseVC.h"
#import "CityModel.h"
#import "RegionCell.h"

@interface CountryChooseVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSMutableArray *sectionArray;   //组头

@end

@implementation CountryChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选择国籍"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self getData];
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    self.sectionArray=[NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Country" ofType:@"plist"];
    NSArray *array =  [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    NSMutableArray *array1 = [NSMutableArray array];
    
    //按首字母排序
    NSArray *result = [array sortedArrayUsingSelector:@selector(localizedCompare:)];
    for (int i =0; i<result.count; i++) {
        CityModel *model = [[CityModel alloc]init];
        model.city=result[i];
        [array1 addObject:model];
    }
    
    NSArray *arraysss=[self sortObjectsAccordingToInitialWith:array1];
    for (int i =0; i<arraysss.count; i++) {
        [self.dataSource addObject:arraysss[i]];
    }
    
}

-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableV.separatorColor = Public_LineGray_Color;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
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

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //索引条背景的颜色（清空颜色就不会感觉索引条将tableview往左边挤）
    [tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    //索引条文字的颜色
    [tableView setSectionIndexColor:Public_Red_Color];
    
    return self.sectionArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"RegionCell";
    RegionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[RegionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell reloadUIWithModel:self.dataSource[indexPath.section][indexPath.row]];
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
        label.textColor = [UIColor colorWithHexString:@"#909090"];
        label.font = [UIFont boldSystemFontOfSize:14.0];
        label.tag = 0x26;
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.left.mas_equalTo(headerView).offset(25);
        }];
    }
    
    UILabel *label = (UILabel *)[headerView viewWithTag:0x26];
    label.text = self.sectionArray[section];
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CityModel *model =self.dataSource[indexPath.section][indexPath.row];
    self.selectCountry(model.city);
    [self onGoback];
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
