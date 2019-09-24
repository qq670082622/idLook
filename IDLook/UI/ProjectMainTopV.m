//
//  ProjectMainTopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectMainTopV.h"

@interface ProjectMainTopV ()
@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@end

@implementation ProjectMainTopV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
    }
    return self;
}

-(void)reloadUIWithType:(NSInteger)type withProjectInfo:(NSDictionary *)info withState:(NSInteger)state
{
    if (type==0) {
        [self initUI1];
    }
    else
    {
        [self initUI2WithInfo:info withState:state];
    }
}

//无项目时加载ui
-(void)initUI1
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *bg= [[UIImageView alloc]init];
    [self addSubview:bg];
    bg.userInteractionEnabled=YES;
    bg.image=[UIImage imageNamed:@"project_bg_01"];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];
    
    //标题
    UILabel *titleLab=[[UILabel alloc]init];
    titleLab.textColor=[UIColor whiteColor];
    titleLab.text=@"项目";
    titleLab.font=[UIFont systemFontOfSize:18];
    [bg addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.bottom.mas_equalTo(bg).offset(-10);
    }];
    
    //新建项目
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newBtn setTitle:@"新建项目" forState:UIControlStateNormal];
    [newBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    newBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [bg addSubview:newBtn];
    [newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg).offset(-13);
        make.centerY.mas_equalTo(titleLab);
    }];
    [newBtn addTarget:self action:@selector(newProjectAction) forControlEvents:UIControlEventTouchUpInside];
}

//有项目时加载ui
-(void)initUI2WithInfo:(NSDictionary*)dic withState:(NSInteger)state
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    NSString *projectName = dic[@"projectName"];  //项目名称
    NSInteger serviceFee = [dic[@"projectServiceFeePerDay"]integerValue];  //服务费
    NSInteger projectDays = [dic[@"projectDays"]integerValue];  //项目天数
    BOOL serviceFeePaid = [dic[@"serviceFeePaid"]boolValue];  //服务费是否已支付
    
    UIImageView *bg= [[UIImageView alloc]init];
    [self addSubview:bg];
    bg.userInteractionEnabled=YES;
    bg.image=[UIImage imageNamed:@"project_bg_02"];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];
    
     BOOL isX = [UIApplication sharedApplication].statusBarFrame.size.height==20?NO:YES;
    //标题
    UILabel *titleLab=[[UILabel alloc]init];
    titleLab.textColor=[UIColor whiteColor];
    titleLab.text=projectName;
    titleLab.userInteractionEnabled=YES;
    [bg addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isX) {
             make.left.mas_equalTo(bg).offset(15);
        }else{
             make.left.mas_equalTo(bg).offset(80);
        }
       
        make.top.mas_equalTo(bg).offset(SafeAreaTabBarHeight_IphoneX+30);
    }];
    if (@available(iOS 8.2, *)) {
        titleLab.font=[UIFont systemFontOfSize:18 weight:UIFontWeightHeavy] ;  //字重
    } else {
        titleLab.font=[UIFont boldSystemFontOfSize:18];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookProjectDetial)];
    [titleLab addGestureRecognizer:tap];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   
    if (isX) {
         cancelBtn.frame = CGRectMake(7,20, 80, 48);
    }else{
          cancelBtn.frame = CGRectMake(7,17, 80, 48);
    }
   
    [cancelBtn setImage:[UIImage imageNamed:@"u_info_back_white"] forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@"u_info_back_white"] forState:UIControlStateHighlighted];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn setTitle:@"返回" forState:UIControlStateHighlighted];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(1, -13, -1, 13)];
    [cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-13, 0,13)];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:cancelBtn];
    //箭头
    UIImageView *arrow= [[UIImageView alloc]init];
    [bg addSubview:arrow];
    arrow.image=[UIImage imageNamed:@"project_arrow_white"];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.left.mas_equalTo(titleLab.mas_right).offset(5);
    }];
    
    //切换项目
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    switchBtn.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.2];
    switchBtn.layer.cornerRadius=9;
    switchBtn.layer.masksToBounds=YES;
    [switchBtn setTitle:@"切换项目" forState:UIControlStateNormal];
    [switchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    switchBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [bg addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(arrow.mas_right).offset(7);
        make.centerY.mas_equalTo(titleLab);
        make.size.mas_equalTo(CGSizeMake(60, 18));
    }];
    [switchBtn addTarget:self action:@selector(switchProjectAction) forControlEvents:UIControlEventTouchUpInside];
    
    //新建项目
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newBtn setTitle:@"新建项目" forState:UIControlStateNormal];
    [newBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    newBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [bg addSubview:newBtn];
    [newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg).offset(-13);
        make.centerY.mas_equalTo(titleLab);
    }];
    [newBtn addTarget:self action:@selector(newProjectAction) forControlEvents:UIControlEventTouchUpInside];
    
    //服务费
    UILabel *serviceLab=[[UILabel alloc]init];
    serviceLab.textColor=[[UIColor whiteColor]colorWithAlphaComponent:0.8];
    serviceLab.font=[UIFont systemFontOfSize:12];
    serviceLab.text= [NSString stringWithFormat:@"项目服务费￥%ld",projectDays*serviceFee];
    [bg addSubview:serviceLab];
    [serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(15);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(3);
    }];
    
    //说明
    UIButton *expainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [expainBtn setBackgroundImage:[UIImage imageNamed:@"project_expain_white"] forState:UIControlStateNormal];
    [bg addSubview:expainBtn];
    [expainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(serviceLab.mas_right).offset(3);
        make.centerY.mas_equalTo(serviceLab);
    }];
    [expainBtn addTarget:self action:@selector(expainAction) forControlEvents:UIControlEventTouchUpInside];
    
    //
    NSArray *array=@[@"询问档期",@"试镜",@"锁定档期",@"定妆",@"拍摄",@"授权书"];
    CGFloat width = (UI_SCREEN_WIDTH-15)/array.count;
    for (int i = 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:1000+i];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [bg addSubview:button];
        button.frame=CGRectMake(width*i+7,80+SafeAreaTabBarHeight_IphoneX, width, 30);
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *btn = (UIButton*)[self viewWithTag:1000+state];
    
    //slider
    UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(btn.center.x-27,btn.frame.origin.y+26, 54, 4)];
    slider.backgroundColor = [UIColor whiteColor];
    [self addSubview:slider];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:slider.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(50, 50)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = slider.bounds;
    maskLayer.path = maskPath.CGPath;
    slider.layer.mask = maskLayer;
    self.slider=slider;

}
-(void)cancel
{
    self.canelBlcok();
}
//查看项目详情
-(void)lookProjectDetial
{
    if (self.lookProjectdetialBlock) {
        self.lookProjectdetialBlock();
    }
}

//切换项目
-(void)switchProjectAction
{
    if (self.switchProjectBlock) {
        self.switchProjectBlock();
    }
}

//新建项目
-(void)newProjectAction
{
    if (self.addNewProjectBlock) {
        self.addNewProjectBlock();
    }
}

//服务费说明
-(void)expainAction
{
    if (self.serviceExplainBlock) {
        self.serviceExplainBlock();
    }
}

//切换
-(void)btnClicked:(UIButton*)sender
{
    self.curePage=sender.tag-1000;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame=CGRectMake(sender.center.x-27,sender.frame.origin.y+26, 54, 4);
    }];
    
    if (self.switchProjectStateBlock) {
        self.switchProjectStateBlock(self.curePage);
    }
}

@end
