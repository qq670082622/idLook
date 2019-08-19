//
//  LookAnnunciatePopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "LookAnnunciatePopV.h"

@interface LookAnnunciatePopV ()

@end

@implementation LookAnnunciatePopV

-(id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;

    }
    return self;
}


- (void)showPopVWithInfo:(ProjectOrderInfoM *)info
{
    
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    [self initUIWithInfo:info];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}


- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
}

-(void)initUIWithInfo:(ProjectOrderInfoM*)info
{
    NSMutableArray *array = [NSMutableArray new];
    NSString *title = @"";
    CGFloat totalHeight = 90;
    if (info.orderType==3) {  //试镜通告
        NSString *auditionDate = (NSString*)safeObjectForKey(info.tryVideoInfo, @"auditionDate");
        NSString *tryVideoAddress = (NSString*)safeObjectForKey(info.tryVideoInfo, @"tryVideoAddress");
        NSString *remark = (NSString*)safeObjectForKey(info.tryVideoInfo, @"remark");
        
        
        [array addObject:[NSString stringWithFormat:@"试镜时间：\n%@",auditionDate.length==0?@"无":auditionDate]];
        [array addObject:[NSString stringWithFormat:@"试镜地址：\n%@",tryVideoAddress.length==0?@"无":tryVideoAddress]];
        [array addObject:[NSString stringWithFormat:@"备注：\n%@",remark.length==0?@"无":remark]];

        totalHeight =totalHeight+[self heighOfString:auditionDate]+[self heighOfString:tryVideoAddress]+[self heighOfString:remark]+20*3+20;
        title=@"查看试镜通告";

    }
    else if (info.orderType==7) //（锁档）拍摄通告
    {
        
        NSString *shotDate = (NSString*)safeObjectForKey(info.shotInfo, @"shotDate");
        NSString *shotAddress = (NSString*)safeObjectForKey(info.shotInfo, @"shotAddress");
        NSString *remark = (NSString*)safeObjectForKey(info.shotInfo, @"remark");
        
        [array addObject:[NSString stringWithFormat:@"拍摄时间：\n%@",shotDate.length==0?@"无":shotDate]];
        [array addObject:[NSString stringWithFormat:@"拍摄地址：\n%@",shotAddress.length==0?@"无":shotAddress]];
        [array addObject:[NSString stringWithFormat:@"备注：\n%@",remark.length==0?@"无":remark]];
        
        totalHeight =totalHeight+[self heighOfString:shotDate]+[self heighOfString:shotAddress]+[self heighOfString:remark]+20*3+20;
        title=@"查看拍摄通告";

    }
    else if (info.orderType==5)  //定妆
    {

        NSString *makeupDate = (NSString*)safeObjectForKey(info.makeupInfo, @"makeupDate");
        NSString *makeupAddress = (NSString*)safeObjectForKey(info.makeupInfo, @"makeupAddress");
        
        [array addObject:[NSString stringWithFormat:@"定妆时间：\n%@",makeupDate.length==0?@"无":makeupDate]];
        [array addObject:[NSString stringWithFormat:@"定妆地址：\n%@",makeupAddress.length==0?@"无":makeupAddress]];
        
        totalHeight =totalHeight+[self heighOfString:makeupDate]+[self heighOfString:makeupAddress]+20*2+20;
        title=@"查看定妆通告";
    }
    
    
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(280,totalHeight));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.textColor = Public_Text_Color;
    [bg addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(15);
    }];
    titleLab.text=title;
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#E7E7E7"];
    [bg addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(45);
        make.height.mas_equalTo(0.5);
    }];

    CGFloat vHeight = 70;
    for (int i =0; i<array.count; i++) {
        MLLabel *descLab = [[MLLabel alloc] init];
        descLab.numberOfLines=0;
        descLab.lineSpacing=3.0;
        descLab.font=[UIFont systemFontOfSize:14.0];
        descLab.textColor=Public_Text_Color;
        [bg addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bg).offset(vHeight);
            make.right.mas_equalTo(bg).offset(-20);
            make.left.mas_equalTo(bg).offset(20);
        }];
        descLab.text=array[i];
        vHeight =vHeight+[self heighOfString:array[i]]+10;
    }
    

    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
}


//文字高度
-(CGFloat)heighOfString:(NSString *)string
{
    CGFloat width  = 240;
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = [UIFont systemFontOfSize:14];
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 3;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<20?20.0:ceilf(size.height);
}


@end
