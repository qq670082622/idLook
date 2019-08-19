//
//  CountryChooseVC.h
//  IDLook
//
//  Created by Mr Hu on 2018/12/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryChooseVC : UIViewController
@property(nonatomic,copy)void(^selectCountry)(NSString *country);

@end

NS_ASSUME_NONNULL_END
