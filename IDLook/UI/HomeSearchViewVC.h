//
//  HomeSearchViewVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/28.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeSearchViewVC : UIViewController
@property(nonatomic,assign)NSInteger category;//不传或为0时查询所有 1=男 2=女 3=青年男 4=青年女 5=中年男 6=中年女 7=老年男 8=老年女 9=小男孩 10=小女孩
@property(nonatomic,copy)NSString *selectKeyWord;
@property(nonatomic,copy)void(^wordKeySelect)(NSString *wordKey);
@end

NS_ASSUME_NONNULL_END
