//
//  UserInfoVCM.h
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kUserInfoVCMCellClass;    //cell类名_键
extern NSString * const kUserInfoVCMCellHeight;   //cell高度_键
extern NSString * const kUserInfoVCMCellType;     //cell类型_键
extern NSString * const kUserInfoVCMCellData;     //cell数据_键


typedef NS_ENUM(NSInteger,UserInfoCellType)
{
    UserInfoCellTypePerformType,          //表演类型
    UserInfoCellTypeTalentshow,          //才艺展示
    UserInfoCellTypePastWorkPhoto,       //过往作品图片
    UserInfoCellTypePastWorkVideo,       //过往作品视频
    UserInfoCellTypeMirrorPhoto,        //微出镜授权图片
    UserInfoCellTypeMirrorVideo,        //微出镜授权视频
    UserInfoCellTypeTrialWorks,         //试葩间视频
    UserInfoCellTypeIntroduce,            //自我介绍
    UserInfoCellTypeModelcard           //模特卡
};

@interface UserInfoVCM : NSObject

@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);

@property(nonatomic,strong)UserDetialInfoM *info;
@property(nonatomic,strong)NSMutableArray *ds;
@property(nonatomic,strong)NSMutableArray *typeDataSource;  //类型标签数据
- (void)refreshUserInfo;

@end
