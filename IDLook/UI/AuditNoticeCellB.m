//
//  AuditNoticeCellB.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditNoticeCellB.h"

@interface AuditNoticeCellB ()<UITextViewDelegate>
@property(nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *tip;
@end

@implementation AuditNoticeCellB

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.numberOfLines=0;
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=Public_DetailTextLabelColor;
        _titleLab.text=@"备注";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _titleLab;
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
            make.bottom.mas_equalTo(self.contentView).offset(-10);
            make.top.mas_equalTo(self.contentView).offset(42);
        }];
        
    }
    return _textView;
}

- (UILabel *)tip
{
    if(!_tip)
    {
        _tip = [[UILabel alloc] init];
        _tip.text = @"选填，如：对演员的着装要求等等…";
        _tip.numberOfLines=0;
        _tip.font = [UIFont systemFontOfSize:15];
        _tip.textColor = [UIColor colorWithHexString:@"#BCBCBC"];
        [self.contentView addSubview:_tip];
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(17);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(50);
        }];
    }
    return _tip;
}

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    self.titleLab.text=dic[@"title"];
    self.textView.text=dic[@"content"];
    self.tip.text = dic[@"placeholder"];

    if([dic[@"content"] length]>0)
        self.tip.hidden=YES;
    else{
        self.tip.hidden=NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textViewChangeBlock) {
        self.textViewChangeBlock(textView.text);
    }
    
    if([textView.text length]>0)
        self.tip.hidden=YES;
    else{
        self.tip.hidden=NO;
    }
}


@end
