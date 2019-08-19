//
//  OrderDetialCellH.m
//  IDLook
//
//  Created by HYH on 2018/7/13.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellH.h"

@interface OrderDetialCellH ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)UIButton *downBtn ;
@end

@implementation OrderDetialCellH

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.numberOfLines=1;
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(15);
        }];
    }
    return _titleLab;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.numberOfLines=0;
        _desc.font=[UIFont systemFontOfSize:16];
        _desc.textColor=Public_Red_Color;
        _desc.userInteractionEnabled=YES;
        [self addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(140);
            make.centerY.mas_equalTo(self);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookDetial)];
        [_desc addGestureRecognizer:tap];
    }
    return _desc;
}

-(UIButton*)downBtn
{
    if (!_downBtn) {
        _downBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_downBtn];
        [_downBtn setBackgroundImage:[UIImage imageNamed:@"down_black"] forState:UIControlStateNormal];
        [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-20);
        }];
        [_downBtn addTarget:self action:@selector(downAction) forControlEvents:UIControlEventTouchUpInside];
    }
   return  _downBtn;
}

-(void)reloadUIWithType:(OrderType)type
{
    if (type==OrderTypeAudition) {
        self.titleLab.text=@"试镜视频";
        self.desc.text=@"查看试镜视频";
    }
    else if(type==OrderTypeShot)
    {
        self.titleLab.text=@"授权书";
        self.desc.text=@"查看授权书";
    }
    [self downBtn];
}

-(void)lookDetial
{
    self.LookAuditionVideo();
}

-(void)downAction
{
    self.downVideo();
}

@end