//
//  OfferPopV.h
//  IDLook
//
//  Created by HYH on 2018/7/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferPopV : UIView
@property(nonatomic,copy)void(^confirmBlock)(NSString *content);

-(void)show;

@end
