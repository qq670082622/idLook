//
//  AssetsTopV.h
//  IDLook
//
//  Created by HYH on 2018/5/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsTopV : UIView
@property(nonatomic,copy)void(^forwardBlock)(void);  //提现
- (void)changeImageFrameWithOffY:(CGFloat)offY;

-(void)refreshTotalAssets:(NSString*)money;

@end
