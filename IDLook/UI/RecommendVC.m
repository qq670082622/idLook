//
//  RecommendVC.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//  推荐列表

#import "RecommendVC.h"
#import "HomeArtistCell.h"
#import "LookPricePopV2.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"

static NSString *cellReuseIdentifer = @"cellReuseIdentifer";

@interface RecommendVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)CustomCollectV *collectionView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];

    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    if (self.type==10) {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"明星艺人推荐"]];
    }
    else if (self.type==9)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"演员模特推荐"]];

    }
    
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];

    [self refreshDataWithSortPage:0 withRefreshType:0];

    
    [self collectionView];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

// type: 0下啦刷新  1上啦刷新
-(void)refreshDataWithSortPage:(NSInteger)sortpage withRefreshType:(NSInteger)type
{
    [self.collectionView startLoading];
    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                             @"useridentity":@(self.type),
                             @"sortpage":@(sortpage),
                             @"pagenumber":@"30"};
    [AFWebAPI getRecommendListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            
            if (type==0) {
                [self.dataSource removeAllObjects];
            }
            NSArray *array =[object objectForKey:JSON_data];
            for (int i = 0; i<array.count; i++) {
                UserInfoM *info = [[UserInfoM alloc]initWithDic:array[i]];
                info.isCollection=YES;
                [self.dataSource addObject:info];
            }
            [self.collectionView reloadData];
            [self.collectionView hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.collectionView showWithNoDataType:NoDataTypeCollection];
            }
        }
        else
        {
            //            AF_SHOW_RESULT_ERROR
            [self.collectionView hideNoDataScene];
            [self.collectionView showWithNoDataType:NoDataTypeNetwork];
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
        _collectionView = [[CustomCollectV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsHorizontalScrollIndicator=NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[HomeArtistCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        [self.view addSubview:_collectionView];
        [_collectionView addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
        [_collectionView addFooterWithTarget:self action:@selector(pullUpToRefresh:)];
    }
    return _collectionView;
}

-(void)pullDownToRefresh:(id)sender
{
    [self refreshDataWithSortPage:0 withRefreshType:0];
}

-(void)pullUpToRefresh:(id)sender
{
    UserInfoM *info = [self.dataSource lastObject];
    [self refreshDataWithSortPage:info.sortpage+1 withRefreshType:1];
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
    HomeArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithHexString:@"#FBFBFB"];
    UserInfoM *info = self.dataSource[indexPath.row];
    [cell reloadUIWithModel:info];
    WeakSelf(self);
    cell.clickUserInfo = ^{
        UserInfoVC *infoVC = [[UserInfoVC alloc]init];
        UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
        uInfo.actorId = [info.UID integerValue];
        infoVC.info =uInfo;
        [weakself.navigationController pushViewController:infoVC animated:YES];
    };
    
    cell.lookUserOffer = ^() {
        [weakself lookUserPriceInfo:info];
    };
    
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UI_SCREEN_WIDTH-45)/2, (UI_SCREEN_WIDTH-45)/2*1.57);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(15,15,15,15);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{

}

//查看报价
-(void)lookUserPriceInfo:(UserInfoM *)info
{
    
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {
        [SVProgressHUD showImage:nil status:@"登录后可查看报价！"];
        return;
    }
    
    //未认证成功，跳到认证界面
    if ([UserInfoManager getUserAuthState]!=1) {
        [SVProgressHUD showImage:nil status:@"认证后可查看报价！"];
        return;
    }
    
    NSDictionary *dicArg = @{@"userid":info.UID};
    [AFWebAPI getQuotaListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array =[object objectForKey:JSON_data];
            if (array.count>0) {
                LookPricePopV2 *popV= [[LookPricePopV2 alloc]init];
                [popV showWithArray:array];
            }
            else
            {
                [SVProgressHUD showImage:nil status:@"暂无报价！"];
                return;
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
}

#pragma mark --未认证，先去认证
-(void)goAuth
{
    if ([UserInfoManager getUserAuthState]==3){  //审核中
        [SVProgressHUD showImage:nil status:@"你的认证信息正在审核中，通过后才能查看报价！"];
        return;
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"去认证" message:@"认证通过之后您才能查看报价！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"去认证"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        
                                                        if ([UserInfoManager getUserAuthState]==0) {
                                                            AuthBuyerVC *authVC=[[AuthBuyerVC alloc]init];
                                                            authVC.hidesBottomBarWhenPushed=YES;
                                                            [self.navigationController pushViewController:authVC animated:YES];
                                                        }
                                                        else if ([UserInfoManager getUserAuthState]==2 || [UserInfoManager getUserAuthState]==3)
                                                        {
                                                            MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
                                                            stateVC.authState=[UserInfoManager getUserAuthState];
                                                            stateVC.hidesBottomBarWhenPushed=YES;
                                                            [self.navigationController pushViewController:stateVC animated:YES];
                                                        }
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}

@end
