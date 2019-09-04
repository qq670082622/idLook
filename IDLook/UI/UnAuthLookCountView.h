//
//  UnAuthLookCountView.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/30.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnAuthLookCountView : UIView
-(void)showWithString:(NSString *)tipStr andCanLook:(BOOL)canLook;
@property(nonatomic,copy)void(^actionType)(NSString *type);
@end

NS_ASSUME_NONNULL_END
