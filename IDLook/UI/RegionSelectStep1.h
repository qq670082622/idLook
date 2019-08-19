//
//  RegionSelectVC.h
//  IDLook
//
//  Created by HYH on 2018/7/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RegionType)   //城市选择
{
    RegionTypeMirr,   //微出镜
    RegionTypeTrial     //试葩间区域
};

@interface RegionSelectStep1 : UIViewController
@property(nonatomic,copy)void(^selectCity)(NSString *city);
@property(nonatomic,strong)NSArray *selectedArr;
@property(nonatomic,assign)RegionType type;
@end
