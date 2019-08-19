//
//  OrderDetialCellO.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/17.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "OrderDetialCellO.h"

@interface OrderDetialCellO ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation OrderDetialCellO

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.image=[UIImage imageNamed:@"order_promt"];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.numberOfLines=0;
        _titleLab.font=[UIFont systemFontOfSize:13];
        _titleLab.textColor=[UIColor colorWithHexString:@"#FF6600"];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(40);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(void)reloadUIWithDesc:(NSString *)desc
{
    [self icon];
    self.titleLab.text=desc;
}

@end
