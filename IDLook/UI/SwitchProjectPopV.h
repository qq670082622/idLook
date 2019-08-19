//
//  SwitchProjectPopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwitchProjectPopV : UIView

@property(nonatomic,copy)void(^switchProjectWithIdBlock)(NSString *projectId);  //切换项目

/**
 加载pop
 @param list 项目列表
 @param projectId 当前选中的项目
 */
- (void)showWithArray:(NSArray*)list withProjectId:(NSString*)projectId;

@end

NS_ASSUME_NONNULL_END
