//
//  HomeBannerView.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionModel.h"
#import "HomeSearchView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol HomeBannerViewDelegate <NSObject>

-(void)searchViewInBannerViewWithActionType:(conditionType)type;

@end
@interface HomeBannerView : UIView
@property(nonatomic,copy)void(^clickBannerWithDictionary)(NSDictionary *dic);
@property(nonatomic,copy)void(^blockLoginOut)(void);
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)ConditionModel *conditionModel;
@property(nonatomic,weak)id<HomeBannerViewDelegate>delegate;
-(void)reloadSearchViewWithModel:(ConditionModel *)cdModel;
@end

NS_ASSUME_NONNULL_END
