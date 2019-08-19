//
//  EditHeadV.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditHeadV.h"

@interface EditHeadV ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *editBtn;
@end

@implementation EditHeadV

-(id)init
{
    if (self=[super init]) {
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _titleLab;
}

-(UIButton*)editBtn
{
    if (!_editBtn) {
        _editBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_editBtn];
        [_editBtn setImage:[UIImage imageNamed:@"center_edit"] forState:UIControlStateNormal];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        _editBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-15);
        }];
        _editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        [_editBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}


-(void)setTitle:(NSString *)title
{
    _title=title;
    self.titleLab.text=title;
    [self editBtn];
}

-(void)editAction
{
    self.editActionBlock();
}

@end
