//
//  EditMainCellB.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditMainCellB.h"
#import "EditHeadV.h"

@interface EditMainCellB ()
@property(nonatomic,strong)EditHeadV *headV;
@end

@implementation EditMainCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

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
            weakself.EditMainCellBEditBlock();
        };
    }
    return _headV;
}

-(void)reloadUIWithTitle:(NSString *)title withData:(NSArray *)array
{
    self.headV=nil;
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    self.headV.title=title;

    for (int i =0; i<array.count;i++) {
        NSDictionary *dic = array[i];
        UILabel *titleLab=[[UILabel alloc]init];
        titleLab.font=[UIFont systemFontOfSize:14.0];
        titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        titleLab.text = dic[@"title"];
        titleLab.tag=100+i;
        [self.contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self.headV.mas_bottom).offset(30+30*i);
        }];
        
        UILabel *descLab=[[UILabel alloc]init];
        descLab.font=[UIFont systemFontOfSize:14.0];
        descLab.textColor=Public_Text_Color;
        descLab.tag=1000+i;
        [self.contentView addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(137);
            make.top.mas_equalTo(self.headV.mas_bottom).offset(30+30*i);
            make.right.mas_equalTo(self).offset(-5);
        }];
        descLab.text=dic[@"desc"];
    }
}

@end
