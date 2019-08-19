//
//  HomeMainCellA.h
//  IDLook
//
//  Created by HYH on 2018/7/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMainCellA : UITableViewCell
@property(nonatomic,copy)void(^clickType1Block)(NSInteger type);
@property(nonatomic,copy)void(^clickType2Block)(NSInteger type);
@property(nonatomic,copy)void(^EntryMoreRecommendBlock)(void);  //更多推荐


-(void)reloadUI;

@end



