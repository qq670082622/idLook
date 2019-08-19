//
//  ScheduleCellA.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleCellA : UITableViewCell
@property(nonatomic,strong)UITextView *textView;

-(void)reloadUI;

@end

NS_ASSUME_NONNULL_END
