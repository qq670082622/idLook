//
//  SorceCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//积分明细cell

#import <UIKit/UIKit.h>
#import "SorceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SorceCell : UITableViewCell
@property(nonatomic,strong)SorceModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
