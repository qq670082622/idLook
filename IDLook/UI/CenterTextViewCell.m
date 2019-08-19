//
//  CenterTextViewCell.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CenterTextViewCell.h"

@interface CenterTextViewCell ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property (nonatomic,strong) UILabel * labelTip;

@end

@implementation CenterTextViewCell

-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:15.0];
        _textView.textColor = Public_TableviewCell_TextLabelColor;
        [self.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return _textView;
}

-(UILabel*)labelTip
{
    if(!_labelTip)
    {
        _labelTip = [[UILabel alloc] init];
        _labelTip.font = [UIFont systemFontOfSize:15.0];
        _labelTip.textColor = Public_DetailTextLabelColor;
        [self.contentView addSubview:_labelTip];
        [_labelTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(self.contentView.mas_top).offset(8);
        }];
    }
    return _labelTip;
}

-(void)reloadUIWithModel:(EditStructM*)model
{
    self.textView.text = model.content;
    self.labelTip.text=model.placeholder;
    
    [self textViewDidChange:self.textView];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>0)
    {
        self.labelTip.hidden=YES;
    }
    else
    {
        self.labelTip.hidden=NO;
    }
    if (self.textViewChangeBlock) {
        self.textViewChangeBlock(textView.text);
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.BeginEdit();

}

@end
