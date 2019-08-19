//
//  ProjectNumberCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//项目编号

#import <UIKit/UIKit.h>
#import "ProjectModel2.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProjectNumberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *tipsView;
@property (weak, nonatomic) IBOutlet UILabel *projectNumLab;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)ProjectModel2 *model;
@property(nonatomic,assign)BOOL canEdit;
@end

NS_ASSUME_NONNULL_END
