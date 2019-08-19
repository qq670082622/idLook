//
//  FeedbackCellA.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "FeedbackCellA.h"

@interface FeedbackCellA ()<UITextViewDelegate>
@end

@implementation FeedbackCellA

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
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.photoBtn.mas_top).offset(-10);
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
        _tip.text = @"请填写10字以上的意见或建议，我们将为您不断改进~";
        _tip.numberOfLines=0;
        _tip.font = [UIFont systemFontOfSize:13.0];
        _tip.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        [self.contentView addSubview:_tip];
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(20);
        }];
    }
    return _tip;
}

-(UIButton*)photoBtn
{
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _photoBtn.backgroundColor=[UIColor colorWithHexString:@"#EDEDED"];
        [_photoBtn setImage:[UIImage imageNamed:@"feedback_Photo"] forState:UIControlStateNormal];
        [self.contentView addSubview:_photoBtn];
        [_photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.bottom.mas_equalTo(self.contentView).offset(-15);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        [_photoBtn addTarget:self action:@selector(rbtnClicked) forControlEvents:UIControlEventTouchUpInside];

    }
    return _photoBtn;
}

-(void)reloadUI
{
    [self textView];
    [self photoBtn];
    [self tip];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>0)
        self.tip.hidden=YES;
    else
        self.tip.hidden=NO;
}

-(void)rbtnClicked
{
    self.addPhotoBlock();
}

@end