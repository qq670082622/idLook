//
//  CityCellA.m
//  IDLook
//
//  Created by HYH on 2018/7/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CityCellA.h"

@interface CityCellA ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UIButton *selectBtn;

@end

@implementation CityCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=[UIColor colorWithHexString:@"#F7F7F7"].CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        [_selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.userInteractionEnabled=YES;
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:14];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectBtn.mas_right).offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(150, 48));
        }];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAction)];
        [_titleLab addGestureRecognizer:tap];
    }
    return _titleLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _arrow;
}

-(void)reloadUIWithModel:(CityModel *)model
{
    self.titleLab.text=model.city;
    if (model.isShowArrow) {
        self.arrow.hidden=NO;
    }
    else
    {
        self.arrow.hidden=YES;
    }
    
    if (model.isSelect) {
        self.selectBtn.selected=YES;
    }
    else
    {
        self.selectBtn.selected=NO;
    }
}

-(void)selectAction
{
    self.doSelectCity();
}

@end
