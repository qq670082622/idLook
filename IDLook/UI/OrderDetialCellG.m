//
//  OrderDetialCellG.m
//  IDLook
//
//  Created by HYH on 2018/7/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellG.h"

@interface OrderDetialCellG ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)MLLabel *desc;
@property(nonatomic,strong)UIImageView *imageV;
@end

@implementation OrderDetialCellG

-(UIImageView*)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.image =[UIImage imageNamed:@"LR_promt"];
        [self.contentView addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab).offset(0);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _imageV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.numberOfLines=1;
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=[UIColor colorWithHexString:@"#FF6600"];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(15);
            make.left.mas_equalTo(self).offset(37);
        }];
    }
    return _titleLab;
}

-(MLLabel*)desc
{
    if (!_desc) {
        _desc=[[MLLabel alloc]init];
        _desc.numberOfLines=0;
        _desc.lineSpacing=5.0;
        _desc.lineBreakMode = NSLineBreakByWordWrapping;
        _desc.font=[UIFont systemFontOfSize:16];
        _desc.textColor=[UIColor colorWithHexString:@"#FF6600"];
        [self addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(125);
            make.top.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _desc;
}

-(void)reloadUIWithOrderModel:(OrderModel *)model
{
    [self imageV];
    if ([model.orderstate isEqualToString:@"rejected"]) {
        self.titleLab.text=@"拒单理由";
        self.desc.text=model.ordermsg;
    }
    else
    {
        self.titleLab.text=@"失效原因";
        self.desc.text=[self getResonWithModel:model];
    }
 
}

//
-(NSString*)getResonWithModel:(OrderModel*)model
{
    NSString *reson = @"";
    if ([model.orderstate isEqualToString:@"rejected"]) {
        reson= [UserInfoManager getUserType]==UserTypePurchaser? @"艺人已拒单":@"您已拒单";
    }
    else if ([model.orderstate isEqualToString:@"cancel"])
    {
        reson= @"订单已取消";
    }
    else if ([model.orderstate isEqualToString:@"overtime"])
    {
        reson= @"订单超时";
    }
    else if ([model.orderstate isEqualToString:@"buydefault"])
    {
        reson= @"购买方违约";
    }
    else if ([model.orderstate isEqualToString:@"actordefault"])
    {
        reson= @"演员违约";
    }
    else if ([model.orderstate isEqualToString:@"noschedule"])
    {
        reson= @"档期被买断";
    }
    return reson;
}

@end
