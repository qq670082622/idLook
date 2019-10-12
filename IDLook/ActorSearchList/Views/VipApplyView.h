//
//  VipApplyView.h
//  IDLook
//
//  Created by 吴铭 on 2019/10/11.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipApplyView : UIView
@property(nonatomic,copy)void(^reply)(NSString *name,NSString *phone,NSString *remark);
@end

NS_ASSUME_NONNULL_END
