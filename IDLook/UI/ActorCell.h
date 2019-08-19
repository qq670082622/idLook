//
//  ActorCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"


@interface ActorCell : UITableViewCell<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,copy)void(^clickUserInfo)(void);  //点击头像进入用户主页
@property(nonatomic,copy)void(^selectType)(NSString *typeString);//点击标签
@property(nonatomic,copy)void(^playVideWithUrl)(WorksModel *workModel,NSInteger videoPage);  //播放视频
@property(nonatomic,copy)void(^lookPicture)(WorksModel *workModel,NSInteger index);  //查看大图
@property(nonatomic,copy)void(^endDeceleratingBlock)(void);  //停止滑动
@property(nonatomic,copy)NSString *typeContent;
@property(nonatomic,strong) UserModel *model;
//-(void)reloadUIWithModel:(UserInfoM *)model withSelect:(NSString*)select;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(void)reloadOtherVideoViews;//为了避免老手机滑动时加载太多视图导致卡顿而产生的函数
@property(nonatomic,assign)NSInteger index_row;//因为首次加载列表没有滑动导致第一个、第二个cell非第一个多媒体内容未加载
@end


