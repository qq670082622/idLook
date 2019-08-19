//
//  MyOrderFailureView.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/10.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyOrderFailureView.h"

@interface MyOrderFailureView ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)UIImageView *imageV;
@end

@implementation MyOrderFailureView

-(UIImageView*)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.image =[UIImage imageNamed:@"LR_promt"];
        [self addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.titleLab.mas_left).offset(-2);
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
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.desc.mas_left).offset(-20);
        }];
    }
    return _titleLab;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:16];
        _desc.textColor=[UIColor colorWithHexString:@"#FF6600"];
        [self addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _desc;
}

-(void)reloadUIWithState:(NSString *)state
{
    [self imageV];
    self.titleLab.text=@"失效原因";
    self.desc.text=[self getResonState:state];
}

//
-(NSString*)getResonState:(NSString*)state
{
    NSString *reson = @"";
    if ([state isEqualToString:@"rejected"]) {
        reson= [UserInfoManager getUserType]==UserTypePurchaser? @"演员已拒单":@"您已拒单";
    }
    else if ([state isEqualToString:@"cancel"])
    {
        reson= @"订单已取消";
    }
    else if ([state isEqualToString:@"overtime"])
    {
        reson= @"订单超时";
    }
    else if ([state isEqualToString:@"buydefault"])
    {
        reson= @"购买方违约";
    }
    else if ([state isEqualToString:@"actordefault"])
    {
        reson= @"演员违约";
    }
    else if ([state isEqualToString:@"noschedule"])
    {
        reson= @"档期被买断";
    }
    
    return reson;
}

@end
