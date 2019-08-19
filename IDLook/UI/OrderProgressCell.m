//
//  OrderProgressCell.m
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderProgressCell.h"

@interface OrderProgressCell ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)MLLabel *descLab;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIImageView *icon;
@end

@implementation OrderProgressCell

-(UIView*)lineV
{
    if (!_lineV) {
        _lineV=[[UIView alloc]init];
        _lineV.backgroundColor=Public_LineGray_Color;
        [self.contentView addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(20);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.width.mas_equalTo(2);
        }];
    }
    return _lineV;
}

-(UILabel*)timeLab
{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        [self.contentView addSubview:_timeLab];
        _timeLab.font=[UIFont boldSystemFontOfSize:12.0];
        _timeLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(8);
            make.left.mas_equalTo(self.contentView).offset(40);
        }];
    }
    return _timeLab;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.timeLab);
            make.centerX.mas_equalTo(self.lineV);
        }];
    }
    return _icon;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        _bgV.layer.masksToBounds=YES;
        _bgV.layer.cornerRadius=5.0;
        _bgV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        [self.contentView addSubview:_bgV];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.left.mas_equalTo(self.contentView).offset(38);
        }];
    }
    return _bgV;
}



-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont boldSystemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgV).offset(20);
            make.left.mas_equalTo(self.bgV).offset(15);
        }];
    }
    return _titleLab;
}

-(MLLabel*)descLab
{
    if (!_descLab) {
        _descLab=[[MLLabel alloc]init];
        _descLab.numberOfLines=0;
        _descLab.lineSpacing=5.0;
        _descLab.lineBreakMode = NSLineBreakByWordWrapping;
        _descLab.textInsets = UIEdgeInsetsMake(5, 10, 5, 10);
        [self.contentView addSubview:_descLab];
        _descLab.font=[UIFont systemFontOfSize:13.0];
        _descLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
            make.left.mas_equalTo(self.contentView).offset(40);
            make.right.mas_equalTo(self.contentView).offset(-10);
//            make.right.lessThanOrEqualTo(self.contentView.mas_right).with.offset(-10);
//            make.width.greaterThanOrEqualTo(@50);
        }];
    }
    return _descLab;
}


-(void)reloadUIWithModel:(OrderProgStructM *)model
{
    self.timeLab.text=model.time;

    if (model.progress==0)
    {  //未进行
        self.bgV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        self.titleLab.textColor=[UIColor colorWithHexString:@"#CCCCCC"];
        self.descLab.textColor=[UIColor colorWithHexString:@"#CCCCCC"];
        [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
        }];
        self.lineV.backgroundColor=Public_LineGray_Color;
        self.icon.image=[UIImage imageNamed:@"order_prog_1"];
    }
    else if (model.progress==1)   //已进行
    {
        self.bgV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        self.titleLab.textColor=Public_Text_Color;
        self.descLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(30);
        }];
        self.lineV.backgroundColor=Public_Red_Color;
        self.icon.image=[UIImage imageNamed:@"order_prog_3"];

    }
    else if (model.progress==2)   //进行中
    {
        self.bgV.backgroundColor=Public_Red_Color;
        self.titleLab.textColor=[UIColor whiteColor];
        self.descLab.textColor=[[UIColor whiteColor]colorWithAlphaComponent:0.6];
        [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
        }];
        self.lineV.backgroundColor=Public_LineGray_Color;
        self.icon.image=[UIImage imageNamed:@"order_prog_2"];

    }
    
    [self bgV];
    self.titleLab.text=model.title;
    self.descLab.text=model.content;
}

@end
