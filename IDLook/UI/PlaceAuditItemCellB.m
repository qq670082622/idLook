//
//  PlaceAuditItemCellB.m
//  IDLook
//
//  Created by Mr Hu on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceAuditItemCellB.h"
#import "ScriptModel.h"

@interface PlaceAuditItemCellB ()
@property(nonatomic,strong)UILabel *titleLab;    //简介标题
@property(nonatomic,strong)MLLabel *descLab;   //简介详情
@property(nonatomic,strong)UIView *scriptV;  //脚本图片view
@property(nonatomic,strong)UILabel *dateLab;    //最晚上传作品日期
@property(nonatomic,strong)UIView *expainV;    //附加说明view
@property(nonatomic,strong)UIButton *expendBtn;  //展开按钮

@end

@implementation PlaceAuditItemCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.clipsToBounds=YES;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"项目简介：";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(11);
        }];
    }
    return _titleLab;
}

-(MLLabel*)descLab
{
    if (!_descLab) {
        _descLab=[[MLLabel alloc]init];
        _descLab.font=[UIFont systemFontOfSize:16];
        _descLab.textColor=Public_Text_Color;
        _descLab.numberOfLines=0;
        _descLab.lineSpacing=5.0;
        [self.contentView addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(41);
            make.height.mas_lessThanOrEqualTo(50);
        }];
    }
    return _descLab;
}

-(UIView*)scriptV
{
    if (!_scriptV) {
        _scriptV = [[UIView alloc]init];
        [self.contentView addSubview:_scriptV];
        [_scriptV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.descLab.mas_bottom).offset(10);
            make.height.mas_equalTo(120);
        }];
    }
    return _scriptV;
}

-(UILabel*)dateLab
{
    if (!_dateLab) {
        _dateLab=[[UILabel alloc]init];
        _dateLab.font=[UIFont systemFontOfSize:16];
        _dateLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_dateLab];
        [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.scriptV.mas_bottom).offset(7);
        }];
    }
    return _dateLab;
}

-(UIView*)expainV
{
    if (!_expainV) {
        _expainV = [[UIView alloc]init];
        [self.contentView addSubview:_expainV];
        [_expainV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.dateLab.mas_bottom).offset(20);
            make.height.mas_equalTo(110);
        }];
    }
    return _expainV;
}

-(UIButton*)expendBtn
{
    if (!_expendBtn) {
        _expendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_expendBtn setImage:[UIImage imageNamed:@"orderdetial_down"] forState:UIControlStateNormal];
        [_expendBtn setImage:[UIImage imageNamed:@"orderdetial_up"] forState:UIControlStateSelected];
        [_expendBtn setTitle:@"展示完整信息" forState:UIControlStateNormal];
        [_expendBtn setTitle:@"收起" forState:UIControlStateSelected];
        _expendBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        _expendBtn.layer.borderColor=[UIColor colorWithHexString:@"#BCBCBC"].CGColor;
        _expendBtn.layer.borderWidth=0.5;
        _expendBtn.layer.cornerRadius=3.0;
        _expendBtn.layer.masksToBounds=YES;
        [_expendBtn setTitleColor:[UIColor colorWithHexString:@"#909090"] forState:UIControlStateNormal];
        [self.contentView addSubview:_expendBtn];
        [_expendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-20);
            make.size.mas_equalTo(CGSizeMake(114, 30));
        }];
        _expendBtn.imageEdgeInsets = UIEdgeInsetsMake(0,80, 0,-80);
        _expendBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-10, 0,10);
        
        [_expendBtn addTarget:self action:@selector(expendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expendBtn;
}

-(void)expendBtnAction
{
    self.expendBtn.selected = !self.expendBtn.selected;
    if (self.isExpendBlock) {
        self.isExpendBlock(self.expendBtn.selected);
    }
}

-(void)reloadUIModel:(ProjectModel *)model
{
    [self titleLab];
    self.descLab.text=model.desc;
    [self expainV];

    
    for (UIView *view in self.expainV.subviews) {
        [view removeFromSuperview];
    }
    
    for (UIView *view in self.scriptV.subviews) {
        [view removeFromSuperview];
    }

    NSMutableArray *urlArray=[NSMutableArray new];
    if (model.type==1) {
        for (int i=0; i<model.vdo.count; i++) {
            NSDictionary *dic = model.vdo[i];
            ScriptModel *model = [ScriptModel yy_modelWithDictionary:dic];
            model.type=1;
            [urlArray addObject:model];
        }
        
        for (int i=0; i<model.img.count; i++) {
            NSDictionary *dic = model.img[i];
            ScriptModel *model = [ScriptModel yy_modelWithDictionary:dic];
            model.type=2;
            [urlArray addObject:model];
        }
    }
    else
    {
        if (model.url.length>0) {
            urlArray = [NSMutableArray arrayWithArray:[model.url componentsSeparatedByString:@"|"]];
        }
    }

    CGFloat width = (UI_SCREEN_WIDTH -30-16)/3;
    [self.scriptV mas_updateConstraints:^(MASConstraintMaker *make) {
        if (urlArray.count>0) {
            make.height.mas_equalTo(((urlArray.count-1)/3+1)*(width+10));
        }
        else
        {
            make.height.mas_equalTo(0);
        }
    }];
    
    for (int i=0; i<urlArray.count; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.layer.cornerRadius=4.0;
        imageV.layer.masksToBounds=YES;
        imageV.contentMode=UIViewContentModeScaleAspectFill;
        [self.scriptV addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scriptV).offset((width+10)*(i/3));
            make.left.mas_equalTo(self.scriptV).offset(15+(width+8)*(i%3));
            make.size.mas_equalTo(CGSizeMake(width, width));
        }];

        UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [imageV addSubview:timeBtn];
        timeBtn.layer.masksToBounds=YES;
        timeBtn.layer.cornerRadius=9;
        timeBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
        timeBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [timeBtn setTitle:@"00:00" forState:UIControlStateNormal];
        [timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [timeBtn setImage:[UIImage imageNamed:@"u_video_s"] forState:UIControlStateNormal];
        [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageV).offset(6);
            make.bottom.mas_equalTo(imageV).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
        
        if (model.type==1) {
            ScriptModel *scriptModel = urlArray[i];
            if (scriptModel.type==1) {
                [imageV sd_setImageWithUrlStr:scriptModel.cuturl placeholderImage:[UIImage imageNamed:@"default_home"]];
                NSString *time = [PublicManager timeFormatted:scriptModel.duration];
                [timeBtn setTitle:time forState:UIControlStateNormal];
                timeBtn.hidden=NO;
            }
            else if (scriptModel.type==2)
            {
                [imageV sd_setImageWithUrlStr:scriptModel.imageurl placeholderImage:[UIImage imageNamed:@"default_home"]];
                timeBtn.hidden=YES;
            }
        }
        else
        {
            [imageV sd_setImageWithUrlStr:urlArray[i] placeholderImage:[UIImage imageNamed:@"default_home"]];
            timeBtn.hidden=YES;
        }

    }
    
    NSArray *expainArray ;
    if (model.type==1) {  //试镜
        self.dateLab.text = [NSString stringWithFormat:@"最晚上传作品日期：%@",model.auditionend];
        self.dateLab.hidden=NO;
        expainArray = @[@"广告拍摄附加说明",[NSString stringWithFormat:@"拍摄天数：%ld天",model.auditiondays],[NSString stringWithFormat:@"拍摄城市：%@",model.city],[NSString stringWithFormat:@"拍摄日期：%@至%@",model.start,model.end]];
    }
    else  //拍摄
    {
        self.dateLab.text = @"";
        self.dateLab.hidden=YES;
        expainArray = @[[NSString stringWithFormat:@"拍摄城市：%@",model.city],[NSString stringWithFormat:@"拍摄日期：%@至%@",model.start,model.end],[NSString stringWithFormat:@"肖像周期：%@",model.shotcycle],[NSString stringWithFormat:@"肖像范围：%@",model.shotregion]];
    }

    for (int i=0; i<expainArray.count; i++) {
        UILabel *lab = [[UILabel alloc]init];
        [self.expainV addSubview:lab];
        lab.font=[UIFont systemFontOfSize:16.0];
        lab.text=expainArray[i];
        if (model.type==1) {
            lab.textColor=[UIColor colorWithHexString:@"#909090"];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.expainV).offset(15);
                make.top.mas_equalTo(self.dateLab.mas_bottom).offset(20+(27*i));
            }];
        }
        else
        {
            lab.textColor=Public_Text_Color;
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.expainV).offset(15);
                make.top.mas_equalTo(self.scriptV.mas_bottom).offset(10+(27*i));
            }];
        }
    }
    
    self.expendBtn.selected=model.isExpend;
    if (model.isExpend) {  //是否展开
        [self.expendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        self.expendBtn.imageEdgeInsets = UIEdgeInsetsMake(0,30, 0,-30);
        [self.descLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(41);
        }];
        
        self.scriptV.hidden=NO;
        self.dateLab.hidden=NO;
        self.expainV.hidden=NO;
    }
    else
    {
        [self.expendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(114, 30));
        }];
        self.expendBtn.imageEdgeInsets = UIEdgeInsetsMake(0,80, 0,-80);
        
        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(41);
            make.height.mas_lessThanOrEqualTo(50);
        }];
        
        self.scriptV.hidden=YES;
        self.dateLab.hidden=YES;
        self.expainV.hidden=YES;
    }
}

@end
