//
//  LookPricePopV2.h
//  IDLook
//
//  Created by 吴铭 on 2018/12/13. 新改版的查看报价弹窗
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"
#import "PlaceOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LookPricePopV2 : UIView
@property(nonatomic,copy)void(^placeActionBlockWithAudition)(PriceModel * model);
@property(nonatomic,copy)void(^placeActionBlockWithScreening)(OrderStructM * model);
@property(nonatomic,assign) NSInteger selectedType;//1视频 2平面
-(void)showWithArray:(NSArray*)array;
@end

@interface LookPricePopCell2 :UITableViewCell

@property(nonatomic,copy)void(^LookPricePopCellBlock)(void);

-(void)reloadUIWithModel:(PriceModel*)model;
@end

NS_ASSUME_NONNULL_END
