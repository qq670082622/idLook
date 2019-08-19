//
//  FeedbackCellA.h
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackCellA : UITableViewCell
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *photoBtn;
@property (nonatomic,strong)UILabel *tip;
@property(nonatomic,copy)void(^addPhotoBlock)(void);
-(void)reloadUI;
@end
