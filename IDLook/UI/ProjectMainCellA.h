//
//  ProjectMainCellA.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectMainCustomCell.h"
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectMainCellA : ProjectMainCustomCell

@property(nonatomic,copy)void(^buttonClickBlock)(NSInteger type,UIButton *sender);  //点击按钮

-(void)reloadUIWithProjectOrderInfo:(ProjectOrderInfoM*)info;
@end

NS_ASSUME_NONNULL_END
