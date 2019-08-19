//
//  WordSearchVC.m
//  IDLook
//
//  Created by HYH on 2018/4/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "WordSearchVC.h"
#import "SearchHistoryView.h"
#import "HomeArtistCell.h"
#import "LookPricePopV2.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"
#import "PlaceShotOrderVC.h"
#import "PlaceAuditionOrderVC.h"
#import "UserModel.h"
static NSString *cellReuseIdentifer = @"cellReuseIdentifer";

@interface WordSearchVC ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SearchHistoryViewDelegate>
@property(nonatomic,strong)SearchHistoryView *historyView;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)CustomCollectV *collectionView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation WordSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationItem setTitleView:[CustomNavVC getSearchCustomViewWithTarget:self textfieldAction:@selector(textFieldDidChange:) ButtionAction:@selector(cancleAction)]];
    [self.navigationItem setHidesBackButton:YES];
    
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];
    
    self.textField = (UITextField*)[self.navigationItem.titleView viewWithTag:100];
    [self.textField becomeFirstResponder];
    
    [self historyView];
    
}

-(SearchHistoryView*)historyView
{
    if (!_historyView) {
        _historyView=[[SearchHistoryView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        [_historyView layoutIfNeeded];
        _historyView.delegate=self;
        [self.view addSubview:_historyView];
        
    }
    return _historyView;
}

-(CustomCollectV*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[CustomCollectV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsHorizontalScrollIndicator=NO;
        [_collectionView setBackgroundColor:Public_Background_Color];
        [_collectionView registerClass:[HomeArtistCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

//取消
-(void)cancleAction
{
    [self.textField resignFirstResponder];
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark---UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length<=0) {
        [SVProgressHUD showImage:nil status:@"请输入关键字"];
        return YES;
    }
    
    [textField resignFirstResponder];
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[UserInfoManager getSearchHistoryType]];
    if ([array containsObject:textField.text]) {
        [array removeObject:textField.text];
    }
    [array insertObject:textField.text atIndex:0];
    if (array.count>12) {
        [array removeLastObject];
    }
    [UserInfoManager setSearchHistory:array];
    
    self.historyView.hidden=YES;
    self.collectionView.hidden=NO;
    
    [self search];
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length<=0) {
        self.collectionView.hidden=YES;
        self.historyView.hidden=NO;
        [self.historyView refreshUI];
    }
}

#pragma mark--SearchHistoryViewDelegate
-(void)didClickType:(NSString *)type
{
    [self.textField resignFirstResponder];
    self.textField.text=type;
    self.historyView.hidden=YES;
    self.collectionView.hidden=NO;
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[UserInfoManager getSearchHistoryType]];
    if ([array containsObject:type]) {
        [array removeObject:type];
    }
    [array insertObject:type atIndex:0];
    
    if (array.count>12) {
        [array removeLastObject];
    }
    
    [UserInfoManager setSearchHistory:array];
    
    [self search];
    
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
    UserModel *info = self.dataSource[indexPath.row];
    [cell reloadUIWithModel:info];
    WeakSelf(self);
    cell.clickUserInfo = ^{
        [weakself.textField resignFirstResponder];
        
        UserInfoVC *infoVC = [[UserInfoVC alloc]init];
        UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
        uInfo.actorId = info.userId;
        infoVC.info =uInfo;
        [weakself.navigationController pushViewController:infoVC animated:YES];
    };
    cell.lookUserOffer = ^() {
        
        [weakself.textField resignFirstResponder];
        
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
-(NSMutableDictionary *)dicWithRule:(NSMutableArray *)rules andKey:(NSString *)key
{
    NSMutableDictionary *conditionDic = [NSMutableDictionary dictionary];
    [conditionDic setObject:key forKey:@"conditionName"];
    [conditionDic setObject:rules forKey:@"rules"];
    return conditionDic;
}
-(void)search
{
    [self.dataSource removeAllObjects];
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    if ([UserInfoManager getIsJavaService]) {//java后台
        NSDictionary *dicArg = @{@"keyword":self.textField.text,
                                 @"pageCount":@"100",
                                 @"pageNumber":@(1)};
        [AFWebAPI_JAVA searchAristKeywordWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                [SVProgressHUD dismiss];
                NSArray *array =[object objectForKey:JSON_body];
                for (int i =0; i<array.count; i++) {
                    NSDictionary *modelDic = array[i];
                    UserModel *info = [UserModel yy_modelWithDictionary:modelDic];
                    [self.dataSource addObject:info];
                }
                
                [self.collectionView hideNoDataScene];
                if (self.dataSource.count==0) {
                    [self.collectionView showWithNoDataType:NoDataTypeSearchResult];
                }
                [self.collectionView reloadData];
                [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:object];
                [self.collectionView hideNoDataScene];
                if (self.dataSource.count==0) {
                    [self.collectionView showWithNoDataType:NoDataTypeNetwork];
                }
            }
        }];

    }else{
   
    NSDictionary *dicArg = @{@"keyword":self.textField.text,
                             @"sortkey":@"0",
                             @"pagenumber":@(100)};
    [AFWebAPI searchAristKeywordWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array =[object objectForKey:JSON_data];
            for (int i =0; i<array.count; i++) {
                UserInfoM *info = [[UserInfoM alloc]initWithDic:array[i]];
                [self.dataSource addObject:info];
            }
            
            [self.collectionView hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.collectionView showWithNoDataType:NoDataTypeSearchResult];
            }
            [self.collectionView reloadData];
            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
            [self.collectionView hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.collectionView showWithNoDataType:NoDataTypeNetwork];
            }
        }
    }];
    }
}

//查看报价
-(void)lookUserPriceInfo:(UserModel *)info
{
    UserInfoM *infoM = [UserInfoM new];
    infoM.UID = [NSString stringWithFormat:@"%ld",info.userId];
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {
        [SVProgressHUD showImage:nil status:@"登录后可查看报价！"];
        return;
    }
    
    //未认证成功，跳到认证界面
    if ([UserInfoManager getUserAuthState]!=1) {
        [SVProgressHUD showImage:nil status:@"认证后可查看报价！"];
        return;
    }
    
    [SVProgressHUD showImage:nil status:@"正在读取报价信息"];
    NSDictionary *dicArg = @{@"userid":[NSString stringWithFormat:@"%ld",info.userId]};
    [AFWebAPI getQuotaListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array =[object objectForKey:JSON_data];
            if (array.count>0) {
                LookPricePopV2 *popV= [[LookPricePopV2 alloc]init];
                [popV showWithArray:array];
                popV.placeActionBlockWithAudition = ^(PriceModel * _Nonnull model) {
                    PlaceShotOrderVC *shotVC=[[PlaceShotOrderVC alloc]init];
                    model.day=1;
                 
                    shotVC.info=infoM;
                    shotVC.pModel=model;
                    [self.navigationController pushViewController:shotVC animated:YES];
                };
                
                popV.placeActionBlockWithScreening = ^(OrderStructM * _Nonnull model) {
                    PlaceAuditionOrderVC *auditVC = [[PlaceAuditionOrderVC alloc]init];
                    auditVC.info=infoM;
                    auditVC.sModel=model;
                    [self.navigationController pushViewController:auditVC animated:YES];
                };
                
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
