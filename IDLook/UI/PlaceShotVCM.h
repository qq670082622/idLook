//
//  PlaceShotVCM.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceOrderModel.h"
#import "ProjectModel.h"

extern NSString * const kPlaceShotVCMCellClass;    //cell类名_键
extern NSString * const kPlaceShotVCMCellHeight;   //cell高度_键
extern NSString * const kPlaceShotVCMCellData;     //cell数据_键

@interface PlaceShotVCM : NSObject
@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);
@property(nonatomic,strong)OrderStructM *orderInfo;
@property(nonatomic,strong)UserInfoM *info;
@property(nonatomic,strong)NSMutableArray *ds;

/**
 刷新数据
 */
- (void)refreshShotInfo;

/**
 添加项目筛选cell
 */
-(void)addItemRefreshCell;


/**
 项目cell刷新
 @param expend 是否展开
 @param model 项目模型
 */
-(void)isExpendItemWithValue:(BOOL)expend withProjectModel:(ProjectModel*)model;

/**
 下单类别选择刷新数据
 */
-(void)orderTypeRefreshUI;

@end

