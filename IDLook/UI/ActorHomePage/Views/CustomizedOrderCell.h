//
//  CustomizedOrderCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomizedOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomizedOrderCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)CustomizedOrderModel *model;
@end

NS_ASSUME_NONNULL_END
