//
//  ProjectScreenCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/4.
//  Copyright © 2019年 HYH. All rights reserved.
//专门针对试镜项目的选项类的cell

#import <UIKit/UIKit.h>
#import "ProjectModel.h"
typedef NS_ENUM(NSInteger,screenActionType){
    TypeLatestDay,  //最晚上传作品日期
    TypeShootDays,  //拍摄天数
    TypeCity,       //拍摄城市
    TypeStartDay,   //开始日期
    TypeEndDay,     //结束日期
    
};
NS_ASSUME_NONNULL_BEGIN
@protocol ProjectScreenCellDelegate <NSObject>

-(void)ProjectScreenCellSelectOptionWithType:(NSInteger)type;

@end

@interface ProjectScreenCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,weak)id<ProjectScreenCellDelegate>delegate;
@property(nonatomic,strong)ProjectModel *model;
@property(nonatomic,assign)BOOL checkStyle;//查看模式不需要加图片的addcell,并使蒙层btn覆盖所有UI
@end

NS_ASSUME_NONNULL_END
