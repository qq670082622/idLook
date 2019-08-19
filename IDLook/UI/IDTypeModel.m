//
//  IDTypeModel.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "IDTypeModel.h"

@implementation IDTypeModel

+(NSArray*)getData
{
    NSArray *array = @[@{@"UserSubTypeName":@"制作公司",
                         @"subType":@[@{@"UserSubType":@(UserSubTypePurProductionCompanyPhotography),@"UserSubTypeName":@"平面摄影"},
                                      @{@"UserSubType":@(UserSubTypePurProductionCompanyFilm),@"UserSubTypeName":@"影视制作"},
                                      @{@"UserSubType":@(UserSubTypePurProductionCompanyDesign),@"UserSubTypeName":@"设计公司"}]},
                       
                       @{@"UserSubTypeName":@"广告代理商",
                         @"subType":@[@{@"UserSubType":@(UserSubTypePurAdvertisingAgent),@"UserSubTypeName":@"广告代理"},
                                      @{@"UserSubType":@(UserSubTypePurAdvertisingAgentDigital),@"UserSubTypeName":@"digital数字营销"}]},
                       
                       @{@"UserSubTypeName":@"公关公司",
                         @"subType":@[@{@"UserSubType":@(UserSubTypePurRelationsService),@"UserSubTypeName":@"公关服务"},
                                      @{@"UserSubType":@(UserSubTypePurRelationsEconomy),@"UserSubTypeName":@"公关经纪"}]},
                       
                       @{@"UserSubTypeName":@"活动公司",
                         @"subType":@[@{@"UserSubType":@(UserSubTypePurEventPlanning),@"UserSubTypeName":@"活动策划"},
                                      @{@"UserSubType":@(UserSubTypePurActivityService),@"UserSubTypeName":@"活动服务"}]},
                       
                       @{@"UserSubTypeName":@"企业品牌部/策划部/市场部",
                         @"subType":@[@{@"UserSubType":@(UserSubTypePurBusinessBrand),@"UserSubTypeName":@"企业品牌部/策划部/市场部"}]}];
    
    NSMutableArray *dataSource = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        IDTypeStructModel *model = [[IDTypeStructModel alloc]init];
        model.title=dic[@"UserSubTypeName"];
        model.isShowRow=NO;
        model.array = dic[@"subType"];
        if (model.array.count>1) {
            model.isShowArrow=YES;
        }
        else
        {
            model.isShowArrow=NO;
        }
        
        [dataSource addObject:model];
    }
    return dataSource;
}

@end


@implementation IDTypeStructModel



@end
