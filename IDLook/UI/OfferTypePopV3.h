//
//  OfferTypePopV3.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/7.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel_java.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, workType) {
    video_workType = 1,//视频拍摄
    print_workType, //平面拍摄
    group_workType, //套拍
    };
@interface OfferTypePopV3 : UIView
-(void)showOfferTypeWithPriceList:(NSArray*)list withSelectArray:(NSArray*)array withUserModel:(UserInfoM*)userModel;

@property(nonatomic,copy)void(^typeSelectAction)(NSArray *selectArray);
@end

NS_ASSUME_NONNULL_END
