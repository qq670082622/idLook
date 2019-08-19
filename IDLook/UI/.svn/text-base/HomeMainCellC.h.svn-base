//
//  HomeMainCell.h
//  IDLook
//
//  Created by HYH on 2018/5/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define cellCWidth (UI_SCREEN_WIDTH-35)/2


@interface HomeMainCellC : UITableViewCell
@property(nonatomic,copy)void(^HomeMainCellClickBlock)(UserInfoM *info);  //查看用户信息
@property(nonatomic,copy)void(^EntryMoreRecommendBlock)(NSInteger type);  //更多推荐
@property(nonatomic,copy)void(^lookUserPriceBlock)(UserInfoM *info);  //查看报价

-(void)reloadUIWithArray:(NSArray*)array;
@end

