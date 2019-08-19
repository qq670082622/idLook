//
//  CityChooseVC.h
//  IDLook
//
//  Created by HYH on 2018/7/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CitySelectStep1 : UIViewController
@property(nonatomic,copy)void(^selectCity)(NSString *city);
@property(nonatomic,strong)NSArray *selectedArr;
@property(nonatomic,copy)NSString *artistRegin;  //演员所在地
@end
