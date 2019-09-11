//
//  PortraitSignVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/7/22.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PortraitSignVC : UIViewController
@property (copy, nonatomic) NSString  *actiorHeadStr;
@property (copy, nonatomic) NSString  *actorNametr;
@property (copy, nonatomic) NSString  *roleNametr;
@property(nonatomic,assign)NSInteger roleId;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)void(^created)(void);
@end

NS_ASSUME_NONNULL_END
