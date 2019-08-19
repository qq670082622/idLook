//
//  ProjectMainTopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectMainTopV : UIView

@property(nonatomic,copy)void(^lookProjectdetialBlock)(void); //查看项目详情
@property(nonatomic,copy)void(^switchProjectBlock)(void);  //切换项目
@property(nonatomic,copy)void(^addNewProjectBlock)(void);  //新建项目
@property(nonatomic,copy)void(^serviceExplainBlock)(void);  //服务费说明

/**
 切换项目状态   0:询问档期。1:试镜。 2:锁定档期。3:定妆。4:拍摄。  5:授权书
 */
@property(nonatomic,copy)void(^switchProjectStateBlock)(NSInteger state);  //切换项目状态


/**
  根据类型加载ui
 @param type 0:无项目。1:有项目
 @param info 项目信息 type=1时传人信息
 @param state  类型
 */
-(void)reloadUIWithType:(NSInteger)type withProjectInfo:(NSDictionary*)info withState:(NSInteger)state;

@end

NS_ASSUME_NONNULL_END
