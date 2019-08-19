//
//  UInfoBottomV.m
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UInfoBottomV.h"

@interface UInfoBottomV ()
@property(nonatomic,strong)UIButton *collectBtn;
@property(nonatomic,strong)UIButton *praiseBtn;
@end

@implementation UInfoBottomV

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
        if ([UserInfoManager getUserType]==UserTypeResourcer) {
            [self initUIWithResource];
        }
        else
        {
            [self initUIWithPur];
        }
    }
    return self;
}

//资源方
-(void)initUIWithResource
{
    CGFloat width = UI_SCREEN_WIDTH/3;
    
    //收藏
    UIButton *collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:collectBtn];
    collectBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [collectBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [collectBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
    [collectBtn setImage:[UIImage imageNamed:@"u_bottom_collect_n"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"u_bottom_collect_h"] forState:UIControlStateSelected];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(width, 54));
    }];
    collectBtn.imageEdgeInsets=UIEdgeInsetsMake(0,-5, 0,5);
    if (IsBoldSize()) {
        collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 14);
    }
    [collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.collectBtn=collectBtn;
    
    //点赞
    UIButton *praiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:praiseBtn];
    praiseBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [praiseBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [praiseBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
    [praiseBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [praiseBtn setTitle:@"已点赞" forState:UIControlStateSelected];
    [praiseBtn setImage:[UIImage imageNamed:@"u_bottom_praise_n"] forState:UIControlStateNormal];
    [praiseBtn setImage:[UIImage imageNamed:@"u_bottom_praise_h"] forState:UIControlStateSelected];
    [praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(width);
        make.size.mas_equalTo(CGSizeMake(width, 54));
    }];
    praiseBtn.imageEdgeInsets=UIEdgeInsetsMake(0,-5, 0,5);
    if (IsBoldSize()) {
        praiseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 14);
    }
    [praiseBtn addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.praiseBtn=praiseBtn;
    
    //评价
    UIButton *evaluateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:evaluateBtn];
    evaluateBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [evaluateBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [evaluateBtn setTitle:@"写评价" forState:UIControlStateNormal];
    [evaluateBtn setImage:[UIImage imageNamed:@"u_bottom_evaluate"] forState:UIControlStateNormal];
    [evaluateBtn setImage:[UIImage imageNamed:@"u_bottom_evaluate"] forState:UIControlStateSelected];
    [evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(width*2);
        make.size.mas_equalTo(CGSizeMake(width, 54));
    }];
    evaluateBtn.imageEdgeInsets=UIEdgeInsetsMake(0,-5, 0,5);
    if (IsBoldSize()) {
        evaluateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 14);
    }
    [evaluateBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

//购买方
-(void)initUIWithPur
{
    //客服电话
    UIButton *phoneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:phoneBtn];
    phoneBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [phoneBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [phoneBtn setTitle:@"客服" forState:UIControlStateNormal];
    [phoneBtn setImage:[UIImage imageNamed:@"u_info_service"] forState:UIControlStateNormal];
    [phoneBtn setImage:[UIImage imageNamed:@"u_info_service"] forState:UIControlStateSelected];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(25);
        make.size.mas_equalTo(CGSizeMake(60, 54));
    }];
//    phoneBtn.imageEdgeInsets=UIEdgeInsetsMake(0,-5, 0,5);
//    if (IsBoldSize()) {
//        phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 14);
//    }
    
    phoneBtn.imageView.backgroundColor = phoneBtn.backgroundColor;
    CGSize titleSize1 = phoneBtn.titleLabel.bounds.size;
    CGSize imageSize1 = phoneBtn.imageView.bounds.size;
    CGFloat interval1 = 1;
    [phoneBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize1.height + interval1, -(titleSize1.width + interval1))];
    [phoneBtn setTitleEdgeInsets:UIEdgeInsetsMake(imageSize1.height + interval1 + 5, -(imageSize1.width + interval1), 0, 0)];
    
    [phoneBtn addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //评价按钮
    UIButton *evaluateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:evaluateBtn];
    evaluateBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [evaluateBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [evaluateBtn setTitle:@"评价" forState:UIControlStateNormal];
    [evaluateBtn setImage:[UIImage imageNamed:@"u_info_evaluate"] forState:UIControlStateNormal];
    [evaluateBtn setImage:[UIImage imageNamed:@"u_info_evaluate"] forState:UIControlStateSelected];
    [evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(phoneBtn.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(60, 54));
    }];
    
    evaluateBtn.imageView.backgroundColor = evaluateBtn.backgroundColor;
    CGSize titleSize = evaluateBtn.titleLabel.bounds.size;
    CGSize imageSize = evaluateBtn.imageView.bounds.size;
    CGFloat interval = 1;
    [evaluateBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width + interval))];
    [evaluateBtn setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval + 5, -(imageSize.width + interval), 0, 0)];
    
    [evaluateBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
//#if 0
    //试镜下单按钮
//    UIButton *auditionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:auditionBtn];
//    auditionBtn.frame=CGRectMake(UI_SCREEN_WIDTH-235,7,110, 40);
//    auditionBtn.titleLabel.font=[UIFont systemFontOfSize:16];
//    [auditionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [auditionBtn setTitle:@"试镜下单" forState:UIControlStateNormal];
//    auditionBtn.backgroundColor=[UIColor colorWithHexString:@"#FF7A00"];
//    [auditionBtn addTarget:self action:@selector(auditionAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    //切左圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:auditionBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(4, 4)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = auditionBtn.bounds;
//    maskLayer.path = maskPath.CGPath;
//    auditionBtn.layer.mask = maskLayer;
//
//    //拍摄下单按钮
//    UIButton *shotBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:shotBtn];
//    shotBtn.frame=CGRectMake(UI_SCREEN_WIDTH-125,7, 110, 40);
//    shotBtn.titleLabel.font=[UIFont systemFontOfSize:16];
//    [shotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [shotBtn setTitle:@"拍摄下单" forState:UIControlStateNormal];
//    shotBtn.backgroundColor=Public_Red_Color;
//    [shotBtn addTarget:self action:@selector(shotAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    //切右圆角
//    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:shotBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(4, 4)];
//    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
//    maskLayer1.frame = shotBtn.bounds;
//    maskLayer1.path = maskPath1.CGPath;
//    shotBtn.layer.mask = maskLayer1;
//#endif
    
    //询问档期
    UIButton *scheduleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:scheduleBtn];
    scheduleBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    scheduleBtn.layer.masksToBounds=YES;
    scheduleBtn.layer.cornerRadius=4.0;
    [scheduleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scheduleBtn setTitle:@"询问档期" forState:UIControlStateNormal];
    scheduleBtn.backgroundColor=Public_Red_Color;
    [scheduleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(self).offset(7);
        make.size.mas_equalTo(CGSizeMake(208, 40));
    }];
    [scheduleBtn addTarget:self action:@selector(scheduleAction) forControlEvents:UIControlEventTouchUpInside];

}

//刷新收藏，点赞按钮
-(void)reloadUIWithInfo:(UserDetialInfoM *)info
{
    self.collectBtn.selected=info.isCollect;
    self.praiseBtn.selected=info.isPraise;
}


//客服
-(void)phoneAction:(UIButton*)sender
{
    if (self.phoneActionBlock) {
        self.phoneActionBlock();
    }
}

//评价
-(void)evaluateAction:(UIButton*)sender
{
    if (self.evaluateActionBlock) {
        self.evaluateActionBlock();
    }
}

//试镜下单
-(void)auditionAction:(UIButton*)sender
{
    if (self.auditionActionBlock) {
        self.auditionActionBlock();
    }
}

//拍摄下单
-(void)shotAction:(UIButton*)sender
{
    if (self.shotActionBlock) {
        self.shotActionBlock();
    }
}

//询问档期
-(void)scheduleAction
{
    if (self.askScheduleBlock) {
        self.askScheduleBlock();
    }
}

//收藏
-(void)collectAction:(UIButton*)sender
{
    if (self.collectBlock) {
        self.collectBlock();
    }
}

//点赞
-(void)praiseAction:(UIButton*)sender
{
    if (self.praiseBlock) {
        self.praiseBlock();
    }
}



@end
