//
//  AccountManageCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/5/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountManageCell : UITableViewCell
@property(nonatomic,copy)void(^modifyAccountBlock)(void);  //修改

-(void)reloadUIWithDic:(NSDictionary*)dic withType:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
