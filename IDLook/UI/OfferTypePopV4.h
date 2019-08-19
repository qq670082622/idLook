//
//  OfferTypePopV4.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/25.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel_java.h"
NS_ASSUME_NONNULL_BEGIN

@interface OfferTypePopV4 : UIView
-(void)showOfferTypeWithPriceList:(NSArray *)list withSelectModel:(PriceModel_java *)model;

@property(nonatomic,copy)void(^typeSelectAction)(NSArray *selectArray);
@end

NS_ASSUME_NONNULL_END
