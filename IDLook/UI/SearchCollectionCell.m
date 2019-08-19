//
//  SearchCollectionCell.m
//  IDFace
//
//  Created by HYH on 2018/5/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SearchCollectionCell.h"

@interface SearchCollectionCell ()

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIButton *collectionBtn;

@end

@implementation SearchCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.layer.cornerRadius=5.0;
//        self.layer.masksToBounds=YES;
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
//        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView);
//            make.left.mas_equalTo(self.contentView);
//            make.right.mas_equalTo(self.contentView);
//            make.bottom.mas_equalTo(self.contentView).offset(-44);
//        }];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserHead)];
        [_icon addGestureRecognizer:tap];
        
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
        _name.textColor=[UIColor colorWithHexString:@"#191919"];
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
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_collection_n"] forState:UIControlStateNormal];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_collection_h"] forState:UIControlStateSelected];
        [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.name);
            make.right.mas_equalTo(self.contentView).offset(-13);
        }];
        [_collectionBtn addTarget:self action:@selector(addCollection) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}

-(void)reloadUIWithInfo:(UserInfoM *)info
{
    if (info==nil) {
        return;
    }
    
    [self.icon sd_setImageWithUrlStr:info.head placeholderImage:[UIImage imageNamed:@"head_default"]];
    self.name.text=info.nick;
    self.collectionBtn.selected=info.isCollection;
}

//收藏
-(void)addCollection
{
    self.collectionBtn.selected=!self.collectionBtn.selected;
}

-(void)clickUserHead
{
    
}

@end