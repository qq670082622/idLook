//
//  PlaceAuditItemCellA.m
//  IDLook
//
//  Created by Mr Hu on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceAuditItemCellA.h"

@interface PlaceAuditItemCellA ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UIButton *addBtn;
@end

@implementation PlaceAuditItemCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];

    }
    return _titleLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}

-(UIButton*)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
        _addBtn.layer.masksToBounds=YES;
        _addBtn.layer.cornerRadius=6.0;
        [_addBtn setTitleColor:[UIColor colorWithHexString:@"#FF6600"] forState:UIControlStateNormal];
        _addBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_addBtn setImage:[UIImage imageNamed:@"account_add"] forState:UIControlStateNormal];
        _addBtn.enabled=NO;
//        [_addBtn addTarget:self action:@selector(addSubAccountAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addBtn];
        _addBtn.titleEdgeInsets=UIEdgeInsetsMake(0,4, 0,-4);
        if (IsBoldSize()) {
            _addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 7);
        }
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(25);
            make.right.mas_equalTo(self.contentView).offset(-25);
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(48);
        }];
    }
    return _addBtn;
}

-(void)reloadUIWithType:(NSInteger)type withIsProject:(BOOL)isProject
{
    if (type==1) {  //试镜
        if (isProject) {
            self.titleLab.text=@"选择试镜项目";
            [self arrow];
        }
        else
        {
            [self.addBtn setTitle:@"暂无试镜项目，立即去新建" forState:UIControlStateNormal];
        }
    }
    else   //拍摄
    {
        if (isProject) {
            self.titleLab.text=@"选择拍摄项目";
            [self arrow];
        }
        else
        {
            [self.addBtn setTitle:@"暂无拍摄项目，立即去新建" forState:UIControlStateNormal];
        }
    }
}


@end
