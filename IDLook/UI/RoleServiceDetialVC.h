//
//  RoleServiceDetialVC.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoleServiceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoleServiceDetialVC : UIViewController
@property(nonatomic,copy)void(^refreshDataBlock)(void);

@property(nonatomic,strong)RoleServiceModel *model;
@end

NS_ASSUME_NONNULL_END
