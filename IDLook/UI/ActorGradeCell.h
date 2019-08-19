//
//  ActorGradeCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/5/6.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckGradeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActorGradeCell : UITableViewCell
@property(nonatomic,strong)CheckGradeModel *checkModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,assign)CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
