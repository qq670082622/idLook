//
//  HomeSearchView.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum{
    conditionTypeHeiWei_select = 0,
    conditionTypeSexAge_select,
    conditionTypeKeyWord_select,
    conditionTypePriceMin_select,
    conditionTypePirceMax_select,
    conditionTypeShotType_select,
    conditionTypeRegion_select,
    conditionTypeHeiWei_clear,
    conditionTypeSexAge_clear,
    conditionTypeKeyWord_clear,
    conditionTypePriceMin_clear,
    conditionTypePirceMax_clear,
    conditionTypeShotType_clear,
    conditionTypeRegion_clear,
    conditionTypeSearch
          }conditionType;

@interface HomeSearchView : UIView
@property(nonatomic,strong)ConditionModel *model;
-(void)loadUIWithModel:(ConditionModel *)model;
@property(nonatomic,copy)void(^conditionSelectType)(conditionType type);
@end

NS_ASSUME_NONNULL_END
