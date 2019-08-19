//
//  SearchMainVC.m
//  IDLook
//
//  Created by HYH on 2018/5/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SearchMainVC.h"
#import "HomeArtistCell.h"
#import "SearchStrucM.h"
#import "SearchStrucM.h"
#import "SearchMainTopV.h"
#import "ScreenPopV.h"
#import "LookPricePopV2.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"

static NSString *cellReuseIdentifer = @"cellReuseIdentifer";

@interface SearchMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)CustomCollectV *collectionView;
@property(nonatomic,strong)SearchMainTopV *topV; //顶部筛选条件view
@property(nonatomic,assign)NSInteger currIndex;  //当前选择的条件
@property(nonatomic,copy)NSString *imageType;   //形象类型
@property(nonatomic,strong)NSDictionary *screenConditionDic;  //筛选条件类容
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation SearchMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];

    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:[SearchStrucM getArtistTypeWithType:self.type]]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];

    self.currIndex=0;
    self.imageType=@"";
    self.screenConditionDic=@{};
    self.dataSource=[NSMutableArray array];
    [self refreshDataWithSortPage:1 withRefreshType:RefreshTypePullDown];
    [self topV];
    [self collectionView];

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshDataWithSortPage:(NSInteger)sortpage withRefreshType:(RefreshType)type
{
    [self.collectionView startLoading];
    
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:self.screenConditionDic];
    [dicArg setObject:@(self.type+1)forKey:@"occupation"];
    [dicArg setObject:@(sortpage) forKey:@"sortpage"];
    [dicArg setObject:@"30" forKey:@"pagenumber"];
    [dicArg setObject:@(self.currIndex) forKey:@"ageidentity"];
    [dicArg setObject:self.imageType forKey:@"figuretype"];
    
    [AFWebAPI getScreeUserListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            
            if (type==0) {
                [self.dataSource removeAllObjects];
            }
            
            NSArray *array= (NSArray*)safeObjectForKey(object, JSON_data);;
            
            for (int i = 0; i<array.count; i++) {
                UserInfoM *info = [[UserInfoM alloc]initWithDic:array[i]];
                [self.dataSource addObject:info];
            }
            [self.collectionView reloadData];
            [self.collectionView hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.collectionView showWithNoDataType:NoDataTypeSearchResult];
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR
            [self.collectionView hideNoDataScene];
             if (self.dataSource.count==0) {
                 [self.collectionView showWithNoDataType:NoDataTypeNetwork];
             }
        }
        
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }];
}


-(SearchMainTopV*)topV
{
    if (!_topV) {
        _topV = [[SearchMainTopV alloc]init];
        _topV.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_topV];
        WeakSelf(self);
        _topV.SearchMainTopVBlock = ^{
            ScreenPopV *popV = [[ScreenPopV alloc]init];
            popV.selectDic=weakself.screenConditionDic;
            [popV showWithType:weakself.currIndex];
            popV.confrimBlock = ^(NSDictionary *dic) {
                weakself.screenConditionDic=dic;
                [weakself refreshDataWithSortPage:0 withRefreshType:RefreshTypePullDown];
            };
        };
        
        _topV.SearchMainTopAgeTypeClick = ^(NSInteger index) {
            weakself.currIndex=index;
            weakself.imageType=@"";
            weakself.screenConditionDic=@{};
            [weakself refreshDataWithSortPage:0 withRefreshType:RefreshTypePullDown];
            if (index==0) {
                weakself.collectionView.frame=CGRectMake(0, 45, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight-45);
            }
            else
            {
                weakself.collectionView.frame=CGRectMake(0, 95, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight-95);
            }
        };
        
        _topV.SearchMainTopImageTypeClick = ^(NSString *content) {
            weakself.imageType=content;
            [weakself refreshDataWithSortPage:0 withRefreshType:RefreshTypePullDown];
        };
    }
    return _topV;
}


-(CustomCollectV*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[CustomCollectV alloc] initWithFrame:CGRectMake(0,45, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-45-SafeAreaTopHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.showsVerticalScrollIndicator=NO;
        [_collectionView setBackgroundColor:[UIColor colorWithHexString:@"#F7F7F7"]];
        [_collectionView registerClass:[HomeArtistCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        [self.view addSubview:_collectionView];

        
        [_collectionView addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
        [_collectionView addFooterWithTarget:self action:@selector(pullUpToRefresh:)];
    }
    return _collectionView;
}

-(void)pullDownToRefresh:(id)sender
{
    [self refreshDataWithSortPage:0 withRefreshType:RefreshTypePullDown];
}

-(void)pullUpToRefresh:(id)sender
{
    UserInfoM *info = [self.dataSource lastObject];
    [self refreshDataWithSortPage:info.sortpage+1 withRefreshType:RefreshTypePullUp];
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
    static NSString *identifer = @"cellReuseIdentifer";
    
    HomeArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithHexString:@"#FBFBFB"];
    UserInfoM *info = self.dataSource[indexPath.row];
    [cell reloadUIWithModel:info];
    WeakSelf(self);
    cell.clickUserInfo = ^{
        UserInfoVC *infoVC = [[UserInfoVC alloc]init];
        UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
        uInfo.actorId = [info.UID integerValue];
        infoVC.info =uInfo;
        infoVC.hidesBottomBarWhenPushed=YES;
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


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15,15,15,15);
}

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
