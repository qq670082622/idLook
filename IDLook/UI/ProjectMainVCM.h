//
//  ProjectMainVCM.h
//  IDLook
//
//  Created by Mr Hu on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectOrderInfoM.h"


@interface ProjectMainVCM : NSObject
@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);

@property(nonatomic,strong)NSMutableArray *ds;

/**
 项目信息
 */
@property(nonatomic,strong)NSDictionary *projectInfo;


/**
 查看最新项目
 @param projectId 如果传空值，则查询最近操作的项目；如果传项目编号，则查询指定的项目
 */
-(void)getNewProjectWithProjectId:(NSString*)projectId;


/**
 根据订单信息得到cell高度
 @param info 订单信息
 */
-(CGFloat)getCellHeightWithOrderInfo:(ProjectOrderInfoM*)info;




@end

