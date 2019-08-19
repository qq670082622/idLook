//
//  AssetsSelectPopV.m
//  IDLook
//
//  Created by HYH on 2018/5/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AssetsSelectPopV.h"
#import "BirthSelectV.h"

@interface AssetsSelectPopV ()
@property(nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)NSString *selectStr;
@property(nonatomic,assign)NSInteger selectTag;
@property(nonatomic,strong)NSArray *dataS;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)CGFloat maskHeight;
@end

@implementation AssetsSelectPopV

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
//        self.alpha=0.0;
//        self.backgroundColor =  [[UIColor blackColor]colorWithAlphaComponent:0.5];
        
        UIView *bgV = [[UIView alloc]init];
        [self addSubview:bgV];
        bgV.backgroundColor= [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        tap.numberOfTapsRequired = 1;
        [bgV addGestureRecognizer:tap];
        
        UIView *maskV = [[UIView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,0)];
        maskV.backgroundColor = [UIColor whiteColor];
//        maskV.alpha=0.0;
        [self addSubview:maskV];
        self.maskV=maskV;
        
        self.clipsToBounds=YES;
        
        self.selectStr=@"";
        self.type=0;
    }
    return self;
}


//重置
-(void)resetAction
{
    for (id obj in self.maskV.subviews) {
        if ([[obj class] isEqual:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            if (button.tag>=100)
            {
                [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
                button.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
                button.selected=NO;
            }
        }
    }
    self.selectStr=@"";
}

//确定
-(void)confirmAction
{
    self.SelectConditionVBlock(self.selectStr,self.type,self.selectTag);
    [self hide];
}


- (void)showPopViewWithType:(NSInteger)type withSelect:(NSString *)select
{
    self.selectStr=select;
    self.type=type;
    self.hidden=NO;
    
    if (type==0) {
        self.maskHeight=180;
        self.dataS=@[@"近一周",@"近一个月",@"近三个月",@"近半年",@"近一年"];
        [self initUI1];
    }
    else
    {
        self.maskHeight=180;
        self.dataS=@[@"全部分类",@"试镜",@"拍摄",@"余额提现"];
        [self initUI1];
    }

    self.maskV.frame=CGRectMake(0, -self.maskHeight, UI_SCREEN_WIDTH, self.maskHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    self.maskV.frame=CGRectMake(0,0, UI_SCREEN_HEIGHT, self.maskHeight);
    
    [UIView commitAnimations];
}

-(void)hide
{
    self.hideBlock(self.type);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.frame=CGRectMake(0,-self.maskHeight,UI_SCREEN_WIDTH,self.maskHeight);
    self.hidden=YES;
    
    [UIView commitAnimations];
    
}

- (void)clearSubV
{
    self.hidden=YES;
}

-(void)initUI1
{
    for (UIView *view in self.maskV.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat width = (UI_SCREEN_WIDTH-30-24)/3;
    for (int i = 0; i<self.dataS.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self.maskV addSubview:button];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=3.0;
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;

        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [button setTitle:self.dataS[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.maskV).offset(15+(width+12)*(i%3));
            make.top.mas_equalTo(self.maskV).offset(30+(i/3)*44);
            make.size.mas_equalTo(CGSizeMake(width, 32));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.dataS[i] isEqualToString:self.selectStr]) {
            [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
            button.layer.borderColor=Public_Red_Color.CGColor;
            button.selected=YES;
            self.selectTag=i;
        }
    }
    
    UIButton *resetBtn=[[UIButton alloc]init];
    [self.maskV addSubview:resetBtn];
    resetBtn.layer.borderColor=Public_LineGray_Color.CGColor;
    resetBtn.layer.borderWidth=0.5;
    resetBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV);
        make.bottom.mas_equalTo(self.maskV);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH/2, 45));
    }];
    [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmBtn=[[UIButton alloc]init];
    [self.maskV addSubview:confirmBtn];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.backgroundColor=Public_Red_Color;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.maskV);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH/2, 45));
    }];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickType:(UIButton*)sender
{
    
    for (int i = 0; i<self.dataS.count; i++) {
        UIButton * button = (UIButton*)[self viewWithTag:100+i];
        if (i==sender.tag-100) {
            [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
            button.layer.borderColor=Public_Red_Color.CGColor;
            button.selected=YES;
        }
        else
        {
            [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
            
            button.selected=NO;
        }
    }
    self.selectStr=sender.titleLabel.text;
    self.selectTag=sender.tag-100;
}

-(void)initUI2
{
    for (UIView *view in self.maskV.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat width1 = (UI_SCREEN_WIDTH-30-35)/2;
    for (int i = 0; i<2; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self.maskV addSubview:button];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=3.0;
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
        
        button.tag=1000+i;
        button.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [button setTitle:self.dataS[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.maskV).offset(15+(width1+35)*(i%2));
            make.top.mas_equalTo(self.maskV).offset(30);
            make.size.mas_equalTo(CGSizeMake(width1, 32));
        }];
        [button addTarget:self action:@selector(dataClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UILabel *lab =[[UILabel alloc]init];
    lab.text=@"至";
    lab.textColor=[UIColor colorWithHexString:@"#666666"];
    lab.font=[UIFont systemFontOfSize:13];
    [self.maskV addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.maskV).offset(37);
    }];
    
    CGFloat width = (UI_SCREEN_WIDTH-30-24)/3;

    for (int i = 2; i<self.dataS.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self.maskV addSubview:button];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=3.0;
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
        
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [button setTitle:self.dataS[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.maskV).offset(15+(width+12)*((i+1)%3));
            make.bottom.mas_equalTo(self.maskV).offset(-75);
            make.size.mas_equalTo(CGSizeMake(width, 32));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *resetBtn=[[UIButton alloc]init];
    [self.maskV addSubview:resetBtn];
    resetBtn.layer.borderColor=Public_LineGray_Color.CGColor;
    resetBtn.layer.borderWidth=0.5;
    resetBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV);
        make.bottom.mas_equalTo(self.maskV);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH/2, 45));
    }];
    [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmBtn=[[UIButton alloc]init];
    [self.maskV addSubview:confirmBtn];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.backgroundColor=Public_Red_Color;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.maskV);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH/2, 45));
    }];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)dataClick:(UIButton*)sender
{
    BirthSelectV *birthV = [[BirthSelectV alloc] init];
    birthV.didSelectDate = ^(NSString *dateStr){
        [sender setTitle:dateStr forState:UIControlStateNormal];
    };
    [birthV showWithString:sender.titleLabel.text withType:DateTypeDay];
    
}

@end
