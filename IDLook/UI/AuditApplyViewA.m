//
//  AuditApplyViewA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditApplyViewA.h"

@interface AuditApplyViewA ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)AuditDescSubV *descView1;  //描述内容1
@property(nonatomic,strong)AuditDescSubV *descView2;  //描述内容2
@property(nonatomic,strong)UIButton *selectBtn1;  //选择按钮1
@property(nonatomic,strong)UIButton *selectBtn2;  //选择按钮2

@end

@implementation AuditApplyViewA

-(id)init
{
    if (self=[super init]) {
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
        [self addSubview:_bgV];
        _bgV.layer.masksToBounds=YES;
        _bgV.layer.cornerRadius=6.0;
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(12);
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self);
        }];
    }
    return _bgV;
}


-(void)initUI
{
    UILabel *titleLab1 = [[UILabel alloc] init];
    titleLab1.font = [UIFont systemFontOfSize:15];
    titleLab1.textColor = Public_Text_Color;
    [self addSubview:titleLab1];
    [titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.top.mas_equalTo(self.bgV).offset(15);
    }];
    titleLab1.text=@"高端选角";
    
    UIButton *selectBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:selectBtn1];
    [selectBtn1 setImage:[UIImage imageNamed:@"order_click_n"] forState:UIControlStateNormal];
    [selectBtn1 setImage:[UIImage imageNamed:@"order_click_h"] forState:UIControlStateSelected];
    [selectBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgV).offset(-2);
        make.centerY.mas_equalTo(titleLab1);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    [selectBtn1 addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtn1=selectBtn1;
    selectBtn1.selected=YES;
    
    UILabel *priceLab1 = [[UILabel alloc] init];
    priceLab1.font = [UIFont boldSystemFontOfSize:15];
    priceLab1.textColor = Public_Text_Color;
    [self addSubview:priceLab1];
    [priceLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(selectBtn1.mas_left).offset(0);
        make.centerY.mas_equalTo(titleLab1);
    }];
    priceLab1.text=@"￥5000/天";
    
    //描述view
    AuditDescSubV *descView1 = [[AuditDescSubV alloc]init];
    [self addSubview:descView1];
    descView1.clipsToBounds=YES;
    descView1.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
    descView1.layer.cornerRadius=5;
    descView1.layer.masksToBounds=YES;
    [descView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.centerX.mas_equalTo(self.bgV);
        make.top.mas_equalTo(titleLab1.mas_bottom).offset(10);
        make.height.mas_equalTo(195);
    }];
    self.descView1=descView1;
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=Public_Background_Color;
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.centerX.mas_equalTo(self.bgV);
        make.top.mas_equalTo(descView1.mas_bottom).offset(15);
        make.height.mas_equalTo(0.5);
    }];
    
    //
    UILabel *titleLab2 = [[UILabel alloc] init];
    titleLab2.font = [UIFont systemFontOfSize:15];
    titleLab2.textColor = Public_Text_Color;
    [self addSubview:titleLab2];
    [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.top.mas_equalTo(lineV).offset(14);
    }];
    titleLab2.text=@"标准选角";
    
    UIButton *selectBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:selectBtn2];
    [selectBtn2 setImage:[UIImage imageNamed:@"order_click_n"] forState:UIControlStateNormal];
    [selectBtn2 setImage:[UIImage imageNamed:@"order_click_h"] forState:UIControlStateSelected];
    [selectBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgV).offset(-2);
        make.centerY.mas_equalTo(titleLab2);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    [selectBtn2 addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtn2=selectBtn2;
    
    UILabel *priceLab2 = [[UILabel alloc] init];
    priceLab2.font = [UIFont boldSystemFontOfSize:15];
    priceLab2.textColor = Public_Text_Color;
    [self addSubview:priceLab2];
    [priceLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(selectBtn2.mas_left).offset(0);
        make.centerY.mas_equalTo(titleLab2);
    }];
    priceLab2.text=@"￥3000/天";
    
    //描述view
    AuditDescSubV *descView2 = [[AuditDescSubV alloc]init];
    [self addSubview:descView2];
    descView2.clipsToBounds=YES;
    descView2.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
    descView2.layer.cornerRadius=5;
    descView2.layer.masksToBounds=YES;
    [descView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.centerX.mas_equalTo(self.bgV);
        make.top.mas_equalTo(titleLab2.mas_bottom).offset(10);
        make.height.mas_equalTo(0);
    }];
    self.descView2=descView2;
    
    NSString *title1=@"高端试镜提供的服务包括但不限：";
    NSArray *array1 = @[@"专业平面影棚，200平米+空间，高级灯光打光，全画幅单反拍摄",
                       @"专业的摄影师拍摄，专业视频和平面摄影，根据需求分别进行不同内容的拍摄",
                       @"专业的后期剪辑，拍摄完后根据需求进行后期处理，确保成品品质",
                       @"一对一专属客服，全程跟踪与服务，您有任何需求都可随时联系专属客服为您服务"];
    
    NSString *title2=@"常规试镜提供的服务包括但不限：";
    NSArray *array2= @[@"Casting影棚，专业灯光打光，单反、摄影机拍摄",
                        @"试镜拍摄，根据需求进行模卡拍摄以及专业视频试镜",
                        @"后期剪辑，拍摄完后会进行后期处理，确保成品品质",
                        @"一对一专属客服，全程跟踪与服务，您有任何需求都可随时联系专属客服为您服务"];

    [self.descView1 reloadUIWithArray:array1 withTitle:title1];
    [self.descView2 reloadUIWithArray:array2 withTitle:title2];
}


-(void)selectAction:(UIButton*)sender
{
    if (sender.selected) {
        return;
    }
    
    NSInteger type=2;
    if ([sender isEqual:self.selectBtn1]) {
        self.selectBtn1.selected=YES;
        self.selectBtn2.selected=NO;
        [self.descView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(195);
        }];
        [self.descView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        type=2;
    }
    else
    {
        self.selectBtn1.selected=NO;
        self.selectBtn2.selected=YES;
        [self.descView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.descView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(195);
        }];
        type=1;
    }
    
    if (self.auditTypeSelectBlock) {
        self.auditTypeSelectBlock(type);
    }
}


@end


@interface AuditDescSubV ()

@end

@implementation AuditDescSubV

-(id)init
{
    if (self=[super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
   
}

-(void)reloadUIWithArray:(NSArray*)array withTitle:(NSString*)title
{
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:12];
    titleLab.textColor = Public_DetailTextLabelColor;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self).offset(10);
    }];
    titleLab.text=title;

    for (int i=0; i<array.count; i++) {
    
        MLLabel *descLab = [[MLLabel alloc]init];
        descLab.font=[UIFont systemFontOfSize:12];
        descLab.numberOfLines=0;
        descLab.lineSpacing=3;
        descLab.textAlignment=NSTextAlignmentLeft;
        descLab.textColor=Public_DetailTextLabelColor;
        descLab.text=array[i];
        [self addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(20);
            make.right.mas_equalTo(self).offset(-15);
            make.top.mas_equalTo(self).offset(34+38*i);
            make.height.mas_equalTo(38);
        }];
        
        UILabel *pointLab = [[UILabel alloc]init];
        pointLab.text=@"• ";
        pointLab.textColor=[UIColor colorWithHexString:@"#D8D8D8"];
        [self addSubview:pointLab];
        [pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(5);
            make.centerY.mas_equalTo(descLab);
        }];
    }
}

@end
