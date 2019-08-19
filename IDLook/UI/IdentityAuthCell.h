//
//  IdentityAuthCell.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/9.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IdentityAuthCell : UIView
@property(nonatomic,copy)void(^submitBlock)();
@end

NS_ASSUME_NONNULL_END
