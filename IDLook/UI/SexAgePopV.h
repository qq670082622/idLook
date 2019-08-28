//
//  SexAgePopV.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/27.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SexAgePopV : UIView
-(void)showTypeWithSelectSex:(NSInteger)sex andAgeHigh:(NSInteger)ageHigh andAgeLow:(NSInteger)ageLow;
@property(nonatomic,copy)void(^selectNum)(NSInteger sex , NSInteger ageHigh , NSInteger ageLow);
@end

NS_ASSUME_NONNULL_END
