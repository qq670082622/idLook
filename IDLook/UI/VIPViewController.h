//
//  VIPViewController.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/28.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VIPViewController : UIViewController
@property(nonatomic,copy)void(^reloadUI)(void);
@end

NS_ASSUME_NONNULL_END
