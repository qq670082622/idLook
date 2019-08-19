//
//  PublicWebVC.h
//  IDLook
//
//  Created by HYH on 2018/7/31.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicWebVC : UIViewController
- (id)initWithTitle:(NSString *)title
                url:(NSString *)url;

@property (nonatomic,assign) BOOL hideNavBar;
@end
