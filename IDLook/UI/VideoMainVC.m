//
//  VideoMainVC.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoMainVC.h"
#import "VideoSCView.h"
#import "VideoMainCell.h"
#import "VideoListVC.h"
#import "WordSearchVC.h"
#import "VideoMainCell2.h"
static NSString *cellReuseIdentifer = @"cellReuseIdentifer";

@interface VideoMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)VideoSCView *scView;
@property(nonatomic,strong)CustomCollectV *collectionView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger cureIndex;
@end

@implementation VideoMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"广告演员分类"]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightBarButtonItem2WithTarget:self action:@selector(onSearch) normalImg:@"home_search" hilightImg:@"home_search"]]];
    
    
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self scView];
    [self collectionView];
    
    [self getData];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onSearch
{
    WordSearchVC *searchVC=[[WordSearchVC alloc]init];
    searchVC.mastery = 1;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)getData
{
    NSDictionary *dicArg = @{@"occupation":@(1)};
    [AFWebAPI getVideoTypeListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [self.dataSource removeAllObjects];
            NSArray *array = [object objectForKey:JSON_data];
            [self.dataSource setArray:array];
           
            NSMutableArray *typeArray = [NSMutableArray new];
            for (int i =0; i<self.dataSource.count; i++) {
                NSDictionary *dic = self.dataSource[i];
                [typeArray addObject:dic[@"catename"]];
            }
            self.scView.typeViewArray=typeArray;
            [self.collectionView reloadData];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

-(VideoSCView*)scView
{
    if (!_scView) {
        _scView =[[VideoSCView alloc]initWithFrame:CGRectMake(0, 0,90, UI_SCREEN_HEIGHT)];
        _scView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_scView];
        WeakSelf(self);
        _scView.ScreeSliderAClick = ^(NSInteger index) {
            weakself.cureIndex=index;
            [weakself.collectionView setContentOffset:CGPointMake(0, 0)];
            [weakself.collectionView reloadData];
        };
    }
    return _scView;
}

-(CustomCollectV*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
//        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 10, 10,10)];
         [flowLayout setSectionInset:UIEdgeInsetsMake(0, 20, 10,20)];
        _collectionView = [[CustomCollectV alloc] initWithFrame:CGRectMake(90,0,UI_SCREEN_WIDTH-90,UI_SCREEN_HEIGHT-SafeAreaTopHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.scrollEnabled=YES;
        _collectionView.alwaysBounceVertical = true; //当contentsize小于collectionview尺寸时，垂直方向添加弹簧效果
        _collectionView.showsHorizontalScrollIndicator=NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
      //  [_collectionView registerClass:[VideoMainCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        [_collectionView registerClass:[VideoMainCell2 class] forCellWithReuseIdentifier:cellReuseIdentifer];

        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource.count) {
        NSArray *list = self.dataSource[self.cureIndex][@"lists"];
        return list.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    VideoMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
//    cell.backgroundColor=[UIColor clearColor];
//
//    NSArray *list = self.dataSource[self.cureIndex][@"lists"];
//    [cell reloadUIWithDic:list[indexPath.row]];
//    return cell;
    VideoMainCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    NSArray *list = self.dataSource[self.cureIndex][@"lists"];
    NSDictionary *dic = list[indexPath.row];
    cell.dataDic = dic;
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     //return CGSizeMake((UI_SCREEN_WIDTH-90-40)/3, ((UI_SCREEN_WIDTH-90-40)/3)+40);
    CGFloat wid = (UI_SCREEN_WIDTH-94-40 - 32*2)/3;
    return CGSizeMake(wid, wid+58);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    VideoListVC *listVC=[[VideoListVC alloc]init];
    listVC.hidesBottomBarWhenPushed=YES;
    listVC.dic=self.dataSource[self.cureIndex];
    listVC.type=[self.dataSource[self.cureIndex][@"cateid"]integerValue];
    listVC.subType=indexPath.row;
    listVC.masteryType=1;
   [self.navigationController pushViewController:listVC animated:YES];
}

@end
