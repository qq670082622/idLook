//
//  PlaceAuditionVCM.h
//  IDLook
//
//  Created by Mr Hu on 2018/12/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceOrderModel.h"
#import "ProjectModel.h"


extern NSString * const kPlaceAuditionVCMCellClass;    //cell类名_键
extern NSString * const kPlaceAuditionVCMCellHeight;   //cell高度_键
extern NSString * const kPlaceAuditionVCMCellData;     //cell数据_键

@interface PlaceAuditionVCM : NSObject

@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);
@property(nonatomic,strong)OrderStructM *orderInfo;
@property(nonatomic,strong)UserInfoM *info;
@property(nonatomic,strong)NSMutableArray *ds;


/**
 刷新数据
 */
- (void)refreshAuditionInfo;


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
   是否显示保险
 @param model 试镜方式model
 */
-(void)refreshInsuranceCellWithModel:(OrderStructM*)model;

@end

