//
//  VersionPopv.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionPopv : UIView
-(void)showWithUpdate:(BOOL)update andVersion:(NSString *)version andTips:(NSArray *)tips;
@property(nonatomic,copy)void(^update)(void);
@end

NS_ASSUME_NONNULL_END
