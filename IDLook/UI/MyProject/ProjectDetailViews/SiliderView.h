//
//  SiliderView.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SiliderView : UIView
@property(nonatomic,copy)NSString *typeStr;
-(void)showTypeWithSelectLow:(NSInteger)low andHigh:(NSInteger)high;
@property(nonatomic,copy)void(^selectNum)(NSInteger low , NSInteger high);
@end

NS_ASSUME_NONNULL_END
