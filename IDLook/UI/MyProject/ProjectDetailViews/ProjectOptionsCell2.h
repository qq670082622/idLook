//
//  ProjectOptionsCell2.h
//  IDLook
//
//  Created by 吴铭 on 2019/7/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel2.h"
typedef NS_ENUM(NSInteger,optioncellActionType){
    optioncellActionTypeDays,       //拍摄天数
    optioncellActionTypeCity,      //拍摄城市
    optioncellActionTypedate,      //拍摄周期
    optioncellActionTypeUseTime,   //肖像使用时间
    optioncellActionTypeUseRange,  //肖像使用范围
};
NS_ASSUME_NONNULL_BEGIN
@protocol ProjectOptionsCell2Delegate <NSObject>
@optional
-(void)ProjectOptionsCell2SelectOptionWithType:(NSInteger)type andObj:(id)obj;

@end
@interface ProjectOptionsCell2 : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
//@property(nonatomic,copy)void(^actionType)(NSInteger actionType);
@property(nonatomic,strong)ProjectModel2 *model;
@property(nonatomic,weak)id<ProjectOptionsCell2Delegate>delegate;
@property(nonatomic,assign)BOOL checkStyle;//查看模式不需要加图片的addcell,并使蒙层btn覆盖所有UI
@end

NS_ASSUME_NONNULL_END
