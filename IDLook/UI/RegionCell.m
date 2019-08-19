//
//  RegionCell.m
//  IDLook
//
//  Created by HYH on 2018/8/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RegionCell.h"

@interface RegionCell ()
@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation RegionCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.userInteractionEnabled=YES;
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(20);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(void)reloadUIWithModel:(CityModel *)model
{
    self.titleLab.text=model.city;
}

@end
