//
//  CheckGradeCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//查看评价cell

#import <UIKit/UIKit.h>
#import "CheckGradeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckGradeCell : UITableViewCell
@property(nonatomic,strong)CheckGradeModel *checkModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,copy)void(^moreAction)(void);
@property(nonatomic,copy)void(^userInfoAction)(void);
@property(nonatomic,assign)CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
