//
//  BuyerHomeCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyerConditionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuyerHomeCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)BuyerConditionModel *model;
@property(nonatomic,assign)CGFloat cellHei;
@property(nonatomic,copy)void(^cellSelectCondition)(BuyerConditionModel *model);
@property(nonatomic,copy)void(^reloadCell)(BuyerConditionModel *model);
@end

NS_ASSUME_NONNULL_END
