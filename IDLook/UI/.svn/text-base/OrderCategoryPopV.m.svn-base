//
//  OrderCategoryPopV.m
//  IDLook
//
//  Created by HYH on 2018/6/22.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderCategoryPopV.h"

#define SelectV_Height 255.0

@interface OrderCategoryPopV()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)NSArray *dataS;
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)NSMutableArray *selectArray;
@property(nonatomic,assign)OrderCheckType type;
@property(nonatomic,assign)BOOL isMuilSelect;  //是否多选

@property(nonatomic,assign)NSInteger advType;  //广告类型
@property(nonatomic,assign)NSInteger advSubType; //广告类型子类型

@property(nonatomic,strong)NSArray *enableArray; //不可选的类别


@end

@implementation OrderCategoryPopV

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
        Vheight=250;
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}

- (void)showWithType:(OrderCheckType)type withSelect:(NSArray *)selectArray withMultiSel:(BOOL)isMuilSel withEnableArray:(NSArray *)enableArray
{
    self.type=type;
    self.dataS=[PublicManager getOrderCellType:type];
    self.isMuilSelect=isMuilSel;
    self.enableArray=[NSArray arrayWithArray:enableArray];
    
    for (int i=0; i<selectArray.count; i++) {
        self.advSubType =[[selectArray firstObject]integerValue];
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
    
    [self initUI];
    
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


- (void)initUI
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
    if (self.isMuilSelect) {
        titleLab.text=@"广告类别（可多选）";
    }
    else
    {
        titleLab.text=@"广告类别";
    }
    
    CGFloat width = (UI_SCREEN_WIDTH-30-12*2)/3;
    CGFloat Vheight = 0;
    
    if (self.dataS.count<3) {
        return;
    }
    
    for (int i =0; i<self.dataS.count-1; i++) {
        NSArray *array = self.dataS[i][@"data"];
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor=[UIColor redColor];
        [self addSubview:view];
        CGFloat height = ((array.count-1)/3+1)*44 + 40;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(Vheight+60);
            make.height.mas_equalTo(height);
        }];
        
        Vheight = Vheight + height;
        
        UILabel *title=[[UILabel alloc]init];
        [view addSubview:title];
        title.font=[UIFont systemFontOfSize:13.0];
        title.textColor=Public_Text_Color;
        title.text=self.dataS[i][@"title"];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(view).offset(10);
        }];
        
        for (int j =0; j<array.count; j++) {
            NSDictionary *dic  = array[j];
            UIButton *button=[[UIButton alloc]init];
            [self addSubview:button];
            button.layer.cornerRadius=3.0;
            button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
            button.layer.borderWidth=0.5;
            button.tag=1000+[dic[@"attrid"] integerValue];
            button.titleLabel.font=[UIFont systemFontOfSize:13.0];
            [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
            [button setTitleColor:[[UIColor colorWithHexString:@"#999999"]colorWithAlphaComponent:0.3] forState:UIControlStateDisabled];

            [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            [button setTitle:dic[@"attrname"] forState:UIControlStateNormal];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(15+(width+10)*(j%3));
                make.top.mas_equalTo(title.mas_bottom).offset(12+(j/3)*44);
                make.size.mas_equalTo(CGSizeMake(width, 32));
            }];
            [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
            
            if (self.advSubType==[dic[@"attrid"] integerValue])  //选中的type
            {
                self.advType = i+1;
                [self.selectArray addObject:dic[@"attrname"]];
                
                button.selected=YES;
                button.layer.borderColor=[UIColor colorWithHexString:@"#FF0000"].CGColor;
                [button setBackgroundColor:[[UIColor colorWithHexString:@"#FF0000"]colorWithAlphaComponent:0.1]];
            }
            
            if ([self.enableArray containsObject:@([dic[@"attrid"] integerValue])]) {  //不可点击的
                button.enabled=NO;
            }
        }
    }
}

- (void)confirmSelected
{
    NSString *str = [self.selectArray componentsJoinedByString:@"、"];
    self.typeSelectAction(str,self.advType,self.advSubType);
    [self hide];
}

-(void)clickType:(UIButton*)sender
{
    if (self.isMuilSelect)   //多选
    {
        sender.selected=!sender.selected;
        if (sender.selected==YES) {
            sender.layer.borderColor=[UIColor colorWithHexString:@"#FF0000"].CGColor;
            [sender setBackgroundColor:[[UIColor colorWithHexString:@"#FF0000"]colorWithAlphaComponent:0.1]];
            [self.selectArray addObject:sender.titleLabel.text];
        }
        else
        {
            sender.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
            [sender setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            
            if ([self.selectArray containsObject:sender.titleLabel.text]) {
                [self.selectArray removeObject:sender.titleLabel.text];
            }
        }
    }
    else  //单选
    {
        for (int i=0; i<self.dataS.count; i++)
        {
            NSArray *array = self.dataS[i][@"data"];
            for (int j =0; j<array.count; j++) {
                NSDictionary *dic = array[j];
                UIButton *btn = (UIButton*)[self viewWithTag:1000+ [dic[@"attrid"]integerValue]];
                if (sender.tag==1000+ [dic[@"attrid"]integerValue]) {
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
        }
        [self.selectArray removeAllObjects];
        [self.selectArray addObject:sender.titleLabel.text];
        
        self.advType = (sender.tag -1010)/10+1;
        self.advSubType = sender.tag-1000;
        
    }
}


@end
