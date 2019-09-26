//
//  CollectionMainVC.m
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CollectionMainVC.h"
#import "CollectionCustomCell.h"
#import "CollectionModel.h"
#import "ActorHomePage.h"
static NSString *cellReuseIdentifer = @"cellReuseIdentifer";

@interface CollectionMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CustomCollectViewDelegate>
@property(nonatomic,strong)CustomCollectV *collectionView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger sortPage;
@end

@implementation CollectionMainVC
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"collectArtist" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"收藏"]];
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];
    
    self.sortPage=1;
    [self refreshDataWithRefreshType:RefreshTypePullDown];
    [self collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:@"collectArtist" object:nil]; //收藏/取消成功，刷新页面
}


-(void)refreshUI
{
     self.sortPage=1;
    [self refreshDataWithRefreshType:RefreshTypePullDown];
}

-(void)refreshDataWithRefreshType:(RefreshType)type
{
    [self.collectionView startLoading];
    
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID],
                             @"pageCount":@(50),
                             @"pageNumber":@(self.sortPage)};
    [AFWebAPI_JAVA getCollectionListWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD dismiss];
            
            if (type==0) {
                [self.dataSource removeAllObjects];
            }
            
            NSArray *array = [object objectForKey:@"body"];
            for (int i = 0; i<array.count; i++) {
                NSDictionary *modelDic = array[i];
                NSDictionary *dic2 = @{@"nickname":modelDic[@"nickName"],
                                       @"headporurl":modelDic[@"headMini"],
                                       @"id":[NSString stringWithFormat:@"%@",modelDic[@"userId"]],
                                       @"expert":@([modelDic[@"expert"]integerValue])
                                       };
                UserInfoM *info = [[UserInfoM alloc]initWithDic:dic2];
                info.isCollection=YES;
                [self.dataSource addObject:info];
            }
            [self.collectionView reloadData];
            [self.collectionView hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.collectionView showWithNoDataType:NoDataTypeCollection];
            }
            
            if (array.count>0) {
                self.sortPage++;
            }
            if (type==0) {
                self.sortPage=2;
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:object];
            [self.collectionView hideNoDataScene];
            [self.collectionView showWithNoDataType:NoDataTypeCollection];
        }
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }];
}

-(CustomCollectV*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        [flowLayout setSectionInset:UIEdgeInsetsMake(15, 15, 15,15)];
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        CGFloat hei = UI_SCREEN_HEIGHT-SafeAreaTopHeight-UI_TAB_BAR_HEIGHT ;
        if (public_isX) {
             hei = UI_SCREEN_HEIGHT-SafeAreaTopHeight-UI_TAB_BAR_HEIGHT - 20;
        }
        _collectionView = [[CustomCollectV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,hei) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.dele=self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsHorizontalScrollIndicator=NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[CollectionCustomCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        
        [_collectionView addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
        [_collectionView addFooterWithTarget:self action:@selector(pullUpToRefresh:)];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(void)pullDownToRefresh:(id)sender
{
    self.sortPage=1;
    [self refreshDataWithRefreshType:RefreshTypePullDown];
}

-(void)pullUpToRefresh:(id)sender
{
    [self refreshDataWithRefreshType:RefreshTypePullUp];
}


#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithHexString:@"#FBFBFB"];
    UserInfoM *info = self.dataSource[indexPath.row];
    [cell reloadUIWithInfo:info];
    WeakSelf(self);
    cell.CollectionAction = ^(BOOL iscollection) {
        [weakself collectionActionWithSelect:iscollection withIndex:indexPath.row];
    };
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CollectionCellWidth, CollectionCellWidth*1.3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    WeakSelf(self);
    UserInfoM *info = self.dataSource[indexPath.row];
    if (info.expert==1) {
        ActorHomePage *hmpg = [ActorHomePage new];
      
        hmpg.actorId = info.userId;
        hmpg.reModel = ^(NSString * _Nonnull type, BOOL isTure) {
            if ([type isEqualToString:@"收藏"]) {
                [weakself refreshUI];
            }
        };
        hmpg.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hmpg animated:YES];
        return;
    }
      UserInfoVC *infoVC = [[UserInfoVC alloc]init];
    UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
    uInfo.actorId =[info.UID integerValue ];
    infoVC.info =uInfo;
    infoVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:infoVC animated:YES];
}


#pragma mark--收藏/取消收藏
-(void)collectionActionWithSelect:(BOOL)select withIndex:(NSInteger)index
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    UserInfoM *info = self.dataSource[index];
if ([UserInfoManager getIsJavaService]) {//java后台
    NSInteger selectType=select==YES?1:0;
  NSDictionary *dicArg= @{@"userId":[UserInfoManager getUserUID],
                            @"actorId":info.UID,
                            @"operateType":@(selectType)};
    [AFWebAPI_JAVA setCollectionArtistWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            if (select) {
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            }
            else
            {
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                [self.dataSource removeObjectAtIndex:index];
                [self.collectionView reloadData];
            }
            
            [self.collectionView hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.collectionView showWithNoDataType:NoDataTypeCollection];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
        
    }];
}else{
    NSDictionary *dicArg= @{@"userid":[UserInfoManager getUserUID],
                            @"artistid":info.UID,
                            @"type":@(select)};
    
    [AFWebAPI setCollectionArtistWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            if (select) {
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            }
            else
            {
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                [self.dataSource removeObjectAtIndex:index];
                [self.collectionView reloadData];
            }
            
            [self.collectionView hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.collectionView showWithNoDataType:NoDataTypeCollection];
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}
}


#pragma mark---
#pragma mark---CustomCollectViewDelegate
-(void)CustomCollectViewNoDataSceneClicked:(id)sender
{
    
}


@end
