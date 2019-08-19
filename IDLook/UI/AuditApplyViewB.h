//
//  AuditApplyViewB.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuditApplyViewB : UIView
@property(nonatomic,copy)void(^textViewChangeBlock)(NSString *text);
@property(nonatomic,copy)void(^countsChangeBlock)(NSInteger count);

@property(nonatomic,copy)void(^textViewBeginEditBlock)(void);  //开始编辑
@property(nonatomic,copy)void(^textViewEndEditBlock)(void);    //结束编辑

@end

NS_ASSUME_NONNULL_END
