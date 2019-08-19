//
//  LHRatingView.h
//  TestStoryboard
//
//  Created by bosheng on 15/11/4.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHRatingView;
typedef NS_ENUM(NSInteger,starType){
    price_starType,  //性价比
    act_starType,  //表演力
    match_starType,       //配合度
    feeling_starType,   //好感度
};
@protocol ratingViewDelegate <NSObject>

@optional
/**
 * 评分事件
 * @param view 当前评分view
 * @param score 分数
 */
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score andType:(starType)type;

@end

/// 星星显示类型
typedef NS_ENUM(NSUInteger, RatingType) {
    INTEGER_TYPE,
    FLOAT_TYPE
};

@interface LHRatingView : UIView
@property (nonatomic,assign)CGFloat lowestScore;//!< 最低分数
@property (nonatomic,assign)RatingType ratingType;//!< 评分类型，整颗星或半颗星
@property (nonatomic,assign)CGFloat score;//!< 当前分数
@property(nonatomic,assign)starType type;
@property (nonatomic,weak)id<ratingViewDelegate> delegate;

@end
