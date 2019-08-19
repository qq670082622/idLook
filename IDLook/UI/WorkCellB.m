//
//  WorkCellB.m
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "WorkCellB.h"

@interface WorkCellB ()
@property(nonatomic,strong)UIImageView *icon;  //图片
@property(nonatomic,strong)UIView *typeView;    //关键字类型
@property(nonatomic,strong)UIButton *selectBtn;  //选择按钮
@property(nonatomic,strong)UIButton *statusBtn;   //审核状态
@property(nonatomic,strong)UIButton *timeBtn;     //视频时间
@property(nonatomic,strong)WorksModel *model;

@end

@implementation WorkCellB


-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.cornerRadius=5.0;
        _icon.layer.masksToBounds=YES;
        _icon.userInteractionEnabled=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.backgroundColor=[UIColor blackColor];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-40);
        }];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAction)];
        [_icon addGestureRecognizer:tap];
    }
    return _icon;
}


-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"works_click_normal"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"works_click_select"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(6);
            make.right.mas_equalTo(self.contentView).offset(-6);
        }];
        [_selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UIButton*)statusBtn
{
    if (!_statusBtn) {
        _statusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_statusBtn];
        _statusBtn.enabled=NO;
        _statusBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_statusBtn setTitle:@"审核中" forState:UIControlStateNormal];
        [_statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_statusBtn setBackgroundImage:[UIImage imageNamed:@"work_status"] forState:UIControlStateNormal];
        [_statusBtn setBackgroundImage:[UIImage imageNamed:@"work_status"] forState:UIControlStateDisabled];
        [_statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon).offset(0);
            make.top.mas_equalTo(self.icon).offset(0);
        }];
    }
    return _statusBtn;
}

-(UIButton*)timeBtn
{
    if (!_timeBtn) {
        _timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_timeBtn];
        _timeBtn.layer.masksToBounds=YES;
        _timeBtn.layer.cornerRadius=9;
        _timeBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
        _timeBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_timeBtn setTitle:@"00:00" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeBtn setImage:[UIImage imageNamed:@"u_video_s"] forState:UIControlStateNormal];
        [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon).offset(6);
            make.bottom.mas_equalTo(self.icon).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
        _timeBtn.hidden=YES;
    }
    return _timeBtn;
}


-(UIView*)typeView
{
    if (!_typeView) {
        _typeView=[[UIView alloc]init];
        [self.contentView addSubview:_typeView];
        [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.icon.mas_bottom).offset(4);
        }];
    }
    return _typeView;
}

-(void)reloadUIWithModel:(WorksModel*)model
{
    self.model=model;

    if (model.workType==WorkTypeIntroduction) {
        [self.icon sd_setImageWithUrlStr:model.cutvideo placeholderImage:[UIImage imageNamed:@"default_photo"]];
        self.timeBtn.hidden=NO;
    }
    else if (model.workType==WorkTypeMordCard)
    {
        [self.icon sd_setImageWithUrlStr:model.imageurl placeholderImage:[UIImage imageNamed:@"default_photo"]];
        self.timeBtn.hidden=YES;
    }
    [self.timeBtn setTitle:model.timevideo forState:UIControlStateNormal];

    if (model.isEdit) {
        self.selectBtn.hidden=NO;
    }
    else
    {
        self.selectBtn.hidden=YES;
    }
    
    if (model.isSelect) {
        self.selectBtn.selected=YES;
    }
    else
    {
        self.selectBtn.selected=NO;
    }
    
    if (model.status==0) {
        self.statusBtn.hidden=NO;
    }
    else
    {
        self.statusBtn.hidden=YES;
    }
    
    for (UIView *view in self.typeView.subviews) {
        [view removeFromSuperview];
    }
    
    if (model.keyword.length>0 || model.role>0) {
        NSArray  *array = [model.keyword componentsSeparatedByString:@"|"];
        
        NSString *role = @"";
        NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
        for (int i=0; i<array1.count; i++) {
            NSDictionary *dic = array1[i];
            if (model.role == [dic[@"attrid"] integerValue]) {
                role = dic[@"attrname"];
            }
        }
        
        NSMutableArray *dataS = [[NSMutableArray alloc]initWithArray:array];
        if (role.length>0) {
            [dataS addObject:role];
        }
        
        for (int i =0; i<dataS.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [self.typeView addSubview:btn];
            btn.layer.cornerRadius=3.0;
            btn.layer.masksToBounds=YES;
            btn.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
            [btn setTitleColor:[UIColor colorWithHexString:@"#BCBCBC"] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:12.0];
            [btn setTitle:dataS[i] forState:UIControlStateNormal];
            
            CGFloat width  = 60;
            if (i==2) {
                width = self.contentView.bounds.size.width - 64 *2 -4;
            }
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(64*i);
                make.centerY .mas_equalTo(self.typeView);
                make.size.mas_equalTo(CGSizeMake(width, 24));
            }];
        }
    }
}

-(void)selectAction
{
    if (self.model.isEdit) {
        self.chooseAction(!self.selectBtn.selected);
    }
    else
    {
        self.playAction();
    }
    
}

@end
