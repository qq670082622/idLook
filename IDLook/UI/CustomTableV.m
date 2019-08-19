//
//  CustomTableV.m
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CustomTableV.h"
#import "MMSpinner.h"

@interface CustomTableV ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)MMSpinner *spinner;
@property(nonatomic,strong)UIButton *button;
@end

@implementation CustomTableV

-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
//            make.centerY.mas_equalTo(self).offset((self.frame.size.height-UI_SCREEN_HEIGHT));
            make.centerY.mas_equalTo(self).offset(-50);
        }];
    }
    return _imageView;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        [self addSubview:_desc];
        _desc.font=[UIFont systemFontOfSize:14.0];
        _desc.textColor=[UIColor colorWithHexString:@"#999999"];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(15);
        }];
    }
    return _desc;
}

-(UIButton*)button
{
    if (!_button) {
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button];
        _button.layer.cornerRadius=6;
        _button.layer.masksToBounds=YES;
        _button.backgroundColor=Public_Red_Color;
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.desc.mas_bottom).offset(30);
            make.size.mas_equalTo(CGSizeMake(150, 48));
        }];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


-(MMSpinner*)spinner
{
    if (!_spinner) {
        _spinner = [[MMSpinner alloc] init];
        _spinner.tintColor = Public_Orange_Color;
        _spinner.hidden = YES;
        _spinner.lineWidth = 2;
        [self addSubview:_spinner];
        [_spinner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _spinner;
}

-(void)startLoading
{
    self.imageView.hidden=YES;
    self.desc.hidden=YES;
    
    self.spinner.hidden = NO;
    [self.spinner startAnimating];
}

-(void)showWithNoDataType:(NoDataType)type
{
    NSDictionary *dic = [self getShowInfoWithType:type];
    self.imageView.image=[UIImage imageNamed:dic[@"image"]];
    self.desc.text=dic[@"desc"];
    
    self.imageView.hidden=NO;
    self.desc.hidden=NO;
    self.button.hidden=YES;
    if (type==NoDataTypeBankCard) {
        [self.button setTitle:@"添加银行卡" forState:UIControlStateNormal];
        self.button.hidden=NO;
    }
    else if (type==NoDataTypeAlipay)
    {
        [self.button setTitle:@"添加支付宝账号" forState:UIControlStateNormal];
        self.button.hidden=NO;
    }
}

-(void)hideNoDataScene
{
    self.spinner.hidesWhenStopped=YES;
    [self.spinner stopAnimating];
    
    self.imageView.hidden=YES;
    self.desc.hidden=YES;
    self.button.hidden=YES;
}

-(void)buttonAction
{
    if (self.dele &&[self.dele respondsToSelector:@selector(CustomTableViewButtonClicked)]) {
        [self.dele CustomTableViewButtonClicked];
    }
}

-(NSDictionary*)getShowInfoWithType:(NoDataType)type
{
    NSDictionary *dic;
    if (type==NoDataTypeCollection)
    {
        dic=@{@"image":@"nodata_collection",@"desc":@"暂无收藏"};
    }
    else if (type==NoDataTypeSearchResult)
    {
        dic= @{@"image":@"nodata_search",@"desc":@"没有找到相关的演员艺人"};
    }
    else if (type==NoDataTypeWorks)
    {
        dic= @{@"image":@"nodata_works",@"desc":@"暂无作品，快去上传吧"};
    }
    else if (type==NoDataTypeOrder)
    {
        dic= @{@"image":@"nodata_order",@"desc":@"暂无订单"};
    }
    else if (type==NoDataTypeCustomMsg)
    {
        dic= @{@"image":@"nodata_custom_msg",@"desc":@"暂无消息"};
    }
    else if (type==NoDataTypeOrderMsg)
    {
        dic= @{@"image":@"nodata_msg",@"desc":@"暂无消息"};
    }
    
    else if (type==NoDataTypeAssets)
    {
        dic= @{@"image":@"nodata_assets",@"desc":@"暂无资产明细记录"};
    }
    else if (type==NoDataTypeNetwork)
    {
        dic=@{@"image":@"nodata_network",@"desc":@"您的网络已走丢"};
    }
    else if (type==NoDataTypePrice)
    {
        dic=@{@"image":@"nodata_price",@"desc":@"暂无报价"};
    }
    else if (type==NoDataTypeProject)
    {
        dic=@{@"image":@"nodata_project",@"desc":@"暂无项目"};
    }
    else if (type==NoDataTypeRole)
    {
        dic=@{@"image":@"nodata_project",@"desc":@"暂无角色"};
    }
    else if (type==NoDataTypeAuditionService)
    {
        dic=@{@"image":@"nodata_order",@"desc":@"暂无选角服务"};
    }
    else if (type==NoDataTypeCoupon)
    {
        dic=@{@"image":@"coupon_nodata",@"desc":@"您还没有相关优惠券哦～"};
    }
    else if (type==NoDataTypeAnnunciate)
    {
        dic=@{@"image":@"nodata_annunciate",@"desc":@"暂无通告"};
    }
    else if (type==NoDataTypeGrade)
    {
         dic=@{@"image":@"pic_nograde",@"desc":@"暂无评价"};
    }
    else if (type==NoDataTypeBankCard)
    {
        dic=@{@"image":@"nodata_bankcard",@"desc":@"您还没有银行卡，立即去添加"};
    }
    else if (type==NoDataTypeAlipay)
    {
        dic=@{@"image":@"nodata_bankcard",@"desc":@"您还没有支付宝账号，立即去添加"};
    }
    return dic;
}

@end
