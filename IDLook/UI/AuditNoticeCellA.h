//
//  AuditNoticeCellA.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuditNoticeCellA : UITableViewCell
@property(nonatomic,copy)void(^textFieldChangeBlock)(NSString *text);

-(void)reloadUIWithDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
