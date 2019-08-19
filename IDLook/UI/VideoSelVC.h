//
//  VideoSelVC.h
//  IDLook
//
//  Created by HYH on 2018/6/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoSelVC : UIViewController

@property (nonatomic,copy)void(^doUpdata)(NSArray *array);

@property (nonatomic,strong)NSArray *imageArr;   //相册中以选中的视频

@end
