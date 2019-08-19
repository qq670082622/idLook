//
//  PlaceAuditItemCellC.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "PlaceAuditItemCellC.h"

@interface PlaceAuditItemCellC ()
@property(nonatomic,strong)UILabel *titleLab1;
@property(nonatomic,strong)UILabel *titleLab2;
@property(nonatomic,strong)UIImageView *arrow;
@end

@implementation PlaceAuditItemCellC

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab1
{
    if (!_titleLab1) {
        _titleLab1=[[UILabel alloc]init];
        _titleLab1.font=[UIFont systemFontOfSize:16];
        _titleLab1.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab1];
        [_titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(-3);
        }];
        
    }
    return _titleLab1;
}

-(UILabel*)titleLab2
{
    if (!_titleLab2) {
        _titleLab2=[[UILabel alloc]init];
        _titleLab2.font=[UIFont systemFontOfSize:16];
        _titleLab2.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab2];
        [_titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView.mas_centerY).offset(3);
        }];
        
    }
    return _titleLab2;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}

-(void)reloadUIWithModel:(ProjectModel *)model
{
    self.titleLab1.text=[NSString stringWithFormat:@"项目编号：%@",model.projectid];
    self.titleLab2.text=[NSString stringWithFormat:@"项目名称：%@",model.name];
    [self arrow];
}
@end
