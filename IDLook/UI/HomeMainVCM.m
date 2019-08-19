//
//  HomeMainVCM.m
//  IDLook
//
//  Created by HYH on 2018/7/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeMainVCM.h"
#import "UserModel.h"
NSString * const kHomeVCMCellClass =  @"kHomeVCMCellClass";
NSString * const kHomeVCMCellHeight = @"kHomeVCMCellHeight";
NSString * const kHomeVCMCellType =   @"kHomeVCMCellType";
NSString * const kHomeVCMCellData =   @"kHomeVCMCellData";

@implementation HomeMainVCM

-(id)init
{
    if (self=[super init]) {
        [self refreshHomeInfoWithSortPage:1 withRefreshType:RefreshTypePullDown];
        [self analyzeHomeInfoWithArray:nil];
    }
    return self;
}

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(void)refreshHomeInfoWithSortPage:(NSInteger)sortpage withRefreshType:(RefreshType)type
{
    if ([UserInfoManager getIsJavaService]) {
        NSDictionary *dicArg = @{@"pageCount":@(30),
                                 @"pageNumber":@(sortpage),
                                 @"source":@(1)
                                 };
        [AFWebAPI_JAVA getHomeRecommendWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSArray *array= [object objectForKey:@"body"];
                if (![array isKindOfClass:[NSArray class]]) {
                    return;
                }
                
                if (type==RefreshTypePullDown) {
                    [self.ds removeAllObjects];
                }
                
                [self analyzeHomeInfoWithArray:array];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取首页list信息失败"]; //后端这个接口间歇性报错，很挫 所以不提示
            }
        }];
    }else{
    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                             @"sortpage":@(sortpage),
                             @"pagenumber":@(30)
                             };
    [AFWebAPI getHomeRecommendWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            NSArray *array= [object objectForKey:JSON_data];
            if (![array isKindOfClass:[NSArray class]]) {
                return;
            }
            
            if (type==RefreshTypePullDown) {
                [self.ds removeAllObjects];
            }
            
            [self analyzeHomeInfoWithArray:array];
        }
        else
        {
            if(self.newDataNeedRefreshed)
            {
                self.newDataNeedRefreshed(NO);
            }
            AF_SHOW_RESULT_ERROR
        }
    }];
    }
    if (type==RefreshTypePullDown) {
        
        if ([UserInfoManager getIsJavaService]) {
            NSDictionary *dicArg = @{@"userType":@([UserInfoManager getUserType])};
            [AFWebAPI_JAVA getAppBannerWithArg:dicArg callBack:^(BOOL success, id object) {
                if (success) {
                    self.bannerArray = [[object objectForKey:JSON_body] objectForKey:@"bannerList"];
                }
                else
                {
                   // [SVProgressHUD showErrorWithStatus:@"首页下拉刷新获取信息失败"]; 后端这个接口间歇性报错，很挫 所以不提示
                }
                if (self.refreshBanner) {
                    self.refreshBanner(success);
                }
            }];
        }
        else
        {
        
        NSDictionary *dicArg = @{@"type":@([UserInfoManager getUserType])};
        [AFWebAPI getAppBannerWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                self.bannerArray = [object objectForKey:JSON_data];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
            if (self.refreshBanner) {
                self.refreshBanner(success);
            }
        }];
        }
    }
}

-(void)analyzeHomeInfoWithArray:(NSArray*)array
{
    
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
       // UserInfoM *model = [[UserInfoM alloc]initWithDic:dic];
        UserModel *userModel = [UserModel yy_modelWithDictionary:dic];
        [self.ds addObject:userModel];
    }
    
    if(self.newDataNeedRefreshed)
    {
        self.newDataNeedRefreshed(YES);
    }
}

@end
