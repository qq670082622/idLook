//
//  AuditServiceDetialCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditServiceDetialCellA.h"

@interface AuditServiceDetialCellA ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *priceLab;  //费用
@property(nonatomic,strong)UILabel *stateLab;  //状态
@property(nonatomic,strong)UILabel *dayLab;  // 天数
@property(nonatomic,strong)MLLabel *remarkLab;  //备注

@end

@implementation AuditServiceDetialCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UILabel *titleLab=[[UILabel alloc]init];
    titleLab.font=[UIFont boldSystemFontOfSize:18];
    titleLab.textColor=Public_Text_Color;
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.top.mas_equalTo(self.contentView).offset(16);
    }];
    self.titleLab=titleLab;
    
    //费用
    UILabel *priceLab=[[UILabel alloc]init];
    priceLab.font=[UIFont boldSystemFontOfSize:18];
    priceLab.textColor=Public_Red_Color;
    priceLab.text=@"¥2000";
    [self.contentView addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(titleLab);
    }];
    self.priceLab=priceLab;
    
    //费用标题
    UILabel *priceTitleLab=[[UILabel alloc]init];
    priceTitleLab.font=[UIFont systemFontOfSize:13];
    priceTitleLab.textColor=Public_Text_Color;
    priceTitleLab.text=@"选角费用";
    [self.contentView addSubview:priceTitleLab];
    [priceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(priceLab.mas_left).offset(-3);
        make.centerY.mas_equalTo(titleLab);
    }];
    
    //状态
    UILabel *stateLab=[[UILabel alloc]init];
    stateLab.font=[UIFont systemFontOfSize:12];
    stateLab.textColor=Public_Red_Color;
    stateLab.text=@"等待支付";
    [self.contentView addSubview:stateLab];
    [stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(5);
    }];
    self.stateLab=stateLab;
    
    //说明view
    UIView *explainView = [[UIView alloc]init];
    explainView.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
    [self.contentView addSubview:explainView];
    [explainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self).offset(77);
        make.height.mas_equalTo(54);
    }];
    
    UIImageView *promtV=[[UIImageView alloc]init];
    [explainView addSubview:promtV];
    promtV.contentMode=UIViewContentModeScaleAspectFill;
    promtV.image=[UIImage imageNamed:@"order_promt"];
    [promtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(explainView);
        make.left.mas_equalTo(explainView).offset(15);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    MLLabel *descLab = [[MLLabel alloc] init];
    descLab.font = [UIFont systemFontOfSize:12];
    descLab.numberOfLines=0;
    descLab.lineSpacing=4.0;
    descLab.textColor =[UIColor colorWithHexString:@"#FF6600"];
    [explainView addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(explainView);
        make.left.mas_equalTo(explainView).offset(40);
        make.right.mas_equalTo(explainView).offset(-15);
    }];
    descLab.text=@"脸探平台已收到您的订单，工作人员会在1个工作日内通过电话联系您，请留意。";
    
    //
    UILabel *infoTitleLab=[[UILabel alloc]init];
    infoTitleLab.font=[UIFont boldSystemFontOfSize:16];
    infoTitleLab.textColor=Public_Text_Color;
    infoTitleLab.text=@"选角信息";
    [self.contentView addSubview:infoTitleLab];
    [infoTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.top.mas_equalTo(explainView.mas_bottom).offset(12);
    }];
    
    NSArray *array = @[@"选角人数：",@"备注："];
    for (int i=0; i<array.count; i++) {
        UILabel *infoLab1=[[UILabel alloc]init];
        infoLab1.font=[UIFont systemFontOfSize:13];
        infoLab1.textColor=Public_DetailTextLabelColor;
        infoLab1.text=array[i];
        [self.contentView addSubview:infoLab1];
        [infoLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(infoTitleLab.mas_bottom).offset(8+i*25);
        }];
    }
    
    UILabel *dayLab=[[UILabel alloc]init];
    dayLab.font=[UIFont systemFontOfSize:13];
    dayLab.textColor=Public_Text_Color;
    dayLab.numberOfLines=0;
    dayLab.text=@"无";
    [self.contentView addSubview:dayLab];
    [dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(80);
        make.top.mas_equalTo(infoTitleLab.mas_bottom).offset(8);
    }];
    self.dayLab=dayLab;
    
    MLLabel *remarkLab=[[MLLabel alloc]init];
    remarkLab.font=[UIFont systemFontOfSize:13];
    remarkLab.textColor=Public_Text_Color;
    remarkLab.numberOfLines=0;
    remarkLab.lineSpacing=5;
    remarkLab.text=@"无";
    [self.contentView addSubview:remarkLab];
    [remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(80);
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.top.mas_equalTo(infoTitleLab.mas_bottom).offset(8+25);
    }];
    self.remarkLab=remarkLab;
    
}

-(void)reloadUIWithModel:(RoleServiceModel*)model;
{
    self.titleLab.text = model.serviceTypeName;
    self.priceLab.text= [NSString stringWithFormat:@"¥%.0f",model.totalPrice];
    
    NSString *str=@"";
    switch (model.status) {
        case 0:
            str=@"待支付";
            break;
        case 1:
            str=@"已支付";
            break;
        case 2:
            str=@"已完成";
            break;
        case 3:
            str=@"已取消";
            break;
        default:
            break;
    }
    self.stateLab.text=str;
    
    self.dayLab.text = [NSString stringWithFormat:@"%ld人",model.count];
    self.remarkLab.text = model.remark.length==0?@"无":model.remark;
    
}


@end
