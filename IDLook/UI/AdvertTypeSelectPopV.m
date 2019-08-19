//
//  AdvertTypeSelectPopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/20.
//  Copyright © 2019年 HYH. All rights reserved.
//
#define SelectV_Height 262
#import "AdvertTypeSelectPopV.h"
@interface AdvertTypeSelectPopV()
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
@implementation AdvertTypeSelectPopV

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
        Vheight=262;
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}
- (void)showWithSelect:(NSInteger)selectType withMultiSel:(BOOL)isMuilSel withEnableArray:(NSArray *)enableArray
{
   
    self.isMuilSelect=isMuilSel;
    self.enableArray=[NSArray arrayWithArray:enableArray];
    
   
        self.advSubType = selectType;
    
    
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
    btn.frame = CGRectMake(UI_SCREEN_WIDTH-51, 0, 51, 48);
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    cancleBtn.frame = CGRectMake(0, 0, 51, 48);
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    lineV.frame = CGRectMake(0, 48, UI_SCREEN_WIDTH, 1);
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:16.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    titleLab.frame = CGRectMake(51, 0, UI_SCREEN_WIDTH-102, 48);
    titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text=@"广告类别";
    for(int i = 0;i<3;i++){
        UIButton *videoButton=[[UIButton alloc]init];
        [self addSubview:videoButton];
        videoButton.layer.cornerRadius=3.0;
        videoButton.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
        videoButton.layer.borderWidth=0.5;
        videoButton.tag=i+1;
        videoButton.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [videoButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [videoButton setTitleColor:[[UIColor colorWithHexString:@"#999999"]colorWithAlphaComponent:0.3] forState:UIControlStateDisabled];
        [videoButton setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        NSArray *titles = @[@"视频",@"平面",@"套拍"];
        [videoButton setTitle:titles[i] forState:UIControlStateNormal];
        [videoButton addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
        NSArray *ys =  [NSArray arrayWithObjects:@"69",@"131",@"195", nil];
        videoButton.frame = CGRectMake(15, [[ys objectAtIndex:i] integerValue], UI_SCREEN_WIDTH-30, 48);
        if (_advSubType == i+1) {//选中的
            videoButton.layer.borderColor=[UIColor colorWithHexString:@"#FF0000"].CGColor;
        [videoButton setBackgroundColor:[[UIColor colorWithHexString:@"#FF0000"]colorWithAlphaComponent:0.1]];
            [videoButton setTitleColor:Public_Red_Color forState:0];
        }
        NSInteger enableType = i+1;//enablearray:[@"1",@"2"] 不可以选择的
        if ([_enableArray containsObject:[NSString stringWithFormat:@"%d",enableType]]) {
            videoButton.userInteractionEnabled = NO;
            [videoButton setTitleColor:[UIColor colorWithHexString:@"#bcbcbc"] forState:0];
        }
    }
   
 
}
-(void)clickType:(UIButton*)sender
{
  
    [self setNormalState];
                UIButton *btn = (UIButton *)sender;
    btn.layer.borderColor=[UIColor colorWithHexString:@"#FF0000"].CGColor;
    [btn setBackgroundColor:[[UIColor colorWithHexString:@"#FF0000"]colorWithAlphaComponent:0.1]];
    [btn setTitleColor:Public_Red_Color forState:0];
    

        [self.selectArray removeAllObjects];
        [self.selectArray addObject:@(sender.tag-1)];
        
        self.advType = sender.tag -1;
        self.advSubType = sender.tag-1;
        
    
}
-(void)setNormalState
{
    for(int i = 0 ;i<3;i++){
        UIButton *btn = [self viewWithTag:i+1];
if(![_enableArray containsObject:[NSString stringWithFormat:@"%d",i+1]]){
            btn.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
            [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        }
        
        }

}
- (void)confirmSelected
{
   
    self.typeSelectAction(self.advSubType+1);
    [self hide];
}
@end
