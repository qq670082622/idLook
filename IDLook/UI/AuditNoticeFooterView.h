//
//  AuditNoticeFooterView.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuditNoticeFooterView : UITableViewHeaderFooterView

@property(nonatomic,copy)void(^confrimBlock)(void);  //确定


@end

NS_ASSUME_NONNULL_END
