//
//  AskCalendarTipView.h
//  IDLook
//
//  Created by 吴铭 on 2019/5/28.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AskCalendarTipView : UIView
-(void)showTitle:(NSString *)title;
@property(nonatomic,copy)void(^tipViewAction)(NSInteger type);//0修改项目 1修改报价内容
@end

NS_ASSUME_NONNULL_END
