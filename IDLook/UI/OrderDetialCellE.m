//
//  OrderDetialCellE.m
//  IDLook
//
//  Created by HYH on 2018/6/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellE.h"

@interface OrderDetialCellE ()

@end

@implementation OrderDetialCellE

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
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=Public_LineGray_Color;
    [self.contentView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(48);
        make.height.mas_equalTo(0.5);
    }];
    lineV.hidden=YES;

    
    for (int i =0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        UILabel *titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:titleLab];
        titleLab.font=[UIFont systemFontOfSize:16];
        titleLab.textColor=Public_Text_Color;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            if (i==0)
            {
                if (array.count==1) {
                    make.centerY.mas_equalTo(self.contentView).offset(0);
                }
                else
                {
                    make.top.mas_equalTo(self.contentView).offset(13);
                }
            }
            else
            {
                make.top.mas_equalTo(self.contentView).offset(67+26*(i-1));
            }
        }];
        titleLab.text=dic[@"title"];
        
        UILabel *descLab=[[UILabel alloc]init];
        [self.contentView addSubview:descLab];
        descLab.font=[UIFont systemFontOfSize:13];
        descLab.textColor=Public_Text_Color;
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab.mas_right).offset(0);
            make.centerY.mas_equalTo(titleLab).offset(0);
        }];
        descLab.text=dic[@"desc"];
        
        UILabel *contentLab=[[UILabel alloc]init];
        [self.contentView addSubview:contentLab];
        contentLab.font=[UIFont systemFontOfSize:16];
        contentLab.textColor=Public_Text_Color;
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(titleLab);
        }];
        contentLab.text=dic[@"content"];
        
        if (i==4) {
            NSString *content = dic[@"content"];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:content];
            [attStr addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
            [attStr addAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,5)];
            contentLab.attributedText=attStr;
        }
    }
#if 0
    UILabel *lab1=[[UILabel alloc]init];
    [self.contentView addSubview:lab1];
    lab1.font=[UIFont systemFontOfSize:13];
    lab1.textColor=[UIColor colorWithHexString:@"#FF6600"];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.bottom.mas_equalTo(self.contentView).offset(-20);
    }];
    lab1.hidden=YES;
    if ([UserInfoManager getUserSubType]==UserSubTypePurPersonal) {
        lab1.text=@"*请在拍摄前一天支付剩余尾款";
    }
    else
    {
        lab1.text=@"*请在拍摄完成后10个工作日内支付剩余尾款";
    }
    
    if (array.count>1) {
        lineV.hidden=NO;
        NSDictionary *firDic = [array firstObject];
        if ([firDic[@"isShowPromt"] boolValue]==YES) {
            lab1.hidden=NO;
        }
    }
#endif
    
    if (array.count>1) {
        lineV.hidden=NO;
    }
    
}


@end
