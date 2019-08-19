//
//  AskDescCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel2.h"
#import "mediaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AskDescCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(CGFloat)reloadUIWithArray:(NSArray *)array;
@property(nonatomic,strong)ProjectModel2 *model;
@property(nonatomic,copy)void(^otherSelect)(void);
@property(nonatomic,assign)NSInteger cellHeight;
@end

NS_ASSUME_NONNULL_END
