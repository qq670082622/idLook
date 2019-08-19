//
//  AskPriceCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetialInfoM.h"
NS_ASSUME_NONNULL_BEGIN

@interface AskPriceCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) UserDetialInfoM *info;
-(CGFloat)reloadUIWithArray:(NSArray *)priceModelArray;//reloadUIWithNormalPrice:(NSInteger)totalPrice photoDic:(NSDictionary *)photoDic videoDic:(NSDictionary *)videoDic groupDic:(NSDictionary *)groupDic;
-(void)setVip_price:(NSInteger)vipPrice andNormalPrice:(NSInteger)normalPrice;
@property(nonatomic,copy)void(^vipAction)(void);
@property(nonatomic,copy)void(^typeAction)(void);
//@property(nonatomic,assign)NSInteger totalPrice;
//@property(nonatomic,assign)NSInteger startPrice;
//@property(nonatomic,assign)NSInteger vipStartPrice;

@end

NS_ASSUME_NONNULL_END
