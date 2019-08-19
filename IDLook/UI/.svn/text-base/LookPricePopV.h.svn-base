//
//  LookPricePopV.h
//  IDLook
//
//  Created by HYH on 2018/7/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"

@interface LookPricePopV : UIView
@property(nonatomic,copy)void(^placeActionBlock)(NSInteger type,NSString *title);
-(void)showWithArray:(NSArray*)array;
@end

@interface LookPricePopCell :UITableViewCell

@property(nonatomic,copy)void(^LookPricePopCellBlock)(void);

-(void)reloadUIWithModel:(PriceModel*)model;
@end
