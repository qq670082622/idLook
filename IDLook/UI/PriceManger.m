//
//  PriceManger.m
//  IDLook
//
//  Created by HYH on 2018/7/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PriceManger.h"
#import "PriceModel.h"

@implementation PriceManger

-(id)init
{
    if (self=[super init]) {
        [self refreshPriceInfo];
        [self analyzePriceInfoWithArray:nil];
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


-(void)refreshPriceInfo
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
     if ([UserInfoManager getIsJavaService]) {//java后台
         NSMutableDictionary *dicArg = [NSMutableDictionary new];
         [dicArg setObject:[UserInfoManager getUserUID] forKey:@"userId"];
         [AFWebAPI_JAVA getMyQuotaListWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
             if (success) {
                 [SVProgressHUD dismiss];
                 [self.ds removeAllObjects];
                 NSDictionary *dic =[object objectForKey:JSON_body];
                 NSArray *dicArr = dic[@"priceList"];
                 [self.ds addObjectsFromArray:dicArr];
                 if (self.newDataNeedRefreshed) {
                     self.newDataNeedRefreshed();
                 }
             }else{
                 [SVProgressHUD showErrorWithStatus:object];
             }
         }];
     }else{
    NSMutableDictionary *dicArg = [NSMutableDictionary new];
  [dicArg setObject:[UserInfoManager getUserUID] forKey:@"userid"];
 [AFWebAPI getQuotaListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array =[object objectForKey:JSON_data];
            [self analyzePriceInfoWithArray:array];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
     }
}

-(void)analyzePriceInfoWithArray:(NSArray*)array
{
    [self.ds removeAllObjects];
    
    NSMutableArray *sec1 = [NSMutableArray new];
    NSMutableArray *sec2 = [NSMutableArray new];
    NSMutableArray *sec3 = [NSMutableArray new];
    
    for (int i =0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        PriceModel *model = [[PriceModel alloc]initWithDic:dic];
        if (model.type==1) {
            [sec1 addObject:model];
        }
        else if (model.type==2)
        {
            [sec2 addObject:model];
        }
        else if (model.type==3)
        {
            [sec3 addObject:model];
        }
    }
    
    if (sec1.count) {
        
        [self.ds addObject:@{@"title":@"视频广告",@"data":[self sortArray:sec1]}];
    }
    if (sec2.count) {
        [self.ds addObject:@{@"title":@"平面广告",@"data":[self sortArray:sec2]}];
    }
    if (sec3.count) {
        [self.ds addObject:@{@"title":@"活动广告",@"data":[self sortArray:sec3]}];
    }
    
    if (self.newDataNeedRefreshed) {
        self.newDataNeedRefreshed();
    }
   
}

-(NSArray *)sortArray:(NSArray *)array
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"subType" ascending:YES];
    //这个数组保存的是排序好的对象
    NSArray *tempArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];//升序排列
    return tempArray;
}
@end
