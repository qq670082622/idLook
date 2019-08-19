//
//  ProjectCastingAddVC2.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CastingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProjectCastingAddVC2 : UIViewController
@property(nonatomic,strong)CastingModel *model;
@property(nonatomic,copy)void(^VCAdd)(CastingModel *infoModel,NSInteger type);
@property(nonatomic,assign)NSInteger type;//1新建 2编辑
@property(nonatomic,assign)BOOL fromAsk;//从询档进来的话，直接在里面新建或者编辑角色的接口操作
@property(nonatomic,copy)NSString *projectId;
@end

NS_ASSUME_NONNULL_END
