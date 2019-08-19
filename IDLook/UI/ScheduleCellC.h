//
//  ScheduleCellC.h
//  IDLook
//
//  Created by Mr Hu on 2019/5/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleCellC : UITableViewCell
@property(nonatomic,copy)void(^dateSelectWithType)(NSInteger type);

-(void)reloadUIWithDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
