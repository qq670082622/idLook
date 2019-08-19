//
//  ProjectCastingCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//角色的整个cell

#import <UIKit/UIKit.h>
#import "Castingmodel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ProjectCastingCellDelegate <NSObject>
@optional
//点击角色进行编辑的代理
-(void)castingActionWithInfo:(CastingModel *)model;
-(void)castingAdd;
@end
@interface ProjectCastingCell : UITableViewCell
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,weak)id<ProjectCastingCellDelegate>delegate;
+(CGFloat)castingCellHeightWithCastingsCount:(NSInteger)count;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,assign)BOOL checkStyle;
@end

NS_ASSUME_NONNULL_END
