//
//  OrderDetialCellC.m
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellC.h"

@interface OrderDetialCellC ()

@end

@implementation OrderDetialCellC

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(void)reloadUIWithArray:(NSArray *)array
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat totalHight =20; //总高度
    for (int i =0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        CGFloat height = [dic[@"height"] floatValue];  //单个高度
        UILabel *titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:titleLab];
        titleLab.font=[UIFont systemFontOfSize:16];
        titleLab.textColor=Public_Text_Color;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(totalHight);
        }];
        titleLab.text=dic[@"title"];
        
        MLLabel *contentLab=[[MLLabel alloc]init];
        contentLab.userInteractionEnabled=YES;
        contentLab.numberOfLines=0;
        contentLab.lineSpacing=5.0;
        [self.contentView addSubview:contentLab];
        contentLab.font=[UIFont systemFontOfSize:16.0];
        contentLab.textColor=Public_Text_Color;
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([dic[@"title"] isEqualToString:@"最晚上传作品日期"]) {
                make.left.mas_equalTo(self.contentView).offset(162);
            }
            else
            {
                make.left.mas_equalTo(self.contentView).offset(125);
            }
            make.right.mas_equalTo(self.contentView).offset(-10);
            make.top.mas_equalTo(self.contentView).offset(totalHight);
        }];
        contentLab.text=dic[@"content"];
        
        totalHight+=height;
    }
}

-(void)lookDetial
{
    self.LookScreenmirror();
}

-(void)downAction
{
    self.downScreenmirrorBlock();
}

@end
