//
//  OrderSelectPopV.m
//  IDLook
//
//  Created by HYH on 2018/6/22.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderSelectPopV.h"

@interface OrderSelectPopV ()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)NSArray *dataS;
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)NSMutableArray *selectArray;
@property(nonatomic,assign)OrderCheckType type;
@end

@implementation OrderSelectPopV

-(NSMutableArray*)selectArray
{
    if (!_selectArray) {
        _selectArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _selectArray;
}

- (id)init
{
    if(self=[super init])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        Vheight=0;
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}

- (void)showWithType:(OrderCheckType)type withSelect:(NSArray *)select withTitle:(NSString *)title
{
    self.type=type;
    self.dataS=[PublicManager getOrderCellType:type];
    Vheight = 70+((self.dataS.count-1)/4)*44 + 44 + 12;
    
    for (int i=0; i<select.count; i++) {
        [self.selectArray addObject:select[i]];
    }
    
    UIWindow *showWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    if(!showWindow)return;
    
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    [showWindow addSubview:self];
    self.maskV=maskV;
    
    [self initUIWithTitle:title];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
    
    [UIView commitAnimations];
}

- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    [UIView commitAnimations];
}


- (void)initUIWithTitle:(NSString*)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [btn addTarget:self action:@selector(confirmSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.right.equalTo(self).offset(-10);
    }];
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.left.equalTo(self).offset(10);
    }];
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(45);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:16.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(btn);
    }];
    titleLab.text=title;

    CGFloat width = (UI_SCREEN_WIDTH-30-12*3)/4;
    for (int i = 0; i<self.dataS.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self addSubview:button];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=3.0;
        button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
        button.layer.borderWidth=0.5;
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [button setTitle:self.dataS[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15+(width+12)*(i%4));
            make.top.mas_equalTo(self).offset(70+(i/4)*44);
            make.size.mas_equalTo(CGSizeMake(width, 32));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.selectArray containsObject:self.dataS[i]]) {
            button.selected=YES;
            button.layer.borderColor=[UIColor colorWithHexString:@"#FF0000"].CGColor;
            [button setBackgroundColor:[[UIColor colorWithHexString:@"#FF0000"]colorWithAlphaComponent:0.1]];
        }
    }
}

- (void)confirmSelected
{
    NSString *str = [self.selectArray componentsJoinedByString:@"、"];
    self.typeSelectAction(str);
    [self hide];
}

-(void)clickType:(UIButton*)sender
{
    if (self.type==0||self.type==2) {
        
        for (int i=0; i<self.dataS.count; i++) {
            UIButton *btn = (UIButton*)[self viewWithTag:100+i];
            if (i==sender.tag-100) {
                btn.layer.borderColor=[UIColor colorWithHexString:@"#FF0000"].CGColor;
                [btn setBackgroundColor:[[UIColor colorWithHexString:@"#FF0000"]colorWithAlphaComponent:0.1]];
                btn.selected=YES;
            }
            else
            {
                btn.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
                [btn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
                btn.selected=NO;
            }
        }
        
        [self.selectArray removeAllObjects];
        [self.selectArray addObject:self.dataS[sender.tag-100]];
    }
    
    else
    {
        
        sender.selected=!sender.selected;
        if (sender.selected==YES) {
            sender.layer.borderColor=[UIColor colorWithHexString:@"#FF0000"].CGColor;
            [sender setBackgroundColor:[[UIColor colorWithHexString:@"#FF0000"]colorWithAlphaComponent:0.1]];
            [self.selectArray addObject:self.dataS[sender.tag-100]];
        }
        else
        {
            sender.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
            [sender setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            
            if ([self.selectArray containsObject:self.dataS[sender.tag-100]]) {
                [self.selectArray removeObject:self.dataS[sender.tag-100]];
            }
        }
    }
}


@end
