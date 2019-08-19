//
//  MyOrderServiceView.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/16.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderServiceView : UIView
-(void)reloadUIWithModel:(OrderProjectModel*)model;
@end

NS_ASSUME_NONNULL_END
