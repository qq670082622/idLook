//
//  ActorTopCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorTopModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActorTopCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)ActorTopModel *model;
@end

NS_ASSUME_NONNULL_END
