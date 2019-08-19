//
//  PlaceOrderCellB.h
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderCellB : UITableViewCell
@property(nonatomic,copy)void(^textFieldChangeBlock)(NSString *text);
@property(nonatomic,copy)void(^BeginEdit)(void);  //开始编辑

@property(nonatomic,strong)UITextView *textView;
-(void)reloadUIWithPlaceholder:(NSString*)placeholder withText:(NSString*)text;
- (void)textViewDidChange:(UITextView *)textView;

@end
