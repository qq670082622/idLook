//
//  PriceMainCell.h
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"

@interface PriceMainCell : UITableViewCell
//-(void)reloadUIWithModel:(PriceModel*)model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)PriceModel *model;
@end