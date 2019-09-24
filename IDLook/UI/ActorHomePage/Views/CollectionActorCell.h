//
//  CollectionActorCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorSearchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectionActorCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)ActorSearchModel *model;
@property(nonatomic,assign)BOOL noSystem;
@end

NS_ASSUME_NONNULL_END
