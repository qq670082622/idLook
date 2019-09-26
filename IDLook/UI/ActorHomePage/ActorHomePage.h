//
//  ActorHomePage.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/19.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActorHomePage : UIViewController
@property(nonatomic,assign)NSInteger actorId;
@property(nonatomic,strong)UserDetialInfoM *userModel;
@property(nonatomic,copy)void(^reModel)(NSString *type,BOOL isTure);
@end

NS_ASSUME_NONNULL_END
