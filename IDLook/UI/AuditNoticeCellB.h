//
//  AuditNoticeCellB.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuditNoticeCellB : UITableViewCell
@property(nonatomic,copy)void(^textViewChangeBlock)(NSString *text);

@property(nonatomic,strong)UITextView *textView;

-(void)reloadUIWithDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
