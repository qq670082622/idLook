/*
 @header  MyWorkHeadView.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/30
 @description
 
 */

#import "MyWorkHeadView.h"

@interface MyWorkHeadView ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *lineV;

@property(nonatomic,strong)UILabel *bigTitleLab;
@property(nonatomic,strong)UILabel *bigDesLab;

@end

@implementation MyWorkHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:18.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.bottom.mas_equalTo(self);
        }];
    }
    return _titleLab;
}

-(UIView*)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor=Public_LineGray_Color;
        [self addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self).offset(-15);
            make.top.mas_equalTo(self).offset(48);
            make.height.mas_equalTo(1.0);
        }];
    }
    return _lineV;
}

-(UILabel*)bigTitleLab
{
    if (!_bigTitleLab) {
        _bigTitleLab=[[UILabel alloc]init];
        [self addSubview:_bigTitleLab];
        _bigTitleLab.font=[UIFont boldSystemFontOfSize:21.0];
        _bigTitleLab.textColor=Public_Text_Color;
        [_bigTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lineV).offset(0);
            make.bottom.mas_equalTo(self.lineV);
        }];
    }
    return _bigTitleLab;
}

-(UILabel*)bigDesLab
{
    if (!_bigDesLab) {
        _bigDesLab=[[UILabel alloc]init];
        [self addSubview:_bigDesLab];
        _bigDesLab.font=[UIFont systemFontOfSize:13.0];
        _bigDesLab.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
        [_bigDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bigTitleLab.mas_right).offset(0);
            make.bottom.mas_equalTo(self.lineV);
        }];
    }
    return _bigDesLab;
}

-(void)reloadUIWithModel:(WorksModel *)model withType:(NSInteger)type
{
    self.titleLab.text=model.type;
    if (type==0) {
        self.lineV.hidden=YES;
        self.bigTitleLab.hidden=YES;
        self.bigDesLab.hidden=YES;
    }
    else
    {
        self.lineV.hidden=NO;
        self.bigTitleLab.hidden=NO;
        self.bigDesLab.hidden=NO;
        if (type==1) {
            self.bigTitleLab.text=@"图片";
            self.bigDesLab.text=@"PHOTOS";
        }
        else if(type==2)
        {
            self.bigTitleLab.text=@"视频";
            self.bigDesLab.text=@"VIEDOS";
        }

    }
}


@end
