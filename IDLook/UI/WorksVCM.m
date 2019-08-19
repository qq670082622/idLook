//
//  WorksVCM.m
//  IDLook
//
//  Created by HYH on 2018/5/30.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "WorksVCM.h"

@implementation WorksVCM

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [[NSMutableArray alloc]initWithObjects:@[],@[],@[],@[], nil];
    }
    return _ds;
}

- (NSMutableArray *)selectDatasource
{
    if(!_selectDatasource)
    {
        _selectDatasource = [NSMutableArray new];
    }
    return _selectDatasource;
}

-(void)refreshWorksInfo
{

     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dicArg=@{@"userid":[UserInfoManager getUserUID],
                           @"type":@"1,4,5"
                           };

    [AFWebAPI getWorksModelcardMirrorList:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];

            [self analyzeDataWithDic:[object objectForKey:JSON_data]];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
}

-(void)analyzeDataWithDic:(NSDictionary*)dic
{
    [self.ds removeAllObjects];
    
    NSMutableArray *sec0 = [NSMutableArray new];
    NSMutableArray *sec1 = [NSMutableArray new];
    NSMutableArray *sec2 = [NSMutableArray new];
    NSMutableArray *sec3 = [NSMutableArray new];
    
     //试戏作品
    {
        NSArray *worksList = (NSArray*)safeObjectForKey(dic, @"talentshow");
        for (int i=0; i<worksList.count; i++) {
            NSDictionary *dic = worksList[i];
            NSArray *array = dic[@"list"];
            NSMutableArray *Arr = [[NSMutableArray alloc]initWithCapacity:0];
            for (int j=0; j<array.count; j++) {
                WorksModel *model = [[WorksModel alloc]initWithWorksDic:array[j]];
                model.workType=WorkTypePerformance;
                [Arr addObject:model];
            }
            [sec0 addObject:Arr];
        }
    }
    
    //过往作品
    {
        NSArray *pastWorksPhotoArray=  (NSArray*)safeObjectForKey(dic, @"pastWorksImg");
        NSArray *pastWorksVideoArray= (NSArray*)safeObjectForKey(dic, @"pastWorksVdo");
        self.pastworkVideoCount=pastWorksVideoArray.count;
        
        for (int i = 0 ;i<pastWorksVideoArray.count; i++)
        {
            NSMutableArray *array2 = [[NSMutableArray alloc]initWithCapacity:0];
            
            NSDictionary *dic = pastWorksVideoArray[i];
            NSArray *array = dic[@"lists"];
            for (int j=0; j<array.count; j++) {
                WorksModel *model = [[WorksModel alloc]initWithPastWorkDic:array[j]];
                model.workType=WorkTypePastworks;
                [array2 addObject:model];
            }
            [sec1 addObject:array2];
        }
        
        for (int i = 0 ;i<pastWorksPhotoArray.count; i++)
        {
            NSMutableArray *array1 = [[NSMutableArray alloc]initWithCapacity:0];
            NSDictionary *dic = pastWorksPhotoArray[i];
            NSArray *array = dic[@"lists"];
            for (int j=0; j<array.count; j++) {
                WorksModel *model = [[WorksModel alloc]initWithPastWorkDic:array[j]];
                model.workType=WorkTypePastworks;
                [array1 addObject:model];
            }
            [sec1 addObject:array1];
        }
    }
    
    //自我介绍
    {
        NSArray *introductList = (NSArray*)safeObjectForKey(dic, @"selfintroduction");
        for (int i=0; i<introductList.count; i++) {
            NSDictionary *dic = introductList[i];
            NSArray *array = dic[@"list"];
            NSMutableArray *Arr = [[NSMutableArray alloc]initWithCapacity:0];
            for (int j=0; j<array.count; j++) {
                WorksModel *model = [[WorksModel alloc]initModelCardDic:array[j]];
                model.workType=WorkTypeIntroduction;
                [Arr addObject:model];
            }
            [sec2 addObject:Arr];
        }
    }
    
    //模特卡
    {
        NSArray *mordcardList =(NSArray*)safeObjectForKey(dic, @"modelcard");
        for (int i=0; i<mordcardList.count; i++) {
            NSDictionary *dic = mordcardList[i];
            NSArray *array = dic[@"list"];
            NSMutableArray *Arr = [[NSMutableArray alloc]initWithCapacity:0];
            for (int j=0; j<array.count; j++) {
                WorksModel *model = [[WorksModel alloc]initModelCardDic:array[j]];
                model.workType=WorkTypeMordCard;
                [Arr addObject:model];
            }
            [sec3 addObject:Arr];
        }
    }
    
    [self.ds addObject:sec0];
    [self.ds addObject:sec1];
    [self.ds addObject:sec2];
    [self.ds addObject:sec3];

    if (self.refreshUIAction) {
        self.refreshUIAction(YES);
    }
}


//删除作品或者微出镜，试葩间
-(void)delectWorksWithType:(NSInteger)type
{
    //遍历得到id数组
    NSArray *array = self.selectDatasource;
    NSMutableArray *idArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i<array.count; i++) {
        WorksModel *model =array[i];
        [idArr addObject:model.creativeid];
    }
    NSString *idStr = [idArr componentsJoinedByString:@","];
    
    if (type==0) {
        NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                                 @"creativeid":idStr,
                                 @"type":type==0?@(1):@(2)};
        
        [AFWebAPI setDelectWroks:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                
                NSDictionary *dic = (NSDictionary*)safeObjectForKey(object, JSON_data);
                [self analyzeDelectDataWithDic:dic withType:type];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    else
    {
        NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                                 @"creativeid":idStr};
        
        [AFWebAPI delectPastWorkAndTalWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                
                NSDictionary *dic = (NSDictionary*)safeObjectForKey(object, JSON_data);
                [self analyzeDelectDataWithDic:dic withType:type];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
}

-(void)analyzeDelectDataWithDic:(NSDictionary*)dic withType:(NSInteger)type
{

    NSMutableArray *datas = [[NSMutableArray alloc]initWithCapacity:0];
    if (type==0) {
        NSArray *worksList=(NSArray*)safeObjectForKey(dic, @"talentshow");
        
        for (int i=0; i<worksList.count; i++) {
            NSDictionary *dic = worksList[i];
            NSArray *array = dic[@"list"];
            NSMutableArray *Arr = [[NSMutableArray alloc]initWithCapacity:0];
            for (int j=0; j<array.count; j++) {
                WorksModel *model = [[WorksModel alloc]initWithWorksDic:array[j]];
                [Arr addObject:model];
            }
            [datas addObject:Arr];
        }
    }
    else if(type==1)
    {
        NSArray *talentList= dic[@"acqierement"];   //才艺展示
        NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
        
        for (int i = 0 ;i<talentList.count; i++)
        {
            WorksModel *model = [[WorksModel alloc]initWithPastWorkDic:talentList[i]];
            [array addObject:model];
        }
        
        if (array.count) {
            [datas addObject:array];
        }

    }
    else if (type==2)
    {
        NSArray *pastWorksPhotoArray= dic[@"pastWorksImg"];
        NSArray *pastWorksVideoArray= dic[@"pastWorksVdo"];
        
        NSMutableArray *array1 = [[NSMutableArray alloc]initWithCapacity:0];
        NSMutableArray *array2 = [[NSMutableArray alloc]initWithCapacity:0];
        
        for (int i = 0 ;i<pastWorksPhotoArray.count; i++)
        {
            WorksModel *model = [[WorksModel alloc]initWithPastWorkDic:pastWorksPhotoArray[i]];
            model.type=@"图片";
            [array1 addObject:model];
        }
        
        for (int i = 0 ;i<pastWorksVideoArray.count; i++)
        {
            WorksModel *model = [[WorksModel alloc]initWithPastWorkDic:pastWorksVideoArray[i]];
            model.type=@"视频";
            [array2 addObject:model];
        }
        
        if (array1.count) {
            [datas addObject:array1];
        }
        
        if (array2.count) {
            [datas addObject:array2];
        }

    }
    
    [self.ds replaceObjectAtIndex:type withObject:datas];
    
    if (self.refreshUIAction) {
        self.refreshUIAction(NO);
    }
}


//编辑状态
-(void)getEditStateWithTag:(NSInteger)tag withEdit:(BOOL)edit
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.ds[tag]];
    
    for (int i = 0 ; i<array.count; i++) {
        NSMutableArray *arr= [[NSMutableArray alloc]initWithArray:array[i]];
        
        for (int j =0; j<arr.count; j++) {
            WorksModel *model = (WorksModel*)arr[j];
            model.isEdit=edit;
        }
    }
}

//全选,取消
-(void)allChooseWithTag:(NSInteger)tag withSelect:(BOOL)select
{
    [self.selectDatasource removeAllObjects];
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.ds[tag]];
    
    for (int i = 0 ; i<array.count; i++)
    {
        NSMutableArray *arr= [[NSMutableArray alloc]initWithArray:array[i]];
        for (int j =0; j<arr.count; j++) {
            WorksModel *model = (WorksModel*)arr[j];
            model.isSelect=select;
            if (select) {
                [self.selectDatasource addObject:model];
            }
        }
    }
}

//改变一条数据
-(void)changeoneDataWithTag:(NSInteger)tag withIndaxPath:(NSIndexPath*)indexPath withSelect:(BOOL)select
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.ds[tag]];
    NSMutableArray *arr= [[NSMutableArray alloc]initWithArray:array[indexPath.section]];
    WorksModel *model = (WorksModel*)arr[indexPath.row];
    model.isSelect=select;
    
    if (select) {
        [self.selectDatasource addObject:model];
    }
    else
    {
        if ([self.selectDatasource containsObject:model]) {
            [self.selectDatasource removeObject:model];
        }
    }
}

//是否全选中
-(BOOL)isAllChooseWithTag:(NSInteger)tag
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.ds[tag]];
    
    for (int i = 0 ; i<array.count; i++) {
        NSMutableArray *arr= [[NSMutableArray alloc]initWithArray:array[i]];
        
        for (int j =0; j<arr.count; j++) {
            WorksModel *model = (WorksModel*)arr[j];
            if (model.isSelect==NO) {
                return NO;
            }
        }
    }
    return YES;
}

@end
