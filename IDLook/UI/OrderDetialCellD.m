//
//  OrderDetialCellD.m
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellD.h"

@interface OrderDetialCellD ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *priceLab;
@end

@implementation OrderDetialCellD

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}


-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        [self.contentView addSubview:_priceLab];
        _priceLab.font=[UIFont boldSystemFontOfSize:16.0];
        _priceLab.textColor=Public_Text_Color;
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _priceLab;
}

-(void)reloadUIWithPrice:(NSString *)price
{
    self.titleLab.text=@"试镜费";
    self.priceLab.text=[price floatValue]>=0?[NSString stringWithFormat:@"¥ %ld",[price integerValue]]:@"商议价";
}
@end
