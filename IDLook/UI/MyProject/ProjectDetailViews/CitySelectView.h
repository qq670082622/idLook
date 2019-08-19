//
//  CitySelectView.h
//  IDLook
//
//  Created by 吴铭 on 2019/7/26.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CitySelectView : UIView
-(void)showTypeWithSelectCities:(NSArray *)city;
@property(nonatomic,copy)void(^citySelectAction)(NSArray *cities);
@end

NS_ASSUME_NONNULL_END
