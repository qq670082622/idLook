//
//  AuthCellB.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthCellB.h"

@interface AuthCellB ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIImageView *bgV;
@property(nonatomic,strong)UIImageView *cameraV;
@property(nonatomic,strong)UILabel *desc;
@end

@implementation AuthCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPhoto)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.backgroundColor=[UIColor whiteColor];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds=YES;
        _icon.layer.cornerRadius=5.0;
        _icon.layer.shadowOffset = CGSizeMake(8,8);
        _icon.layer.shadowOpacity = 1.0;
        _icon.layer.shadowColor = [[UIColor colorWithHexString:@"#BAA6A6"] colorWithAlphaComponent:0.15].CGColor;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(35);
            make.right.mas_equalTo(self.contentView).offset(-35);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
        }];
        
    }
    return _icon;
}

-(UIImageView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIImageView alloc]init];
        [self.icon addSubview:_bgV];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.icon);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _bgV;
}

-(UIImageView*)cameraV
{
    if (!_cameraV) {
        _cameraV=[[UIImageView alloc]init];
        _cameraV.image=[UIImage imageNamed:@"auth_camera"];
        [self.icon addSubview:_cameraV];
        [_cameraV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.icon);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _cameraV;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        [self.contentView addSubview:_desc];
        _desc.font=[UIFont systemFontOfSize:12.0];
        _desc.textColor=Public_Red_Color;
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.icon);
            make.top.mas_equalTo(self.cameraV.mas_bottom).offset(15);
        }];
    }
    return _desc;
}


-(void)reloadUIWithDic:(NSDictionary *)dic
{
    [self icon];
    
    self.bgV.image=[UIImage imageNamed:dic[@"image"]];
    self.desc.text=dic[@"desc"];
    
    [self cameraV];
}

-(void)addPhoto
{
    self.addPhotoBlock();
}

-(void)setImage:(UIImage *)image
{
    _image=image;
    self.icon.image=image;
    self.bgV.hidden=YES;
    self.desc.hidden=YES;
    self.cameraV.hidden=YES;
}

@end
