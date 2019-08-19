//
//  AuditionPOCellA.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"
#import "PlaceOrderModel.h"

@interface AuditionPOCellA : UITableViewCell
@property(nonatomic,copy)void(^AuditionPOCellAtextFieldChangeBlock)(NSString *text,NSInteger type);
@property(nonatomic,copy)void(^AuditionPOCellABeginEdit)(NSInteger type);  //开始编辑

@property(nonatomic,copy)void(^typeClickBlock)(NSInteger type);

-(void)reloadUIWithProjectOrderInfo:(ProjectOrderInfoM*)info withArray:(NSArray*)array withType:(NSInteger)type;

@end
