//
//  AuditPOSubV.h
//  IDLook
//
//  Created by Mr Hu on 2019/7/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuditPOSubV : UIView
@property(nonatomic,copy)void(^textFieldChangeBlock)(NSString *text);
@property(nonatomic,copy)void(^BeginEdit)(void);  //开始编辑

-(void)reloadUIWithModel:(OrderStructM*)model;
@end

NS_ASSUME_NONNULL_END
