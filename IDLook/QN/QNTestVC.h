
//  QNTestVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/2/13.
//  Copyright © 2019年 HYH. All rights reserved.


#import <UIKit/UIKit.h>
#import "QRDBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *cameraTag = @"camera";
static NSString *screenTag = @"screen";
@interface QNTestVC : UIViewController
@property(nonatomic,assign)NSInteger isCall;//是否是主动呼叫
@property(nonatomic,copy)NSString *hisName;
@property(nonatomic,copy)NSString *hisAvatar;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,assign)BOOL isBuyer;
@property(nonatomic,copy)NSString *roomName;
@end

NS_ASSUME_NONNULL_END
