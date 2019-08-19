//
//  UserInfoVCM.m
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserInfoVCM.h"
#import "UserWorkModel.h"

NSString * const kUserInfoVCMCellClass =  @"kUserInfoVCMCellClass";
NSString * const kUserInfoVCMCellHeight = @"kUserInfoVCMCellHeight";
NSString * const kUserInfoVCMCellType =   @"kUserInfoVCMCellType";
NSString * const kUserInfoVCMCellData =   @"kUserInfoVCMCellData";

@interface UserInfoVCM ()
@property(nonatomic,strong)NSMutableArray *talentArray;
@end

@implementation UserInfoVCM

-(NSMutableArray*)talentArray
{
    if (!_talentArray) {
        _talentArray=[NSMutableArray new];
    }
    return _talentArray;
}

- (void)setInfo:(UserDetialInfoM *)info
{
    _info = info;
    [self refreshUserInfo];
    [self analyzeUserInfo];
}
- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(NSMutableArray*)typeDataSource
{
    if(!_typeDataSource)
    {
        _typeDataSource = [NSMutableArray new];
    }
    return _typeDataSource;
}

-(void)refreshUserInfo
{
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID],
                             @"actorId":@(_info.actorId)};
    [AFWebAPI_JAVA getUserInfoWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_body];
            _info = [[UserDetialInfoM alloc]initWithDic:dic];

            [self analyzeUserInfo];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

-(void)analyzeUserInfo
{
    [self.ds removeAllObjects];
    [self.typeDataSource removeAllObjects];
    NSMutableArray *pastworkList = [NSMutableArray new]; //过往作品
    NSMutableArray *introduceList = [NSMutableArray new]; //自我介绍
    NSMutableArray *talentList = [NSMutableArray new];  //试戏作品
    NSMutableArray *modelcardList= [NSMutableArray new];  //模特卡
    
    NSMutableArray *pastworkTypeList = [NSMutableArray new];  //过往作品类型
    NSMutableArray *introduceTypeList = [NSMutableArray new];  //自我介绍类型
    NSMutableArray *talentTypeList = [NSMutableArray new];    //试戏作品类型
    NSMutableArray *modelcardTypeList= [NSMutableArray new];  //模特卡类型

    for (int i =0; i<_info.worksList.count; i++) {
        NSDictionary *dic = _info.worksList[i];
        NSString *workType = dic[@"workType"];
        NSArray *tagList = dic[@"tagList"];
        NSArray *videoList = dic[@"videoList"];

        if ([workType isEqualToString:@"过往作品"]) {
            for (int j=0; j<videoList.count; j++) {
                UserWorkModel *model = [UserWorkModel yy_modelWithDictionary: videoList[j]];
                [pastworkList addObject:model];
            }
            [pastworkTypeList setArray:tagList];
        }
        else if ([workType isEqualToString:@"自我介绍"]) {
            for (int j=0; j<videoList.count; j++) {
                UserWorkModel *model = [UserWorkModel yy_modelWithDictionary: videoList[j]];
                [introduceList addObject:model];
            }
            [introduceTypeList setArray:tagList];
        }
        else if ([workType isEqualToString:@"试戏作品"]) {
            for (int j=0; j<videoList.count; j++) {
                UserWorkModel *model = [UserWorkModel yy_modelWithDictionary: videoList[j]];
                [talentList addObject:model];
            }
            [talentTypeList setArray:tagList];
        }
        else if ([workType isEqualToString:@"模特卡"]) {
            for (int j=0; j<videoList.count; j++) {
                UserWorkModel *model = [UserWorkModel yy_modelWithDictionary: videoList[j]];
                [modelcardList addObject:model];
            }
            [modelcardTypeList setArray:tagList];
        }
    }

    [self.ds addObject:pastworkList];
    [self.ds addObject:introduceList];
    [self.ds addObject:talentList];
    [self.ds addObject:modelcardList];
    
    [self.typeDataSource addObject:pastworkTypeList];
    [self.typeDataSource addObject:introduceTypeList];
    [self.typeDataSource addObject:talentTypeList];
    [self.typeDataSource addObject:modelcardTypeList];
    
    if(self.newDataNeedRefreshed)
    {
        self.newDataNeedRefreshed();
    }
}

@end
