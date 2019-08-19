//
//  ProjectOrderDetialVCM.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectOrderInfoM.h"

extern NSString * const kProjectOrderDetialVCMCellClass;    //cell类名_键
extern NSString * const kProjectOrderDetialVCMCellHeight;   //cell高度_键
extern NSString * const kProjectOrderDetialVCMCellType;     //cell类型_键
extern NSString * const kProjectOrderDetialVCMCellData;     //cell数据_键

typedef NS_ENUM(NSInteger,ProjectOrderDetialCellType)
{
    ProjectOrderDetialCellTypeState,    //状态
    ProjectOrderDetialCellTypeProjectInfo,   //项目信息
    ProjectOrderDetialCellTypeAskScheduleInfo,   ////询档信息,试镜信息，拍摄信息，定妆信息
    ProjectOrderDetialCellTypeInsurance,      //保险
    ProjectOrderDetialCellTypeScheduleGuarantee, //档期保障金
    ProjectOrderDetialCellTypeOrderInfo,         //订单信息
};

@interface ProjectOrderDetialVCM : NSObject
@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);
@property (nonatomic,strong)ProjectOrderInfoM *info;
@property(nonatomic,strong)NSMutableArray *ds;
-(void)refreshDataWithOrderId:(NSString*)orderId;

@end


