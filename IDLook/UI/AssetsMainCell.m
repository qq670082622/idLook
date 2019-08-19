//
//  AssetsMainCell.m
//  IDLook
//
//  Created by HYH on 2018/5/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AssetsMainCell.h"

@interface AssetsMainCell ()
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UILabel *drawLab;

@end

@implementation AssetsMainCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *lineV=[[UIView alloc]init];
        lineV.backgroundColor=Public_LineGray_Color;
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

-(UILabel*)title
{
    if (!_title) {
        _title=[[UILabel alloc]init];
        _title.numberOfLines=0;
        _title.font=[UIFont systemFontOfSize:17];
        _title.textColor=Public_Text_Color;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(18);
        }];
    }
    return _title;
}

-(UILabel*)time
{
    if (!_time) {
        _time=[[UILabel alloc]init];
        _time.numberOfLines=0;
        _time.font=[UIFont systemFontOfSize:13];
        _time.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
        [self.contentView addSubview:_time];
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.bottom.mas_equalTo(self.contentView).offset(-17);
        }];
    }
    return _time;
}

-(UILabel*)price
{
    if (!_price) {
        _price=[[UILabel alloc]init];
        _price.numberOfLines=0;
        _price.font=[UIFont boldSystemFontOfSize:17];
        _price.textColor=[UIColor colorWithHexString:@"#FC8613"];
        [self.contentView addSubview:_price];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(18);
        }];
    }
    return _price;
}

-(UILabel*)drawLab
{
    if (!_drawLab) {
        _drawLab=[[UILabel alloc]init];
        _drawLab.numberOfLines=0;
        _drawLab.font=[UIFont systemFontOfSize:13];
        _drawLab.textColor=[UIColor colorWithHexString:@"#FF6600"];
        [self.contentView addSubview:_drawLab];
        [_drawLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.contentView).offset(-17);
        }];
    }
    return _drawLab;
}

-(void)reloadUIWithModel:(AssetModel *)model
{
    self.title.text=model.tradingOrderTypeName;
    self.time.text=model.tradingDate;
    self.drawLab.text=model.remark;
    self.price.text=model.transactionMoney;

    if ([model.transactionMoney floatValue]>0) {
        self.price.textColor=Public_Red_Color;
    }
    else
    {
        self.price.textColor=Public_Text_Color;
    }
}

@end
