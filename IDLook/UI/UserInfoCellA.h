//
//  UserInfoCellA.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoVCM.h"
#import "WorksModel.h"
#import "WorksModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoCellA : UITableViewCell
@property(nonatomic,copy)void(^pastworkCutPhotoAndVideo)(NSInteger type); //过往作品图片，视频切换
@property(nonatomic,copy)void(^lookPastworkBigPhoto)(NSArray *array,NSInteger index);  //查看过往作品图片
@property(nonatomic,copy)void(^playVideoWithArray)(NSArray *array,NSInteger index);  //播放视频

-(void)reloadUIWithArray:(NSArray*)array withType:(UserInfoCellType)type witPastworkType:(NSInteger)pastworkType;
@end

@interface UserInfoVideoSubCell : UITableViewCell
-(void)reloadUIWithPastworkModel:(WorksModel*)model;
-(void)reloadUIWithWorksModel:(WorksModel*)model;

@end

@interface UserInfoPhotoSubCell : UITableViewCell
-(void)reloadUIWithPastworkModel:(WorksModel*)model;

@end

NS_ASSUME_NONNULL_END
