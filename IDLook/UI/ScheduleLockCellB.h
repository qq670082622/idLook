//
//  ScheduleLockCellB.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//  锁档服务费cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleLockCellB : UITableViewCell
@property(nonatomic,copy)void(^lookServiceExpainBlock)(void);  //服务费说明

-(void)reloadUIWithPrice:(NSInteger)price;

@end

NS_ASSUME_NONNULL_END
