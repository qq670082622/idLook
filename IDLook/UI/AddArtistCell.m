//
//  AddArtistCell.m
//  IDLook
//
//  Created by HYH on 2018/6/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddArtistCell.h"

@interface AddArtistCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIButton *collectionBtn;
@property(nonatomic,strong)UIButton *selectBtn;

@end

@implementation AddArtistCell

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.layer.cornerRadius=5.0;
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowColor = [[UIColor colorWithHexString:@"#549DD2"] colorWithAlphaComponent:0.1].CGColor;
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.bounds.size.width, self.bounds.size.height-44)];
        [self.contentView addSubview:_icon];

        _icon.contentMode=UIViewContentModeScaleAspectFill;
        
        //切上圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_icon.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _icon.bounds;
        maskLayer.path = maskPath.CGPath;
        _icon.layer.mask = maskLayer;
    }
    return _icon;
}

-(UILabel*)name
{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont systemFontOfSize:15.0];
        _name.textColor=Public_Text_Color;
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
        }];
    }
    return _name;
}

-(UIButton*)collectionBtn
{
    if (!_collectionBtn) {
        _collectionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_collectionBtn];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_collection_h"] forState:UIControlStateNormal];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_collection_h"] forState:UIControlStateSelected];
        [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.name);
            make.right.mas_equalTo(self.contentView).offset(-13);
        }];
    }
    return _collectionBtn;
}

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
    }
    return _selectBtn;
}

-(void)reloadUIWithInfo:(UserInfoM *)info
{
    if (info==nil) {
        return;
    }
    
    [self.icon sd_setImageWithUrlStr:info.head placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.name.text=info.nick;
    [self collectionBtn];
    
    self.selectBtn.selected=info.isChoose;
}


@end
