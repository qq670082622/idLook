//
//  UploadWorksVC.h
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadWorksVC : UIViewController
@property(nonatomic,assign)WorkType type;
@property(nonatomic,copy)void(^saveRefreshUI)(void);

@end
