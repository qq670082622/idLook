//
//  BuyerHomeBanner.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyerHomeBanner : UIView
@property(nonatomic,copy)void(^clickBannerWithDictionary)(NSDictionary *dic);
@property(nonatomic,copy)void(^topAction)(void);
@property(nonatomic,strong)NSArray *bannerData;
@property(nonatomic,strong)NSArray *tipsData;
@end

NS_ASSUME_NONNULL_END
