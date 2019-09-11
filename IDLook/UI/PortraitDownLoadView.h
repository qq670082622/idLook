//
//  PortraitDownLoadView.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PortraitDownLoadView : UIView
-(void)show;
@property(nonatomic,copy)void(^download)(NSString *email);
@end

NS_ASSUME_NONNULL_END
