//
//  CalendarView.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CalendarView.h"
#import "CalenderModel.h"
#import "NSDate+Extension.h"
#import "CalenderCell.h"
#import "CalenderHeadView.h"
#import "CalenderWeekView.h"

static NSString *const reuseIdentifier  = @"collectionViewCell";
static NSString *const headerIdentifier = @"headerIdentifier";

@interface CalendarView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CalenderWeekView *weekView;     //星期view
@property (nonatomic, strong) NSMutableArray   *dataSource;   //数据
@property (nonatomic, strong) NSIndexPath      *startIndexPath;    //开始日期的item
@property (nonatomic, strong) NSIndexPath      *endIndexPath;      //结束日期的item
@end

@implementation CalendarView

-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}

-(void)layoutSubviews
{
    [self buildSource];
    [self weekView];
    [self collectionView];
    [self fitSelectRow];
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(calenderViewStartDateString:withEndDateString:)]) {
        [self.delegate calenderViewStartDateString:self.selectedStartDate withEndDateString:self.selectedEndDate];
    }
}

#pragma mark - 设置数据源
- (void)buildSource {
    NSAssert(self.startDay.length && self.endDay.length, @"开始时间和结束时间不能为空");
    
    NSArray   *startArray = [self.startDay componentsSeparatedByString:@"-"];
    NSArray   *endArray   = [self.endDay componentsSeparatedByString:@"-"];
    NSInteger months       = ([endArray[0] integerValue] - [startArray[0] integerValue])* 12 + ([endArray[1] integerValue] - [startArray[1] integerValue]) + 1;
    
    NSInteger years       = [endArray[0] integerValue] - [startArray[0] integerValue];
    
    for (int i = 0; i < months; i++) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [self.dataSource addObject:array];
    }
    
    for (int i = 0; i < months; i++) {
        int              month       = ((int)[NSDate month:self.startDay] + i)%12;
        NSDateComponents *components = [[NSDateComponents alloc]init];
        int              year       = (int)[NSDate year:self.startDay] ;
        //获取下个月的年月日信息,并将其转为date
        components.month = month ? month : 12;
        components.year  = year + (i+[startArray[1]integerValue]-1)  /12;
        components.day   = 1;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate     *nextDate = [calendar dateFromComponents:components];
        
        //获取该月第一天星期几
        NSInteger firstDayInThisMounth = [NSDate firstWeekdayInThisMonth:nextDate];
        
        //该月的有多少天daysInThisMounth
        NSInteger daysInThisMounth = [NSDate totaldaysInMonth:nextDate];
        NSString  *string          = [[NSString alloc]init];
        for (int j = 0; j < (daysInThisMounth > 29 && (firstDayInThisMounth == 6 || firstDayInThisMounth == 5) ? 42 : 35); j++) {
            CalenderModel *model = [[CalenderModel alloc] init];
            model.year  = components.year;
            model.month = components.month;
            if (j < firstDayInThisMounth || j > daysInThisMounth + firstDayInThisMounth - 1) {
                string    = @"";
                model.day = 0;
            } else {
                string    = [NSString stringWithFormat:@"%ld", j - firstDayInThisMounth + 1];
                model.day = j - firstDayInThisMounth + 1;
                
                NSString *dateStr = [NSString stringWithFormat:@"%zd-%02zd-%02zd",model.year, model.month, model.day];
                model.isActivity = [self isActivity:dateStr];
                if ([self.selectedStartDate isEqualToString:dateStr]) { //选中的开始日期
                    self.startIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                }
                
                if ([self.selectedEndDate isEqualToString:dateStr]) { //选中的结束日期
                    self.endIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                }
            }
            [[self.dataSource objectAtIndex:i]addObject:model];
        }
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.dataSource objectAtIndex:section] count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CalenderModel *model = self.dataSource[indexPath.section][indexPath.item];
    if (model.day<=0) {
        return;
    }
    if (model.isActivity==NO) {
        return;
    }
    
    if (indexPath==self.startIndexPath) {
        return;
    }
    if (self.type==0) {
        self.startIndexPath=indexPath;
    }
    else
    {
        if (self.startIndexPath==nil&& self.endIndexPath==nil) {
            self.startIndexPath=indexPath;
        }
        else if (self.startIndexPath!=nil&&self.endIndexPath==nil)
        {
            if (indexPath.section<=self.startIndexPath.section&&indexPath.row<=self.startIndexPath.row) {
                self.startIndexPath=indexPath;
            }
            else
            {
                self.endIndexPath=indexPath;
            }
        }
        else if (self.startIndexPath!=nil&&self.endIndexPath!=nil)
        {
            self.startIndexPath=indexPath;
            self.endIndexPath=nil;
        }
    }
    
    [self fitSelectRow];
    
    [self.collectionView reloadData];
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(calenderViewStartDateString:withEndDateString:)]) {
        [self.delegate calenderViewStartDateString:self.selectedStartDate withEndDateString:self.selectedEndDate];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    CalenderModel *model = self.dataSource[indexPath.section][indexPath.item];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CalenderHeadView *heardView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        CalenderModel      *model     = self.dataSource[indexPath.section][indexPath.item];
        heardView.yearAndMonthLabel.text = [NSString stringWithFormat: @"%zd年%zd月", model.year, model.month];
        return heardView;
    }
    
    return nil;
}


#pragma mark - set
- (BOOL)isActivity:(NSString *)date {
    BOOL activity = NO;
    NSTimeInterval startInterval = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", self.startDay]];
    NSTimeInterval endInterval = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", self.endDay]];
    NSTimeInterval currentInterval = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", date]];
    if (currentInterval >= startInterval && currentInterval <= endInterval) {
        activity = YES;
    }
    return activity;
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        float                      cellw       = self.bounds.size.width/7;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setHeaderReferenceSize:CGSizeMake(self.frame.size.width, 40)];
        flowLayout.sectionInset            = UIEdgeInsetsMake(0, -1, 0, 0);
        flowLayout.minimumInteritemSpacing = -1;
        flowLayout.minimumLineSpacing      = 0;
        flowLayout.itemSize                = CGSizeMake(cellw, 50);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30,self.frame.size.width,self.frame.size.height - 32)  collectionViewLayout:flowLayout];
        [self addSubview:_collectionView];
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        _collectionView.showsVerticalScrollIndicator   = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[CalenderHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        [_collectionView registerClass:[CalenderCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (CalenderWeekView *)weekView {
    if (_weekView == nil) {
        _weekView            = [[CalenderWeekView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 32)];
        _weekView.dataSource = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        _weekView.backgroundColor=Public_Background_Color;
        [self addSubview:_weekView];
    }
    return _weekView;
}

//选中一个日期后的内容相应改变
-(void)fitSelectRow
{
    //选中的开始日期
    if (self.startIndexPath) {
        CalenderModel  *model1 = self.dataSource[self.startIndexPath.section][self.startIndexPath.item];
        self.selectedStartDate = [NSString stringWithFormat:@"%zd-%02zd-%02zd",model1.year, model1.month, model1.day];
    }
    else
    {
        self.selectedStartDate=@"";
    }
    
    //选中的结束日期
    if (self.endIndexPath) {
        CalenderModel  *model2  = self.dataSource[self.endIndexPath.section][self.endIndexPath.item];
        self.selectedEndDate = [NSString stringWithFormat:@"%zd-%02zd-%02zd",model2.year, model2.month, model2.day];
    }
    else
    {
        self.selectedEndDate=@"";
    }
    if (self.type==1) {
        if (self.startIndexPath!=nil && self.endIndexPath==nil) {
            self.selectedEndDate=self.selectedStartDate;
        }
    }

    
    for (int i=0; i<self.dataSource.count; i++) {
        NSArray *array = self.dataSource[i];
        for (int j=0; j<array.count; j++) {
            CalenderModel *model = self.dataSource[i][j];
            model.type=self.type;
            
            if (self.startIndexPath!=nil && self.endIndexPath==nil) {
                if (i==self.startIndexPath.section && j==self.startIndexPath.row) {
                    model.isSelected=YES;
                }
                else
                {
                    model.isSelected=NO;
                }
                
                if (i==self.startIndexPath.section && j==self.startIndexPath.row) {  //开始日期
                    model.isStart=YES;
                }
                else
                {
                    model.isStart=NO;
                }
            }
            else if(self.startIndexPath && self.endIndexPath)
            {
                if (i==self.startIndexPath.section&&i==self.endIndexPath.section) {  //开始和结束日期只在一个月内的
                    if (j>=self.startIndexPath.row&&j<=self.endIndexPath.row) {
                        model.isSelected=YES;
                    }
                    else
                    {
                        model.isSelected=NO;
                    }
                }
                else if(self.startIndexPath.section<=i&&i<=self.endIndexPath.section) //开始和结束日期跨月
                {
                    if (i!=self.startIndexPath.section && i!=self.endIndexPath.section) {  //中间月的都选中
                        model.isSelected=YES;
                    }
                    else if(i==self.startIndexPath.section)  //开始那个月大于开始日期都选中
                    {
                        if (j>=self.startIndexPath.row) {
                            model.isSelected=YES;
                        }
                        else
                        {
                            model.isSelected=NO;
                        }
                    }
                    else if (i==self.endIndexPath.section)   //结束那个月小于结束日期都选中
                    {
                        if (j<=self.endIndexPath.row) {
                            model.isSelected=YES;
                        }
                        else
                        {
                            model.isSelected=NO;
                        }
                    }
                    else
                    {
                        model.isSelected=NO;
                    }
                }
                
                if (i==self.startIndexPath.section && j==self.startIndexPath.row) {  //开始日期
                    model.isStart=YES;
                }
                else
                {
                    model.isStart=NO;
                }
                
                if (i==self.endIndexPath.section && j==self.endIndexPath.row) {  //结束日期
                    model.isEnd=YES;
                }
                else
                {
                    model.isEnd=NO;
                }
            }
            else
            {
                model.isSelected=NO;
                model.isStart=NO;
                model.isEnd=NO;
            }
        }
    }
}

@end
