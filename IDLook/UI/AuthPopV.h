//
//  AuthPopV.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthPopV : UIView
@property(nonatomic,copy)void(^goAuthBlock)(void);

-(void)show;
@end

NS_ASSUME_NONNULL_END
