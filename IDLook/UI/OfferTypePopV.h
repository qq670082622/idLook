//
//  OfferTypePopV.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OfferTypePopV : UIView
@property(nonatomic,copy)void(^typeSelectAction)(NSString *content,NSInteger advType,NSInteger advSubType);


/**
 报价类型展示
 @param list 报价列表
 @param content 选中的报价
 */
-(void)showOfferTypeWithPriceList:(NSArray*)list withContent:(NSString*)content;

@end

NS_ASSUME_NONNULL_END
