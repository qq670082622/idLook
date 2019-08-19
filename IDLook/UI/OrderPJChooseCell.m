//
//  OrderPJChooseCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "OrderPJChooseCell.h"

@interface OrderPJChooseCell ()
@property(nonatomic,strong)UILabel *itemIDLab;
@property(nonatomic,strong)UILabel *itemNameLab;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,assign)BOOL isEdit;  //是否可以选择
@end

@implementation OrderPJChooseCell

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn setImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(0);
            make.size.mas_equalTo(CGSizeMake(46, 80));
        }];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UILabel*)itemIDLab
{
    if (!_itemIDLab) {
        _itemIDLab=[[UILabel alloc]init];
        _itemIDLab.font=[UIFont systemFontOfSize:16];
        _itemIDLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_itemIDLab];
        [_itemIDLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(46);
            make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(-3);
        }];
    }
    return _itemIDLab;
}

-(UILabel*)itemNameLab
{
    if (!_itemNameLab) {
        _itemNameLab=[[UILabel alloc]init];
        _itemNameLab.font=[UIFont systemFontOfSize:16.0];
        _itemNameLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_itemNameLab];
        [_itemNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(46);
            make.top.mas_equalTo(self.contentView.mas_centerY).offset(3);
        }];
    }
    return _itemNameLab;
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

-(void)reloadUIWithModel:(ProjectModel *)model
{
    [self arrow];
    self.itemIDLab.text=[NSString stringWithFormat:@"项目编号：%@",model.projectid];
    self.itemNameLab.text=[NSString stringWithFormat:@"项目名称：%@",model.name];
    self.selectBtn.selected=model.isChoose;
    
    //当前时间
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *curDay=[formatter stringFromDate:[NSDate date]];
    int dataCompare = [PublicManager compareOneDay:curDay withAnotherDay:model.end];
    
    if (dataCompare<=0) {
        self.itemIDLab.textColor=Public_Text_Color;
        self.itemNameLab.textColor=Public_Text_Color;
        [self.selectBtn setImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        self.isEdit=YES;
    }
    else
    {
        self.itemIDLab.textColor=Public_DetailTextLabelColor;
        self.itemNameLab.textColor=Public_DetailTextLabelColor;
        [self.selectBtn setImage:[UIImage imageNamed:@"work_disable"] forState:UIControlStateNormal];
        self.isEdit=NO;
    }
}

-(void)selectAction:(UIButton*)sender
{
    if (self.isEdit==NO) {
        [SVProgressHUD showImage:nil status:@"该项目已过拍摄时间，请选择其他项目。"];
        return;
    }
    
    if (self.selectProjectBlock) {
        self.selectProjectBlock();
    }
}

@end
