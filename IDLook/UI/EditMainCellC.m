//
//  EditMainCellC.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditMainCellC.h"
#import "EditHeadV.h"

@interface EditMainCellC ()
@property(nonatomic,strong)EditHeadV *headV;
@property(nonatomic,strong)MLLabel *content;

@end

@implementation EditMainCellC

-(EditHeadV*)headV
{
    if (!_headV) {
        _headV =[[EditHeadV alloc]init];
        [self.contentView addSubview:_headV];
        [_headV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(44);
        }];
        WeakSelf(self);
        _headV.editActionBlock = ^{
            weakself.EditMainCellCEditBlock();
        };
    }
    return _headV;
}

-(MLLabel*)content
{
    if (!_content) {
        _content=[[MLLabel alloc]init];
        _content.numberOfLines=0;
        _content.textAlignment=NSTextAlignmentLeft;
        _content.font=[UIFont systemFontOfSize:13.0];
        _content.textColor=[UIColor colorWithHexString:@"#666666"];
        _content.lineBreakMode = NSLineBreakByWordWrapping;
        _content.lineSpacing = 10;
//        _content.textInsets = UIEdgeInsetsMake(10, 13, 10, 13);
        [self addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self.headV.mas_bottom).offset(20);
            make.right.mas_equalTo(self).offset(-15);
        }];
    }
    return _content;
}

-(void)reloadUIWithTitle:(NSString *)title withType:(EditCellType)type
{
    self.headV.title=title;
    if (type==EditCellTypeBrief) {
        self.content.text=[[UserInfoManager getUserBrief]length]>0? [UserInfoManager getUserBrief] : @"暂未填写简介～";
    }
    else if (type==EditCellTypeWorks)
    {
        self.content.text=[[UserInfoManager getUserTypicalworks] length]>0?[UserInfoManager getUserTypicalworks] : @"暂未填写代表作品～";
    }
    
}

@end
