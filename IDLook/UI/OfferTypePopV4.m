//
//  OfferTypePopV4.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/25.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "OfferTypePopV4.h"
#import "PriceModel.h"
static NSString  *const dayAddEnable = @"dayAddEnable";
static NSString  *const dayAddUnable = @"dayAddUnable";
static NSString  *const dayMinusAnable = @"dayMinusAnable";
static NSString  *const dayMinusUnable = @"dayMinusUnable";
#define red_back_color [UIColor colorWithHexString:@"#fbedee"]
#define gray_back_color  [UIColor colorWithHexString:@"#f2f2f2"]
#define text_color  [UIColor colorWithHexString:@"#464646"]
@interface OfferTypePopV4()
{
    CGFloat Vheight;   //视图高度
    NSInteger kViewType;//1视频 2平面 3组合
    NSInteger videoPrice;
    NSInteger printPrice;
    NSInteger groupPrice;
    BOOL isVideo;
    BOOL isPhoto;
    BOOL isgroup;
}
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *videoPrice;
- (IBAction)videoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *printPrice;
- (IBAction)printAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *groupPrice;
- (IBAction)groupAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
- (IBAction)plusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
- (IBAction)minusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextAction;

@property (nonatomic,strong)UIView *maskV;
@property (weak, nonatomic) IBOutlet UILabel *dayHoursTips;

// model 传进来再传出去
@property(nonatomic,strong) NSArray *videoPrices;
@property(nonatomic,strong) NSArray *printPrices;
@property(nonatomic,strong) NSArray *groupPrices;
@property(nonatomic,assign)NSInteger selectType;//1,2,4
@end
@implementation OfferTypePopV4
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"OfferTypePopV4" owner:nil options:nil] lastObject];
        //self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}
-(void)showOfferTypeWithPriceList:(NSArray *)list withSelectModel:(PriceModel_java *)model
{
      NSMutableAttributedString * nextstr = [[NSMutableAttributedString alloc] initWithString:@"下一步，拍摄下单"];
    [nextstr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]} range:NSMakeRange(0,4)];
    [self.nextLabel setAttributedText:nextstr];
     isVideo = false;
     isPhoto = false;
     isgroup = false;
    for (int i=0; i<list.count; i++) {//装载模型数组，判断弹窗选中服务，梳理没有的服务类型
        //  PriceModel *model = [[PriceModel alloc]initWithDic:list[i]];
        NSDictionary *priceDic = list[i];
        NSInteger type = [priceDic[@"advertType"] integerValue];
        NSInteger dayHours = [priceDic[@"dayHours"] integerValue];
        dayHours = dayHours!=0?dayHours:8;
        self.dayHoursTips.text = [NSString stringWithFormat:@"该演员1天工作时间为8小时，超过%ld小时需加收超时费，下单 后会有客户专员电话通知超时费收费标准。",dayHours];
        if (type==1) {
            isVideo = YES;
            self.videoPrices = priceDic[@"priceList"];
            NSInteger singlePrice = [[_videoPrices objectAtIndex:0][@"salePrice"] integerValue];
            NSString *boldStr = [NSString stringWithFormat:@"￥%ld",singlePrice];
            NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"视频%@/天",boldStr]];
//            [aAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#464646"],NSFontAttributeName:[UIFont systemFontOfSize:14.0]} range:NSMakeRange(aAttributedString.length-2,2)];
             [aAttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0]} range:NSMakeRange(2,boldStr.length)];
            [_videoPrice setAttributedText:aAttributedString];
            _videoPrice.layer.cornerRadius = 8;
            _videoPrice.layer.borderWidth = 1;
            _videoPrice.layer.masksToBounds = YES;
            _videoPrice.layer.borderColor = gray_back_color.CGColor;
        }else if (type==2){
            isPhoto = YES;
            self.printPrices = priceDic[@"priceList"];
            NSInteger singlePrice = [[_printPrices objectAtIndex:0][@"salePrice"] integerValue];
             NSString *boldStr = [NSString stringWithFormat:@"￥%ld",singlePrice];
            NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"平面%@/天",boldStr]];
            [aAttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0]} range:NSMakeRange(2,boldStr.length)];
            [_printPrice setAttributedText:aAttributedString];
            _printPrice.layer.cornerRadius = 8;
            _printPrice.layer.borderWidth = 1;
            _printPrice.layer.masksToBounds = YES;
             _printPrice.layer.borderColor = gray_back_color.CGColor;
        }else if (type==4){
            isgroup = YES;
            self.groupPrices = priceDic[@"priceList"];
            NSInteger singlePrice = [[_groupPrices objectAtIndex:0][@"salePrice"] integerValue];
             NSString *boldStr = [NSString stringWithFormat:@"￥%ld",singlePrice];
            NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"套拍%@/天",boldStr]];
            [aAttributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} range:NSMakeRange(2,boldStr.length)];
            [_groupPrice setAttributedText:aAttributedString];
            _groupPrice.layer.cornerRadius = 8;
            _groupPrice.layer.borderWidth = 1;
            _groupPrice.layer.masksToBounds = YES;
               _groupPrice.layer.borderColor = gray_back_color.CGColor;
        }
    }
      Vheight = 329;
    if (!isVideo) {//没有视频
        //平面前移 取消套拍摄
        self.videoPrice.hidden = YES;
        self.printPrice.x =_videoPrice.x;
        self.groupPrice.hidden = YES;
      
    }else if (!isPhoto){
        //取消平面+套牌
        self.printPrice.hidden = YES;
        self.groupPrice.hidden = YES;
    }else if (!isgroup){
        self.groupPrice.hidden = YES;
    }
    //装载选中的拍摄类型
   
            self.dayLabel.text = [NSString stringWithFormat:@"%ld",model.days];
    if (model.advertType == 1) {
        [self selectWithLabel:_videoPrice];
    }else if (model.advertType == 2){
        [self selectWithLabel:_printPrice];
    }else if (model.advertType == 4){
        [self selectWithLabel:_groupPrice];
    }
   
    //更新子UI
    [self checkBtnsAndTotalPrice];
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
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
    
    [UIView commitAnimations];
}


- (IBAction)videoAction:(id)sender {
    if (!isVideo) {
        return;
    }
    [self deSelectBtns];
    [self selectWithLabel:_videoPrice];
     self.selectType = 1;
    self.dayLabel.text = @"1";
    [self checkBtnsAndTotalPrice];
}
- (IBAction)printAction:(id)sender {
    if (!isPhoto) {
        return;
    }
    [self deSelectBtns];
    [self selectWithLabel:_printPrice];
     self.selectType = 2;
    self.dayLabel.text = @"1";
    [self checkBtnsAndTotalPrice];
}
- (IBAction)groupAction:(id)sender {
    if (!isgroup) {
        return;
    }
    [self deSelectBtns];
    [self selectWithLabel:_groupPrice];
    self.selectType = 4;
    self.dayLabel.text = @"1";
    [self checkBtnsAndTotalPrice];
}
- (IBAction)plusAction:(id)sender {
    NSInteger day = [_dayLabel.text integerValue];
    day++;
    self.dayLabel.text = [NSString stringWithFormat:@"%ld",day];
    [self checkBtnsAndTotalPrice];
}
- (IBAction)minusAction:(id)sender {
    NSInteger day = [_dayLabel.text integerValue];
  
    day--;
    self.dayLabel.text = [NSString stringWithFormat:@"%ld",day];
    [self checkBtnsAndTotalPrice];
}
-(void)checkBtnsAndTotalPrice
{
    NSInteger day = [self.dayLabel.text integerValue];
   
    if (day==0) {
        self.minusBtn.userInteractionEnabled = NO;
        [self.minusBtn setImage:[UIImage imageNamed:dayMinusUnable] forState:0];
        // [self setPriceBtnState:self.videoPriceBtn WithSelect:NO];
    }else if (day>0 && day<5){
        self.minusBtn.userInteractionEnabled = YES;
        [self.minusBtn setImage:[UIImage imageNamed:dayMinusAnable] forState:0];
        self.plusBtn.userInteractionEnabled = YES;
        [self.plusBtn setImage:[UIImage imageNamed:dayAddEnable] forState:0];
        //   [self setPriceBtnState:self.videoPriceBtn WithSelect:YES];
    }else if (day==5){
        self.plusBtn.userInteractionEnabled = NO;
        [self.plusBtn setImage:[UIImage imageNamed:dayAddUnable] forState:0];
    }
    
    if (_selectType == 0) {
        self.plusBtn.userInteractionEnabled = NO;
        [self.plusBtn setImage:[UIImage imageNamed:dayAddUnable] forState:0];
    }
    
    //更新价格
    if (day==0) {
        self.totalPrice.text = @"¥0";
        return;
    }
    if (_selectType==1) {
        NSDictionary *priceDic = [_videoPrices objectAtIndex:day-1];
        videoPrice = [priceDic[@"salePrice"] integerValue];
         self.totalPrice.text = [NSString stringWithFormat:@"¥%ld",videoPrice];
    }
  
    if (_selectType==2) {
        NSDictionary *priceDic = [_printPrices objectAtIndex:day-1];
        printPrice = [priceDic[@"salePrice"] integerValue];
         self.totalPrice.text = [NSString stringWithFormat:@"¥%ld",printPrice];
    }
   
    if (_selectType==4) {
        NSDictionary *priceDic = [_printPrices objectAtIndex:day-1];
        groupPrice = [priceDic[@"salePrice"] integerValue];
         self.totalPrice.text = [NSString stringWithFormat:@"¥%ld",groupPrice];
    }
  
   
}
-(void)deSelectBtns
{
    self.videoPrice.backgroundColor = gray_back_color;
    self.videoPrice.textColor = text_color;
    self.videoPrice.layer.borderColor = gray_back_color.CGColor;
    self.printPrice.backgroundColor = gray_back_color;
    self.printPrice.textColor = text_color;
    self.printPrice.layer.borderColor = gray_back_color.CGColor;
    self.groupPrice.backgroundColor = gray_back_color;
    self.groupPrice.textColor = text_color;
    self.groupPrice.layer.borderColor = gray_back_color.CGColor;
}
-(void)selectWithLabel:(UILabel *)priceLabel
{
   priceLabel.backgroundColor = red_back_color;
    priceLabel.textColor = [UIColor colorWithHexString:@"#ff4a57"];
    priceLabel.layer.borderColor = [UIColor colorWithHexString:@"#ff4a57"].CGColor;
}
- (IBAction)closeAction:(id)sender {
    [self hide];
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
- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}
@end
