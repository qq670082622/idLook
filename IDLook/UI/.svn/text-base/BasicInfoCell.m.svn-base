//
//  BasicInfoCell.m
//  IDLook
//
//  Created by HYH on 2018/5/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "BasicInfoCell.h"

@interface BasicInfoCell ()
@property(nonatomic,strong)UILabel *detialLab1;
@property(nonatomic,strong)UILabel *detialLab2;

@end

@implementation BasicInfoCell


-(UILabel*)detialLab1
{
    if (!_detialLab1) {
        _detialLab1=[[UILabel alloc]init];
        _detialLab1.font=[UIFont systemFontOfSize:13.0];
        _detialLab1.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_detialLab1];
        [_detialLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _detialLab1;
}

-(UILabel*)detialLab2
{
    if (!_detialLab2) {
        _detialLab2=[[UILabel alloc]init];
        _detialLab2.font=[UIFont systemFontOfSize:13.0];
        _detialLab2.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_detialLab2];
        [_detialLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _detialLab2;
}


-(void)reloadUIWithArray:(NSArray*)array
{

    self.detialLab1.text=array[0];
    
    if (array.count>1) {
        self.detialLab2.text=array[1];
    }
}

@end
