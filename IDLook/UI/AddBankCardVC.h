//
//  AddBankCardVC.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddBankCardVC : UIViewController
@property(nonatomic,copy)void(^refreshUI)(void);
@property(nonatomic,strong)NSDictionary *accountInfo;  //银行卡或者支付宝信息
@property(nonatomic,assign)NSInteger type;  //0:银行卡。 1：支付宝

@end

NS_ASSUME_NONNULL_END
