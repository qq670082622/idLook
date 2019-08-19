//
//  EditInfoCellB.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditInfoCellB.h"

@interface EditInfoCellB ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@end

@implementation EditInfoCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:14.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(UILabel*)detialLab
{
    if (!_detialLab) {
        _detialLab=[[UILabel alloc]init];
        _detialLab.font=[UIFont systemFontOfSize:14.0];
        _detialLab.textAlignment=NSTextAlignmentRight;
        _detialLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_detialLab];
        [_detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrow.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(120);
        }];
    }
    return _detialLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        UIImage *image=[UIImage imageNamed:@"center_arror_icon"];
        _arrow.image=image;
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.size.mas_equalTo(CGSizeMake(image.size.width,image.size.height));
        }];
    }
    return _arrow;
}

-(void)reloadUIWithType:(NSIndexPath*)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row ;
    
    [self arrow];
    
    if (sec==0) {
        if (row==1) {
            self.titleLab.text=@"用户ID";
            self.detialLab.text=[UserInfoManager getUserUID];
            self.arrow.hidden=YES;
        }
        else if (row==2)
        {
            self.titleLab.text=@"微博名";
            self.detialLab.text=[[UserInfoManager getUserSinaName]length]<=0?@"未填写":[UserInfoManager getUserSinaName];
        }
        else if (row==3)
        {
            self.titleLab.text=@"微博粉丝数";
            self.detialLab.text=[UserInfoManager getUserSinaFansNumber]<=0?@"未填写":[NSString stringWithFormat:@"%@万", [PublicManager changeFloatWithFloat:[UserInfoManager getUserSinaFansNumber]]];
        }
    }
}


@end
