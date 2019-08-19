//
//  CitiesView.h
//  IDLook
//
//  Created by 吴铭 on 2019/7/26.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CitiesView : UIView
-(void)reloadUIWithSelectCities:(NSArray *)cities;
@property(nonatomic,copy)void(^close)(void);
@property(nonatomic,copy)void(^selectCities)(NSArray *cities);
@end

NS_ASSUME_NONNULL_END
