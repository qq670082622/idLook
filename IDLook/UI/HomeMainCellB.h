//
//  HomeMainCellB.h
//  IDLook
//
//  Created by HYH on 2018/7/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMainCellB : UITableViewCell

@property(nonatomic,copy)void(^HomeMainCellBlickBlock)(UserInfoM *info);

@property(nonatomic,copy)void(^EntryMoreRecommendBlock)(NSInteger type);

-(void)reloadUIWithArray:(NSArray*)array;

@end
