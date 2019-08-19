//
//  PlaceOrderCellB.m
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceOrderCellB.h"

@interface PlaceOrderCellB ()<UITextViewDelegate>
@property (nonatomic,strong)UILabel *tip;

@end

@implementation PlaceOrderCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(UITextView*)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font=[UIFont systemFontOfSize:15.0];
        _textView.delegate=self;
        [self.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
            make.top.mas_equalTo(self.contentView).offset(10);
        }];
        
    }
    return _textView;
}

- (UILabel *)tip
{
    if(!_tip)
    {
        _tip = [[UILabel alloc] init];
        _tip.numberOfLines=0;
        _tip.font = [UIFont systemFontOfSize:13.0];
        _tip.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        [self.contentView addSubview:_tip];
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
            make.top.mas_equalTo(self.contentView).offset(20);
        }];
    }
    return _tip;
}

-(void)reloadUIWithPlaceholder:(NSString*)placeholder withText:(NSString*)text;
{
    self.textView.text=text;;
    self.tip.text=placeholder;
    
    if([text length]>0)
        self.tip.hidden=YES;
    else
        self.tip.hidden=NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
     self.textFieldChangeBlock(textView.text);
    if([textView.text length]>0)
        self.tip.hidden=YES;
    else
        self.tip.hidden=NO;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.BeginEdit();
}

@end