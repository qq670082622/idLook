//
//  AuthChooseIdentityVC.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthChooseIdentityVC : UIViewController
@property(nonatomic,copy)void(^chooseIDTypeBlock)(NSInteger type ,NSString *name);
@end

NS_ASSUME_NONNULL_END
