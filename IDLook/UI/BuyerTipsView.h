//
//  BuyerTipsView.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyerTipsView : UIView
@property(nonatomic,strong)NSArray *data;
//-(void)loadUIWithData:(NSArray *)data;
@property(nonatomic,copy)void(^topAction)(void);
@end

NS_ASSUME_NONNULL_END
