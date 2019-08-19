//
//  SelectedCityV.h
//  IDLook
//
//  Created by HYH on 2018/7/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedCityV : UIView
@property(nonatomic,copy)void(^delectCity)(NSInteger index);
-(void)reloadUIWithArray:(NSArray*)array;

@end
