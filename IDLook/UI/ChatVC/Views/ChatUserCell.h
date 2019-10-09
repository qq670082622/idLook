//
//  ChatUserCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/10/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatUserCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)ChatModel *model;
@end

NS_ASSUME_NONNULL_END
