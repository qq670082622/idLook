//
//  HistoryCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/5/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "historyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HistoryCell : UITableViewCell
@property(nonatomic,strong)historyModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,assign)CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
