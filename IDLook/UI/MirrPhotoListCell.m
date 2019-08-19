//
//  MirrPhotoListCell.m
//  IDLook
//
//  Created by HYH on 2018/5/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MirrPhotoListCell.h"

@interface MirrPhotoListCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *buyBtn;
@end

@implementation MirrPhotoListCell

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=5.0;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-25);
        }];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.userInteractionEnabled=YES;
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    return _titleLab;
}

-(UIButton*)buyBtn
{
    if (!_buyBtn) {
        _buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.icon addSubview:_buyBtn];
        _buyBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        _buyBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon);
            make.right.mas_equalTo(self.icon);
            make.bottom.mas_equalTo(self.icon);
            make.height.mas_equalTo(34);

        }];
        [_buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

-(void)reloadUIWithModel:(WorksModel *)model
{
    [self.icon sd_setImageWithUrlStr:model.url placeholderImage:[UIImage imageNamed:@"default_photo"]];
    self.titleLab.text = model.title;
    
//    if ([UserInfoManager getUserType]==UserTypePurchaser) {
//        self.buyBtn.hidden=NO;
//    }
//    else
//    {
//        self.buyBtn.hidden=YES;
//    }
}

//购买
-(void)buyAction
{
    self.buyPhotoBlock();
}


@end
