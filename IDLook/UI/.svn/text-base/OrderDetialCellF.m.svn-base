//
//  OrderDetialCellF.m
//  IDLook
//
//  Created by HYH on 2018/6/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellF.h"

@interface OrderDetialCellF ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *desc1;     //编码
@property(nonatomic,strong)UILabel *desc2;     //格式
@property(nonatomic,strong)UILabel *desc3;     //像素
@property(nonatomic,strong)UILabel *desc4;     //比例
@property(nonatomic,strong)UILabel *desc5;     //肖像说明
@property(nonatomic,strong)UILabel *desc6;     //使用说明
@end

@implementation OrderDetialCellF

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=4.0;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(20);
            make.size.mas_equalTo(CGSizeMake(75, 75));
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.numberOfLines=1;
        _titleLab.font=[UIFont systemFontOfSize:14.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.icon);
            make.left.mas_equalTo(self.icon.mas_right).offset(12);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _titleLab;
}

-(UILabel*)desc1
{
    if (!_desc1) {
        _desc1=[[UILabel alloc]init];
        _desc1.numberOfLines=1;
        _desc1.font=[UIFont systemFontOfSize:12.0];
        _desc1.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc1];
        [_desc1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(12);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _desc1;
}

-(UILabel*)desc2
{
    if (!_desc2) {
        _desc2=[[UILabel alloc]init];
        _desc2.numberOfLines=1;
        _desc2.font=[UIFont systemFontOfSize:12.0];
        _desc2.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc2];
        [_desc2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(12);
            make.top.mas_equalTo(self.desc1.mas_bottom).offset(3);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _desc2;
}

-(UILabel*)desc3
{
    if (!_desc3) {
        _desc3=[[UILabel alloc]init];
        _desc3.numberOfLines=1;
        _desc3.font=[UIFont systemFontOfSize:12.0];
        _desc3.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc3];
        [_desc3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(12);
            make.top.mas_equalTo(self.desc2.mas_bottom).offset(3);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _desc3;
}


-(UILabel*)desc4
{
    if (!_desc4) {
        _desc4=[[UILabel alloc]init];
        _desc4.numberOfLines=1;
        _desc4.font=[UIFont systemFontOfSize:12.0];
        _desc4.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc4];
        [_desc4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.icon.mas_bottom).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _desc4;
}

-(UILabel*)desc5
{
    if (!_desc5) {
        _desc5=[[UILabel alloc]init];
        _desc5.numberOfLines=1;
        _desc5.font=[UIFont systemFontOfSize:12.0];
        _desc5.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc5];
        [_desc5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.desc4.mas_bottom).offset(5);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _desc5;
}

-(UILabel*)desc6
{
    if (!_desc6) {
        _desc6=[[UILabel alloc]init];
        _desc6.numberOfLines=1;
        _desc6.font=[UIFont systemFontOfSize:12.0];
        _desc6.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc6];
        [_desc6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.desc5.mas_bottom).offset(5);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _desc6;
}

-(void)reloadUI
{
    self.icon.image=[UIImage imageNamed:@"huge_01.jpg"];
    self.titleLab.text=@"胡歌 TVC微出镜项目（独家授权照片）";
    self.desc1.text=@"编码：idTV00000000";
    self.desc2.text=@"格式：PNG";
    self.desc3.text=@"像素：1920x1080";
    self.desc4.text=@"大小：5.02M";
    self.desc5.text=@"肖像说明：脸探肖像独家销售权，可转签肖像使用权(同品类独家)";
    self.desc6.text=@"使用说明：可用于品牌商业用途，请提交下单获取报价信息";
    
}


@end
