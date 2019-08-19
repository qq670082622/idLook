//
//  UserLookPricePopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/3/25.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserLookPricePopV : UIView

@property(nonatomic,copy)void(^typeSelectBlock)(NSDictionary *dic,NSInteger day);  //选中回掉
@property(nonatomic,copy)void(^confrimActionBlock)(NSDictionary *dic,NSInteger day);  //确认回掉


-(void)showOfferTypeWithPriceList:(NSArray*)list withSelectDic:(NSDictionary*)dic withDay:(NSInteger)day withMastery:(NSInteger)mastery withType:(NSInteger)type;

@end

@interface PricePopSubV : UIView

-(void)reloadUIWithDic:(NSDictionary*)dic;

/**
 是否选中状态
 */
@property(nonatomic,assign)BOOL isSelect;
@end
