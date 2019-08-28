//
//  PricePopV.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/28.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PricePopV : UIView
-(void)showTypeWithSelectLowPrice:(NSInteger)lowPrice andHighPrice:(NSInteger)highPrice;
@property(nonatomic,copy)void(^selectNum)(NSInteger lowPrice, NSInteger highPrice);
@end

NS_ASSUME_NONNULL_END
