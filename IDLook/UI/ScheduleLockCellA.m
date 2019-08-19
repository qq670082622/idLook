//
//  ScheduleLockCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockCellA.h"

@interface ScheduleLockCellA ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *detialBtn;
@end

@implementation ScheduleLockCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self bgV];
        [self initUI];
    }
    return self;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        _bgV.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_bgV];
        _bgV.layer.masksToBounds=YES;
        _bgV.layer.cornerRadius=6.0;
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(12);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
        }];
    }
    return _bgV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.bgV).offset(12);
        }];
    }
    return _titleLab;
}

-(UIButton*)detialBtn
{
    if (!_detialBtn) {
        _detialBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_detialBtn setImage:[UIImage imageNamed:@"project_arrow"] forState:UIControlStateNormal];
        [_detialBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detialBtn setTitleColor:[UIColor colorWithHexString:@"#FF6600"] forState:UIControlStateNormal];
        _detialBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_detialBtn];
        [_detialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self.bgV).offset(-15);
        }];
        [_detialBtn addTarget:self action:@selector(detialAction) forControlEvents:UIControlEventTouchUpInside];
        
        _detialBtn.titleLabel.backgroundColor = _detialBtn.backgroundColor;
        _detialBtn.imageView.backgroundColor = _detialBtn.backgroundColor;
        //在使用一次titleLabel和imageView后才能正确获取titleSize
        CGSize titleSize = _detialBtn.titleLabel.bounds.size;
        CGSize imageSize = _detialBtn.imageView.bounds.size;
        CGFloat interval = 1.0;
        _detialBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        _detialBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + 5), 0, imageSize.width + 5);
    }
    return _detialBtn;
}

-(void)initUI
{
    NSArray *array = @[@"项目编号：",@"项目简介：",@"拍摄城市：",@"预拍周期："];
    for (int i =0; i<array.count; i++) {
        UILabel *titleLab=[[UILabel alloc]init];
        titleLab.font=[UIFont systemFontOfSize:13];
        titleLab.textColor=Public_DetailTextLabelColor;
        [self.bgV addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.bgV).offset(42+i*24);
            make.size.mas_equalTo(CGSizeMake(72, 24));
        }];
        titleLab.text=array[i];
        
        UILabel *contentLab=[[UILabel alloc]init];
        contentLab.font=[UIFont systemFontOfSize:13];
        contentLab.textColor=Public_Text_Color;
        contentLab.textAlignment=NSTextAlignmentLeft;
        contentLab.tag=1000+i;
        [self.bgV addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(84);
            make.right.mas_equalTo(self.bgV).offset(-25);
            make.centerY.mas_equalTo(titleLab);
        }];
    }
}

-(void)reloadUIWithProjectInfo:(NSDictionary*)dic
{
    if (dic==nil) return;

    [self bgV];
    self.titleLab.text=dic[@"projectName"];
    [self detialBtn];
    
    NSArray *array = @[dic[@"projectId"],dic[@"projectDesc"],dic[@"projectCity"],[NSString stringWithFormat:@"%@至%@",dic[@"projectStart"],dic[@"projectEnd"]]];
    for (int i =0; i<array.count; i++) {
        UILabel *lab = [self.contentView viewWithTag:1000+i];
        lab.text=array[i];
    }
}

//查看详情
-(void)detialAction
{
    if (self.lookProjectDetialBlock) {
        self.lookProjectDetialBlock();
    }
}

@end
