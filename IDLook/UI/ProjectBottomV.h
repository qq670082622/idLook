//
//  ProjectBottomV.h
//  IDLook
//
//  Created by Mr Hu on 2019/6/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectBottomV : UIView
@property(nonatomic,copy)void(^closeViewBlock)(void);  

-(void)refreshUIWithType:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
