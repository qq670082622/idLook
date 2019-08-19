//
//  AnnunciateCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnunciateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AnnunciateCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)AnnunciateModel *model;
@property(nonatomic,copy)void(^apply)(AnnunciateModel *model);
@property(nonatomic,copy)void(^cellSelect)(AnnunciateModel *model);
@end

NS_ASSUME_NONNULL_END
