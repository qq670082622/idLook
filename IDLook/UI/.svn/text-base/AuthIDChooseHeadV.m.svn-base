//
//  AuthIDChooseHeadV.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthIDChooseHeadV.h"

@interface AuthIDChooseHeadV ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@end

@implementation AuthIDChooseHeadV

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        
        self.contentView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetial)];
        [self.contentView addGestureRecognizer:tap];
        
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}


-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}


-(void)reloadUIWithModel:(IDTypeStructModel*)model
{
    self.titleLab.text=model.title;
    if (model.isShowArrow) {
        self.arrow.hidden=NO;
    }
    else
    {
        self.arrow.hidden=YES;
    }
    
    if (model.isShowRow) {
        self.arrow.image=[UIImage imageNamed:@"auth_pullup"];
    }
    else
    {
        self.arrow.image=[UIImage imageNamed:@"auth_pulldown"];
    }
}

-(void)showDetial
{
    if (self.showDetialBlock) {
        self.showDetialBlock();
    }
}

@end
