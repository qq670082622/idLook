//
//  ProjectMainVC+Action.h
//  IDLook
//
//  Created by Mr Hu on 2019/5/27.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectMainVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectMainVC (Action)

/**
 cell底部按钮点击事件
 @param type 按钮类型
 @param info 项目信息
 @param projectInfo 项目信息
 */
-(void)BottomButtonAction:(NSInteger)type withProjectInfo:(ProjectOrderInfoM*)info withProjectDic:(NSDictionary*)projectInfo;


@end

NS_ASSUME_NONNULL_END
