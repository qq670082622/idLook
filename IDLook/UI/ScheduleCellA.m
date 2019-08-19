//
//  ScheduleCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleCellA.h"

@interface ScheduleCellA ()<UITextViewDelegate>
@property(nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *numLab;
@end

@implementation ScheduleCellA

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.numberOfLines=0;
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=Public_DetailTextLabelColor;
        _titleLab.text=@"理由";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(14);
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
            make.bottom.mas_equalTo(self.contentView).offset(-30);
            make.top.mas_equalTo(self.contentView).offset(45);
        }];
        
    }
    return _textView;
}

- (UILabel *)tip
{
    if(!_tip)
    {
        _tip = [[UILabel alloc] init];
        _tip.text = @"请填写档期再确认的理由，如final PPM或天气原因更换拍摄日期";
        _tip.numberOfLines=0;
        _tip.font = [UIFont systemFontOfSize:15];
        _tip.textColor = [UIColor colorWithHexString:@"#BCBCBC"];
        [self.contentView addSubview:_tip];
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(50);
        }];
    }
    return _tip;
}

-(UILabel*)numLab
{
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.text = @"0/500";
        _numLab.numberOfLines=0;
        _numLab.font = [UIFont systemFontOfSize:12];
        _numLab.textColor = [UIColor colorWithHexString:@"#BCBCBC"];
        [self.contentView addSubview:_numLab];
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.contentView).offset(-12);
        }];
    }
    return _numLab;
}

-(void)reloadUI
{
    [self titleLab];
    [self textView];
    [self tip];
    [self numLab];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>0)
        self.tip.hidden=YES;
    else{
        self.tip.hidden=NO;
    }
    
    if (textView.text.length > 500) {
        textView.text = [textView.text substringToIndex:500];
    }
    self.numLab.text = [NSString stringWithFormat:@"%ld/500",textView.text.length];

}

@end
