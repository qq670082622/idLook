//
//  CastingCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/10.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CastingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CastingCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)CastingModel *model;
@property(nonatomic,copy)void(^cellAction)(CastingModel *model);
@end

NS_ASSUME_NONNULL_END
