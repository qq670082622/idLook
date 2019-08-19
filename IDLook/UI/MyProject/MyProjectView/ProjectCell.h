//
//  ProjectCell.h
//  IDLook
//
//  Created by 吴铭 on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//项目列表的cell

#import <UIKit/UIKit.h>
#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,copy)void(^btnClicked)(NSString *clickType);
@property(nonatomic,assign)BOOL isSelectType;

@property(nonatomic,strong) ProjectModel *model;
@end

NS_ASSUME_NONNULL_END
