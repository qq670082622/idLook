//
//  AddSubButton.h
//  IDLook
//
//  Created by HYH on 2018/5/22.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSubButton : UIView
@property(nonatomic,copy)void(^addAction)(void);
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageN;
@property(nonatomic,copy)UIImage *iconImage;
@end
