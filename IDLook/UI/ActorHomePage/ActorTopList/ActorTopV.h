//
//  ActorTopV.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActorTopV : UIView
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,copy)void(^selectPlat)(NSInteger plat);
@end

NS_ASSUME_NONNULL_END
