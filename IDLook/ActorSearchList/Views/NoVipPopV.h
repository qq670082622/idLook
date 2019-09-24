//
//  NoVipPopV.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoVipPopV : UIView
-(void)show;
@property(nonatomic,copy)void(^selectType)(NSString *type);
@end

NS_ASSUME_NONNULL_END
