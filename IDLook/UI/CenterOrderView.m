
//
//  CenterOrderView.m
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CenterOrderView.h"

@implementation CenterOrderView

-(void)layoutIfNeeded
{
    [super layoutIfNeeded];
    
    UILabel *titleLab=[[UILabel alloc]init];
    [self addSubview:titleLab];
    titleLab.text=@"我的订单";
    titleLab.textColor=Public_Text_Color;
    titleLab.font=[UIFont systemFontOfSize:14.0];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(13);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(40);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:allBtn];
    [allBtn setImage:[UIImage imageNamed:@"center_arror_icon"] forState:UIControlStateNormal];
    [allBtn setTitle:@"查看所有订单" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
    allBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.right.mas_equalTo(self).offset(-15);
    }];
    
    allBtn.titleLabel.backgroundColor = allBtn.backgroundColor;
    allBtn.imageView.backgroundColor = allBtn.backgroundColor;
    //在使用一次titleLabel和imageView后才能正确获取titleSize
    CGSize titleSize = allBtn.titleLabel.bounds.size;
    CGSize imageSize = allBtn.imageView.bounds.size;
    CGFloat interval = 1.0;
    allBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + 5), 0, imageSize.width + 5);
    
    [allBtn addTarget:self action:@selector(entryAllOrder) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *array ;
    
    if ([UserInfoManager getUserType]==UserTypePurchaser) {
        array = @[@{@"title":@"待确认",@"image":@"center_order_new"},
                  @{@"title":@"进行中",@"image":@"center_order_do"},
                  @{@"title":@"已完成",@"image":@"center_order_finish"},
                  @{@"title":@"已失效",@"image":@"center_order_refuse"}];
    }
    else
    {
        array = @[@{@"title":@"待确认",@"image":@"center_order_new"},
                  @{@"title":@"议价中",@"image":@"center_order_price"},
                  @{@"title":@"进行中",@"image":@"center_order_do"},
                  @{@"title":@"已完成",@"image":@"center_order_finish"},
                  @{@"title":@"已失效",@"image":@"center_order_refuse"}];
    }
    
    CGFloat width = (UI_SCREEN_WIDTH-16)/array.count;
    
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        UIButton *button=[[UIButton alloc]init];
        [self addSubview:button];
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(i%array.count*width);
            make.top.mas_equalTo(self).offset(40);
            make.size.mas_equalTo(CGSizeMake(width, 98));
        }];
        
        button.titleLabel.backgroundColor = button.backgroundColor;
        button.imageView.backgroundColor = button.backgroundColor;
        
        CGSize titleSize = button.titleLabel.bounds.size;
        CGSize imageSize = button.imageView.bounds.size;
        CGFloat interval = 1;
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width + interval))];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval + 30, -(imageSize.width + interval), 0, 0)];
        
        [button addTarget:self action:@selector(buttionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)buttionClick:(UIButton*)sender
{
    self.orderClickTypeBlock(sender.tag-100+1);
}

-(void)entryAllOrder
{
    self.orderClickTypeBlock(0);
}

@end