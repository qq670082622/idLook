//
//  AskCastingCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CastingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AskCastingCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)CastingModel *model;
@property(nonatomic,copy)void(^otherSelect)(void);
@end

NS_ASSUME_NONNULL_END
