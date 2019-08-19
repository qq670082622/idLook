//
//  ScheduleLockVC.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleLockVC : UIViewController
@property (nonatomic,strong)ProjectOrderInfoM *info;
@property (nonatomic,strong)NSDictionary *projectInfo;
@end

NS_ASSUME_NONNULL_END
