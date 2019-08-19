//
//  ProjectCastingListVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/10.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "castingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProjectCastingListVC : UIViewController
@property(nonatomic,copy)NSString *vcTitle;
@property(nonatomic,assign)NSInteger type;//1选择角色，点击返回
@property(nonatomic,assign)BOOL fromAsk;
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,copy)void(^selectCasting)(CastingModel *casting);

@end

NS_ASSUME_NONNULL_END
