//
//  AuthSuccCellA.m
//  IDLook
//
//  Created by HYH on 2018/6/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthSuccCellA.h"

@interface AuthSuccCellA ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation AuthSuccCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV = [[UIView alloc]init];
        _bgV.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_bgV];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(40);
            make.left.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return _bgV;
}

-(UILabel *)titleLab
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

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    [self bgV];
    for (UIView *view in self.bgV.subviews) {
        [view removeFromSuperview];
    }
    
    NSString *title = dic[@"title"];
    NSArray *array = dic[@"data"];
    
    for (int i = 0 ; i<array.count; i++) {
        NSDictionary *dic = array[i];
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        titleLab.font=[UIFont systemFontOfSize:14.0];
        [self.bgV addSubview:titleLab];
        titleLab.tag=100+i;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(65+26*i);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        titleLab.text=dic[@"title"];
        
        UILabel *descLab = [[UILabel alloc]init];
        descLab.textColor=Public_Text_Color;
        descLab.font=[UIFont systemFontOfSize:14.0];
        [self.bgV addSubview:descLab];
        descLab.tag=1000+i;
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(65+26*i);
            make.left.mas_equalTo(self.contentView).offset(130);
        }];
        descLab.text=dic[@"desc"];
    }
    self.titleLab.text=title;

}


@end
