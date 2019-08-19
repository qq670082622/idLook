//
//  EditBriefCell.m
//  IDLook
//
//  Created by HYH on 2018/5/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditBriefCell.h"

@interface EditBriefCell ()<UITextViewDelegate>
@property (nonatomic,strong) UILabel * labelTip;
@end

@implementation EditBriefCell

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

-(void)reloadUIWithType:(EditCellType)type
{
    if (type==EditCellTypeBrief) {
        self.textView.text = [UserInfoManager getUserBrief];
        self.labelTip.text = @"请填写简介～";
    }
    else if (type==EditCellTypeWorks)
    {
        self.textView.text = [UserInfoManager getUserTypicalworks];
        self.labelTip.text = @"请填写代表作品～";
    }
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
}

@end
