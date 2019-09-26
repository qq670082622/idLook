//
//  ActorHomePageTopV.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/19.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActorHomePageTopV : UIView
@property(nonatomic,strong)UserDetialInfoM *model;
@property(nonatomic,copy)void(^introDetail)(void);
@property(nonatomic,copy)void(^checkGrade)(void);
@property(nonatomic,assign)NSInteger topVHei;
@end

NS_ASSUME_NONNULL_END
