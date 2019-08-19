//
//  ScriptPrivaryPopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/26.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScriptPrivaryPopV : UIView
@property(nonatomic,copy)void(^confrimOrder)(void);

-(void)show;
@end

NS_ASSUME_NONNULL_END
