//
//  AuditAppleViewC.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditAppleViewC.h"

@interface AuditAppleViewC ()
@property(nonatomic,strong)UIView *bgV;

@end

@implementation AuditAppleViewC

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
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.top.mas_equalTo(self.bgV).offset(12);
    }];
    titleLab.text=@"收费标准";
    
    UILabel *descLab = [[UILabel alloc] init];
    descLab.font = [UIFont systemFontOfSize:12];
    descLab.textColor = [UIColor colorWithHexString:@"#F7A84E"];
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(2);
    }];
    descLab.text=@"*脸探平台将按您最终选中的演员人数进行收费(非角色数量)";

    //表格
    FormSubV *subV=[[FormSubV alloc]init];
    [self addSubview:subV];
    subV.layer.cornerRadius=4;
    subV.layer.masksToBounds=YES;
    subV.layer.borderColor=Public_Background_Color.CGColor;
    subV.layer.borderWidth=1.0;
    [subV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.centerX.mas_equalTo(self.bgV);
        make.top.mas_equalTo(self.bgV).offset(65);
        make.height.mas_equalTo(124);
    }];
    
    //背景view
    UIView *bg1 = [[UIView alloc]init];
    [self addSubview:bg1];
    bg1.clipsToBounds=YES;
    bg1.backgroundColor=[UIColor colorWithHexString:@"#F8F8F8"];
    bg1.layer.cornerRadius=4;
    bg1.layer.masksToBounds=YES;
    [bg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgV).offset(15);
        make.centerX.mas_equalTo(self.bgV);
        make.top.mas_equalTo(self.bgV).offset(202);
        make.bottom.mas_equalTo(-15);
    }];
    
    UILabel *titleLab1 = [[UILabel alloc] init];
    titleLab1.font = [UIFont systemFontOfSize:14];
    titleLab1.textColor = Public_Text_Color;
    [self addSubview:titleLab1];
    [titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg1).offset(20);
        make.top.mas_equalTo(bg1).offset(10);
    }];
    titleLab1.text=@"费用说明：";
    
    NSArray *array1 = @[@"脸探选角服务收费标准，按最终选出的演员人数计算。 例：一个五口之家，其中三人使用了脸探选角服务，那么只收取这三人的选角服务费；",
                        @"脸探选角服务中，若发生未选中情况，则对该角色不收取费用。",
                        @"脸探选角服务中，对前景演员、群众演员不收取费用。",
                        @"脸探工作人员将在您使用选角服务的第一时间介入，并帮您进行选角。"];
    CGFloat totalH = 37;
    for (int i=0; i<array1.count; i++) {
        
        MLLabel *descLab = [[MLLabel alloc]init];
        descLab.font=[UIFont systemFontOfSize:12];
        descLab.numberOfLines=0;
        descLab.lineSpacing=3;
        descLab.textAlignment=NSTextAlignmentLeft;
        descLab.textColor=Public_DetailTextLabelColor;
        descLab.text=array1[i];
        [bg1 addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bg1).offset(20);
            make.right.mas_equalTo(bg1).offset(-15);
            make.top.mas_equalTo(bg1).offset(totalH);
        }];
        
        UILabel *pointLab = [[UILabel alloc]init];
        pointLab.text=@"• ";
        pointLab.textColor=[UIColor colorWithHexString:@"#D8D8D8"];
        [bg1 addSubview:pointLab];
        [pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bg1).offset(10);
            make.top.mas_equalTo(descLab).offset(-5);
        }];
        totalH =totalH + [self heighOfString:array1[i] font:[UIFont systemFontOfSize:12] width:UI_SCREEN_WIDTH-27*2-35]+7;
    }
}

//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 3;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<20?20:ceilf(size.height);
}


@end


@interface FormSubV ()

@end

@implementation FormSubV

-(id)init
{
    if (self=[super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIView *lineV1 = [[UIView alloc]init];
    lineV1.backgroundColor=Public_Background_Color;
    [self addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(32);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *lineV2 = [[UIView alloc]init];
    lineV2.backgroundColor=Public_Background_Color;
    [self addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(125);
        make.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(0.5);
    }];
    
    NSArray *array1 = @[@"人数",@"1-5人",@"6-9人",@"10人及以上"];
    NSArray *array2 = @[@"  单价",@"￥200/人",@"￥180/人",@"￥160/人"];
    CGFloat totalH = 7;
    for (int i=0; i<array1.count; i++) {
        UILabel *numberLab = [[UILabel alloc]init];
        numberLab.font=[UIFont systemFontOfSize:12];
        numberLab.textColor=Public_Text_Color;
        numberLab.text=array1[i];
        [self addSubview:numberLab];
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(30);
            make.top.mas_equalTo(self).offset(totalH);
        }];
        
        UILabel *priceLab = [[UILabel alloc]init];
        priceLab.text=array2[i];
        priceLab.font=[UIFont systemFontOfSize:15];
        priceLab.textColor=Public_Text_Color;
        [self addSubview:priceLab];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineV2).offset(55);
            make.centerY.mas_equalTo(numberLab);
        }];
        if (i==0) {
            totalH =totalH+37;
            priceLab.font=[UIFont systemFontOfSize:13];
        }
        else{
            totalH=totalH+26;
        }
        
        if (i>0) {
            NSString *str=array2[i];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(str.length-2,2)];
            priceLab.attributedText=attStr;
        }
    }

}

@end
