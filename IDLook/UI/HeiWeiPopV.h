//
//  HeiWeiPopV.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/26.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeiWeiPopV : UIView
-(void)showTypeWithSelectLowHei:(NSInteger)lowHei andHighHei:(NSInteger)highHei andLowWei:(NSInteger)lowWei andiHighWei:(NSInteger)highWei;
@property(nonatomic,copy)void(^selectNum)(NSInteger lowHei , NSInteger highHei , NSInteger lowWei , NSInteger highWei);
@end

NS_ASSUME_NONNULL_END
