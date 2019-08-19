//
//  MyOrderProjectCellA.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//   购买方订单cell

#import <UIKit/UIKit.h>
#import "OrderProjectModel.h"

@protocol MyOrderProjectCellADelegate <NSObject>

//查看订单详情
-(void)lookOrderDetialWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag;

//查看项目
-(void)lookProjectWithIndexPath:(NSIndexPath*)indexPath;

//取消订单
-(void)cancleOrderWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag;

//确认完成订单
-(void)confrimFinishOrderWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag;

//再次确认档期
-(void)confrimSchedAgainOrderWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag;

//评价，查看评价
-(void)evaluateOrderWithIndexPath:(NSIndexPath*)indexPath;

//申请开票
-(void)applyforinvoiceWithIndexPath:(NSIndexPath*)indexPath;

//删除订单
-(void)delectOrderWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag;

//选中整个项目
-(void)selectAllProjectOrderWithIndexPath:(NSIndexPath*)indexPath withSelect:(BOOL)select;

//选中项目下的一个订单
-(void)selectOneOrderWithIndexPath:(NSIndexPath*)indexPath withTag:(NSInteger)tag withSelect:(BOOL)select;


@end

@interface MyOrderProjectCellA : UITableViewCell

@property(nonatomic,weak)id<MyOrderProjectCellADelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;


/**
 刷新cell数据
 @param model 项目数据模型
 */
-(void)reloadUIWithModel:(OrderProjectModel*)model;

@end

