//
//  CollectionActorView.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorSearchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectionActorView : UIView
-(void)showWithSelectActors:(NSArray *)actorArr noSystemId:(NSInteger)Id; //已经选中的第一个演员不显示 面的错乱
@property(nonatomic,copy)void(^selectActors)(NSArray *arr);
@end

NS_ASSUME_NONNULL_END
