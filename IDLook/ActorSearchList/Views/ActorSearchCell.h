//
//  ActorSearchCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorSearchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActorSearchCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)ActorSearchModel *model;
@end

NS_ASSUME_NONNULL_END