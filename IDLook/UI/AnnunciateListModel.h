//
//  AnnunciateListModel.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnunciateListModel : NSObject

/**
 报名ID
 */
@property(nonatomic,assign)NSInteger applyId;

/**
 片酬
 */
@property(nonatomic,strong)NSNumber *price;

/**
 入选角色
 */
@property(nonatomic,copy)NSString *roleName;

/**
 拍摄城市
 */
@property(nonatomic,copy)NSString *shotCity;

/**
 拍摄结束日期。格式：yyyy-MM-dd
 */
@property(nonatomic,copy)NSString *shotEndDate;

/**
 拍摄开始日期。格式：yyyy-MM-dd
 */
@property(nonatomic,copy)NSString *shotStartDate;

/**
 状态。1:已选中; 2=未选中; 3=进行中
 */
@property(nonatomic,assign)NSInteger status;

/**
 拍摄标题
 */
@property(nonatomic,copy)NSString *title;

/**
 肖像周期
 */
@property(nonatomic,assign)NSInteger shotCycle;

/**
 肖像范围
 */
@property(nonatomic,copy)NSString *shotRegion;

@end

NS_ASSUME_NONNULL_END
