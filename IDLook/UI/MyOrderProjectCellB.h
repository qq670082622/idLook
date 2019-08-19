//
//  MyOrderProjectCellB.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/9.
//  Copyright © 2019年 HYH. All rights reserved.
//。 资源方订单cell

#import <UIKit/UIKit.h>
#import "OrderProjectModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol MyOrderProjectCellBDelegate <NSObject>

//接单
-(void)acceptOrderWithIndexPath:(NSIndexPath*)indexPath;

//确认档期
-(void)confrimScheduleWithIndexPath:(NSIndexPath*)indexPath;

//上传试镜视频
-(void)uploadVideoWithIndexPath:(NSIndexPath*)indexPath;

////发起在线试镜
//-(void)videoOnLineWithIndexPath:(NSIndexPath *)indexPath;
//修改在线试镜时间
-(void)modifyAuditionTimeWithIndexPath:(NSIndexPath *)indexPath;
//拒单
-(void)rejectOrderWithIndexPath:(NSIndexPath*)indexPath;

@end

@interface MyOrderProjectCellB : UITableViewCell
@property(nonatomic,weak)id<MyOrderProjectCellBDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;

/**
 刷新cell数据
 @param model 项目数据模型
 */
-(void)reloadUIWithModel:(OrderProjectModel*)model;
@end

NS_ASSUME_NONNULL_END
