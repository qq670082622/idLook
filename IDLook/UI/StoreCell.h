//
//  StoreCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//积分商品cell

#import <UIKit/UIKit.h>

#import "StoreModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol storeCellDelegate <NSObject>

-(void)selectWithModel:(StoreModel *)model;

@end
@interface StoreCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)StoreModel *model;
@property(nonatomic,assign)NSInteger totalSorce;
@property(nonatomic,weak)id<storeCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
