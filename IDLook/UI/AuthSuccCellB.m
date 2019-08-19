//
//  AuthSuccCellB.m
//  IDLook
//
//  Created by HYH on 2018/6/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthSuccCellB.h"

@interface AuthSuccCellB ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *leftV;
@property(nonatomic,strong)UIImageView *rightV;

@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UILabel *rightLab;
@end

@implementation AuthSuccCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        [self.contentView addSubview:_bgV];
        _bgV.backgroundColor=[UIColor whiteColor];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(40);
            make.left.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return _bgV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:14.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(13);
        }];
    }
    return _titleLab;
}

-(UIImageView*)leftV
{
    if (!_leftV) {
        _leftV=[[UIImageView alloc]init];
        _leftV.userInteractionEnabled=YES;
        _leftV.tag=10000;
        _leftV.layer.cornerRadius=5.0;
        _leftV.layer.masksToBounds=YES;
        _leftV.clipsToBounds=YES;
        _leftV.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_leftV];
        [_leftV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView.mas_centerX).offset(-4);
            make.top.mas_equalTo(self.bgV).offset(25);
            make.bottom.mas_equalTo(self.bgV).offset(-45);

        }];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_leftV addGestureRecognizer:tap];
    }
    return _leftV;
}

-(UIImageView*)rightV
{
    if (!_rightV) {
        _rightV=[[UIImageView alloc]init];
        _rightV.userInteractionEnabled=YES;
        _rightV.tag=10001;
        _rightV.contentMode=UIViewContentModeScaleAspectFill;
        _rightV.clipsToBounds=YES;
        _rightV.layer.cornerRadius=5.0;
        _rightV.layer.masksToBounds=YES;
        [self.contentView addSubview:_rightV];
        [_rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX).offset(4);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.bgV).offset(25);
            make.bottom.mas_equalTo(self.bgV).offset(-45);
        }];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_rightV addGestureRecognizer:tap];
    }
    return _rightV;
}

-(UILabel*)leftLab
{
    if (!_leftLab) {
        _leftLab=[[UILabel alloc]init];
        [self.contentView addSubview:_leftLab];
        _leftLab.font=[UIFont systemFontOfSize:12];
        _leftLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.leftV);
            make.top.mas_equalTo(self.leftV.mas_bottom).offset(8);
        }];
    }
    return _leftLab;
}

-(UILabel*)rightLab
{
    if (!_rightLab) {
        _rightLab=[[UILabel alloc]init];
        [self.contentView addSubview:_rightLab];
        _rightLab.font=[UIFont systemFontOfSize:12];
        _rightLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.rightV);
            make.top.mas_equalTo(self.rightV.mas_bottom).offset(8);
        }];
    }
    return _rightLab;
}

-(void)reloadUIWithDic:(NSDictionary*)dic;
{
    [self bgV];
    NSArray *array = dic[@"data"];
    self.titleLab.text=dic[@"title"];
    
    if (array.count!=2) {
        return;
    }
    
    NSDictionary *dic1 = array[0];
    NSDictionary *dic2 = array[1];

    [self.leftV sd_setImageWithUrlStr:dic1[@"image"] placeholderImage:[UIImage imageNamed:@"default_video"]];
    [self.rightV sd_setImageWithUrlStr:dic2[@"image"] placeholderImage:[UIImage imageNamed:@"default_video"]];

    self.leftLab.text=dic1[@"title"];
    self.rightLab.text=dic2[@"title"];
}

-(void)tapAction:(UITapGestureRecognizer*)tap
{
    self.LookBigPhotoWithIndex(tap.view.tag-10000);
}

@end
