//
//  UploadPersonBGVC.h
//  IDLook
//
//  Created by HYH on 2018/8/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadPersonBGVC : UIViewController
@property(nonatomic,copy)void(^addHeadBGBlock)(UIImage *image);

//是否保存
@property(nonatomic,assign)BOOL isSave;

@end
