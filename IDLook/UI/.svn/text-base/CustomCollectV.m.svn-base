//
//  CustomCollectV.m
//  IDLook
//
//  Created by HYH on 2018/6/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CustomCollectV.h"
#import "MMSpinner.h"

@interface CustomCollectV ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)UIButton *click;
@property(nonatomic,strong)MMSpinner *spinner;
@end

@implementation CustomCollectV

-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(-40);
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

-(UIButton*)click
{
    if (!_click) {
        _click=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_click];
        [_click setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _click.titleLabel.font=[UIFont systemFontOfSize:15.0];
        _click.backgroundColor=Public_Red_Color;
        _click.layer.masksToBounds=YES;
        _click.layer.cornerRadius=5.0;
        [_click mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.desc.mas_bottom).offset(25);
            make.size.mas_equalTo(CGSizeMake(128, 45));
        }];
        [_click addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _click;
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
    self.click.hidden=YES;

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
    
    if (type==NoDataTypeNetwork) {
        self.click.hidden=YES;
//        [self.click setTitle:@"重新加载" forState:UIControlStateNormal];
    }
    else
    {
        self.click.hidden=YES;
    }
}

-(void)hideNoDataScene
{
    self.spinner.hidesWhenStopped=YES;
    [self.spinner stopAnimating];
    
    self.imageView.hidden=YES;
    self.desc.hidden=YES;
    self.click.hidden=YES;
    
}

- (void)btnClicked
{
    if([self.dele respondsToSelector:@selector(CustomCollectViewNoDataSceneClicked:)])
    {
        [self.dele CustomCollectViewNoDataSceneClicked:self];
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
    return dic;
}

@end
