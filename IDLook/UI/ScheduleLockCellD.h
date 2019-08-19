//
//  ScheduleLockCellD.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//  锁档档期保障金cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleLockCellD : UITableViewCell
@property(nonatomic,copy)void(^lookProtocolBlock)(void);  //查看协议

-(void)reloadUIWithPrice:(NSInteger)price;

@end

NS_ASSUME_NONNULL_END
