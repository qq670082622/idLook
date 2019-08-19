//
//  HomeBannerView.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeBannerView : UIView
@property(nonatomic,copy)void(^clickBannerWithDictionary)(NSDictionary *dic);
@property(nonatomic,copy)void(^blockLoginOut)(void);
@property(nonatomic,strong)NSArray *dataSource;
@end

NS_ASSUME_NONNULL_END
