//
//  AskPriceView.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/15.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AskPriceView : UIView
-(void)showWithTitle:(NSString *)title desc:(NSString *)desc leftBtn:(NSString *)left rightBtn:(NSString *)right phoneNum:(NSString *)num;
@property(nonatomic,copy)NSString *phoneNum;
@end

NS_ASSUME_NONNULL_END
