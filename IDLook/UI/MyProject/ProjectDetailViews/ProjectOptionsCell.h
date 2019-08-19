//
//  ProjectOptionsCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//拍摄项目的选项cell

#import <UIKit/UIKit.h>
#import "ProjectModel2.h"
typedef NS_ENUM(NSInteger,actionType){
    actionTypeDays,       //拍摄天数
    actionTypeCity,      //拍摄城市
    actionTypeStartDay,  //开始日期
    actionTypeEndDay,    //结束日期
    actionTypeUseTime,   //肖像使用时间
    actionTypeUseRange,  //肖像使用范围
};
NS_ASSUME_NONNULL_BEGIN
@protocol ProjectOptionsCellDelegate <NSObject>
@optional
-(void)ProjectOptionsCellSelectOptionWithType:(NSInteger)type;

@end
@interface ProjectOptionsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,copy)void(^actionType)(NSInteger actionType);
@property(nonatomic,strong)ProjectModel2 *model;
@property(nonatomic,weak)id<ProjectOptionsCellDelegate>delegate;
@property(nonatomic,assign)BOOL checkStyle;//查看模式不需要加图片的addcell,并使蒙层btn覆盖所有UI
@end

NS_ASSUME_NONNULL_END
