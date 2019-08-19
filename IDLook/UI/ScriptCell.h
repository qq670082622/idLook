//
//  ScriptCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/22.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScriptModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ScriptCell : UICollectionViewCell
-(void)reloadUIWithModel:(ScriptModel*)model;
@end

NS_ASSUME_NONNULL_END
