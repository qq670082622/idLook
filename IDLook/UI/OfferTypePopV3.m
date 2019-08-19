//
//  OfferTypePopV3.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/7.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "OfferTypePopV3.h"
#import "PriceModel.h"
static NSString  *const dayAddEnable = @"dayAddEnable";
static NSString  *const dayAddUnable = @"dayAddUnable";
static NSString  *const dayMinusAnable = @"dayMinusAnable";
static NSString  *const dayMinusUnable = @"dayMinusUnable";
#define red_back_color [UIColor colorWithHexString:@"#fbedee"]
#define gray_back_color  [UIColor colorWithHexString:@"#f2f2f2"]
@interface OfferTypePopV3()
{
    CGFloat Vheight;   //视图高度
    NSInteger kViewType;//1视频 2平面 3组合
    NSInteger videoPrice;
    NSInteger printPrice;
    NSInteger groupPrice;
}
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
//***************视频******************
@property (weak, nonatomic) IBOutlet UIView *videoSubView;
@property (weak, nonatomic) IBOutlet UILabel *videoPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoDay;
@property (weak, nonatomic) IBOutlet UIButton *videoDayMinusBtn;
- (IBAction)videoDayMinusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *videoDayPlusBtn;
- (IBAction)videoDayPlusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *videoVipView;
@property (weak, nonatomic) IBOutlet UILabel *videoPrice_vip;
@property (weak, nonatomic) IBOutlet UIView *videoLine_vip;
@property (weak, nonatomic) IBOutlet UILabel *videoNormalPrice_vip;

@property (weak, nonatomic) IBOutlet UIView *line1;
//*****************平面****************
@property (weak, nonatomic) IBOutlet UIView *printSubview;
@property (weak, nonatomic) IBOutlet UILabel *printPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *printDay;
@property (weak, nonatomic) IBOutlet UIButton *printDayMinusBtn;
- (IBAction)printDayMinusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *printDayPlusBtn;
- (IBAction)printDayPlusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *printVipView;
@property (weak, nonatomic) IBOutlet UILabel *printPrice_vip;
@property (weak, nonatomic) IBOutlet UIView *printLine_vip;
@property (weak, nonatomic) IBOutlet UILabel *printNormalPrice_vip;
@property (weak, nonatomic) IBOutlet UIView *line2;
//************套拍********************
@property (weak, nonatomic) IBOutlet UIView *groupSubView;
@property (weak, nonatomic) IBOutlet UILabel *groupPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *groupDay;
@property (weak, nonatomic) IBOutlet UIButton *groupDayMinusBtn;
- (IBAction)groupDayMinusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *groupDayPlusBtn;
- (IBAction)groupDayPlusAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *groupVipView;
@property (weak, nonatomic) IBOutlet UILabel *groupPrice_vip;
@property (weak, nonatomic) IBOutlet UIView *groupLine_vip;
@property (weak, nonatomic) IBOutlet UILabel *groupNormalPrice_vip;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
- (IBAction)ensureAction:(id)sender;
@property (nonatomic,strong)UIView *maskV;
// model 传进来再传出去
@property(nonatomic,strong) NSArray *videoPrices;
@property(nonatomic,strong) NSArray *printPrices;
@property(nonatomic,strong) NSArray *groupPrices;
@end
@implementation OfferTypePopV3

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"OfferTypePopV3" owner:nil options:nil] lastObject];
        //self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}

- (void)showOfferTypeWithPriceList:(NSArray *)list withSelectArray:(NSArray *)array withUserModel:(UserInfoM*)userModel//一共有哪些 选择哪些
{

    BOOL isVideo = false;
    BOOL isPhoto = false;
    BOOL isgroup = false;
    NSInteger status = [UserInfoManager getUserStatus];
    if (status<201) {
        self.videoVipView.hidden = YES;
        self.printVipView.hidden = YES;
        self.groupVipView.hidden = YES;
    }
    for (int i=0; i<list.count; i++) {//装载模型数组，判断弹窗选中服务，梳理没有的服务类型
      //  PriceModel *model = [[PriceModel alloc]initWithDic:list[i]];
        NSDictionary *priceDic = list[i];
        NSInteger type = [priceDic[@"advertType"] integerValue];
        if (type==1) {
              isVideo = YES;
            self.videoPrices = priceDic[@"priceList"];
            if (status>200) {
                NSInteger singlePrice_vip = [[_videoPrices objectAtIndex:0][@"salePriceVip"] integerValue];
                 NSInteger singlePrice = [[_videoPrices objectAtIndex:0][@"salePrice"] integerValue];
                NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%ld元/天",singlePrice_vip]];
                [aAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#464646"],NSFontAttributeName:[UIFont systemFontOfSize:14.0]} range:NSMakeRange(aAttributedString.length-2,2)];
                [_videoPrice_vip setAttributedText:aAttributedString];
                _videoPriceLabel.text = [NSString stringWithFormat:@"￥%d",singlePrice];
                _videoNormalPrice_vip.text = [NSString stringWithFormat:@"￥%d",singlePrice];
            }else{
            NSInteger singlePrice = [[_videoPrices objectAtIndex:0][@"salePrice"] integerValue];
            NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥ %ld元/天",singlePrice]];
     [aAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#464646"],NSFontAttributeName:[UIFont systemFontOfSize:14.0]} range:NSMakeRange(aAttributedString.length-2,2)];
          
            [_videoPriceLabel setAttributedText:aAttributedString];
            }
        }else if (type==2){
            isPhoto = YES;
            self.printPrices = priceDic[@"priceList"];
            if (status>200) {
                NSInteger singlePrice_vip = [[_printPrices objectAtIndex:0][@"salePriceVip"] integerValue];
                NSInteger singlePrice = [[_printPrices objectAtIndex:0][@"salePrice"] integerValue];
                NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%ld元/天",singlePrice_vip]];
                [aAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#464646"],NSFontAttributeName:[UIFont systemFontOfSize:14.0]} range:NSMakeRange(aAttributedString.length-2,2)];
                [_printPrice_vip setAttributedText:aAttributedString];
                _printPriceLabel.text = [NSString stringWithFormat:@"￥%d",singlePrice];
                 _printNormalPrice_vip.text = [NSString stringWithFormat:@"￥%d",singlePrice];
            }else{
            NSInteger singlePrice = [[_printPrices objectAtIndex:0][@"salePrice"] integerValue];
            NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥ %ld元/天",singlePrice]];
            [aAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#464646"],NSFontAttributeName:[UIFont systemFontOfSize:14.0]} range:NSMakeRange(aAttributedString.length-2,2)];
          [_printPriceLabel setAttributedText:aAttributedString];
            }
        }else if (type==4){
            isgroup = YES;
            self.groupPrices = priceDic[@"priceList"];
            if (status>200) {
                NSInteger singlePrice_vip = [[_groupPrices objectAtIndex:0][@"salePriceVip"] integerValue];
                NSInteger singlePrice = [[_groupPrices objectAtIndex:0][@"salePrice"] integerValue];
                NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%ld元/天",singlePrice_vip]];
                [aAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#464646"],NSFontAttributeName:[UIFont systemFontOfSize:14.0]} range:NSMakeRange(aAttributedString.length-2,2)];
                [_groupPrice_vip setAttributedText:aAttributedString];
                _groupPriceLabel.text = [NSString stringWithFormat:@"￥%d",singlePrice];
                 _groupNormalPrice_vip.text = [NSString stringWithFormat:@"￥%d",singlePrice];
            }else{
            NSInteger singlePrice = [[_groupPrices objectAtIndex:0][@"salePrice"] integerValue];
            NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥ %ld元/天",singlePrice]];
            [aAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#464646"],NSFontAttributeName:[UIFont systemFontOfSize:14.0]} range:NSMakeRange(aAttributedString.length-2,2)];
            [_groupPriceLabel setAttributedText:aAttributedString];
            }
        }
    }
            [self.videoPrice_vip sizeToFit];
            [self.videoNormalPrice_vip sizeToFit];
            self.videoPrice_vip.frame = CGRectMake(40, 0,_videoPrice_vip.width, 52);
            self.videoNormalPrice_vip.frame =  CGRectMake(_videoPrice_vip.right+6,0,_videoNormalPrice_vip.width,52);
            self.videoLine_vip.x = _videoNormalPrice_vip.x-3;
            self.videoLine_vip.width = _videoNormalPrice_vip.width+6;
    
    [self.printPrice_vip sizeToFit];
    [self.printNormalPrice_vip sizeToFit];
    self.printPrice_vip.frame = CGRectMake(40, 0,_printPrice_vip.width, 52);
    self.printNormalPrice_vip.frame =  CGRectMake(_printPrice_vip.right+6,0,_printNormalPrice_vip.width,52);
    self.printLine_vip.x = _printNormalPrice_vip.x-3;
    self.printLine_vip.width = _printNormalPrice_vip.width+6;
    
    [self.groupPrice_vip sizeToFit];
    [self.groupNormalPrice_vip sizeToFit];
    self.groupPrice_vip.frame = CGRectMake(40, 0,_groupPrice_vip.width, 52);
    self.groupNormalPrice_vip.frame =  CGRectMake(_groupPrice_vip.right+6,0,_groupNormalPrice_vip.width,52);
    self.groupLine_vip.x = _groupNormalPrice_vip.x-3;
    self.groupLine_vip.width = _groupNormalPrice_vip.width+6;
    
    if (!isVideo) {//没有视频
        //平面前移 取消套拍摄
        self.videoSubView.hidden = YES;
        self.printSubview.y = self.videoSubView.y;
        self.groupSubView.hidden = YES;
         Vheight = 257;
        self.line1.hidden = YES;
        self.line2.hidden = YES;
    }else if (!isPhoto){
        //取消平面+套牌
        self.printSubview.hidden = YES;
        self.groupSubView.hidden = YES;
        Vheight = 257;
         self.line1.hidden = YES;
        self.line2.hidden = YES;
    }else{
        Vheight = 391;
    }
    //装载选中的拍摄类型
    for(int i=0;i<array.count;i++){
         PriceModel_java *model = array[i];
        if (model.advertType==1) {
            self.videoDay.text = [NSString stringWithFormat:@"%ld天",model.days];
        }else if (model.advertType==2){
             self.printDay.text = [NSString stringWithFormat:@"%ld天",model.days];
        }else if (model.advertType==4){
             self.groupDay.text = [NSString stringWithFormat:@"%ld天",model.days];
        }
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


- (IBAction)closeAction:(id)sender {
    [self hide];
}
- (IBAction)videoPriceAction:(id)sender {
   
}
- (IBAction)videoDayMinusAction:(id)sender {
   
        NSInteger videoDay = [[_videoDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""]integerValue];
    videoDay--;
        self.videoDay.text = [NSString stringWithFormat:@"%ld天",videoDay];
    [self checkBtnsAndTotalPrice];
}
- (IBAction)videoDayPlusAction:(id)sender {
    NSInteger videoDay = [[_videoDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""] integerValue];
    videoDay++;
    self.videoDay.text = [NSString stringWithFormat:@"%ld天",videoDay];
     [self checkBtnsAndTotalPrice];
}
- (IBAction)printPriceAction:(id)sender {
   
}
- (IBAction)printDayMinusAction:(id)sender {
    NSInteger printDay = [[_printDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""] integerValue];
    printDay--;
    self.printDay.text = [NSString stringWithFormat:@"%ld天",printDay];
     [self checkBtnsAndTotalPrice];
}
- (IBAction)printDayPlusAction:(id)sender {
    NSInteger printDay = [[_printDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""]integerValue];
    printDay++;
    self.printDay.text = [NSString stringWithFormat:@"%ld天",printDay];
     [self checkBtnsAndTotalPrice];
}
- (IBAction)groupPriceAction:(id)sender {
    
}
- (IBAction)groupDayMinusAction:(id)sender {
    NSInteger groupDay = [[_groupDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""]integerValue];
    groupDay--;
    self.groupDay.text = [NSString stringWithFormat:@"%ld天",groupDay];
     [self checkBtnsAndTotalPrice];
}
- (IBAction)groupDayPlusAction:(id)sender {
    NSInteger groupDay = [[_groupDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""]integerValue];
    groupDay++;
    self.groupDay.text = [NSString stringWithFormat:@"%ld天",groupDay];
     [self checkBtnsAndTotalPrice];
}
- (IBAction)ensureAction:(id)sender {
    PriceModel_java *videoModel = [PriceModel_java new];
    PriceModel_java *printModel = [PriceModel_java new];
    PriceModel_java *groupModel = [PriceModel_java new];
 
    //取出视频服务天数
    NSInteger videoDayCount = [[self.videoDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""]integerValue];
    //取出平面服务天数
    NSInteger photoDayCount = [[self.printDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""]integerValue];
    //取出套拍服务天数
    NSInteger groupDayCount = [[self.groupDay.text stringByReplacingOccurrencesOfString:@"天" withString:@""]integerValue];
    NSMutableArray *array = [NSMutableArray new];
    if (videoDayCount>0) {//初始值默认是0,不是0说明视频服务被选择
        videoModel.days=videoDayCount;
        NSDictionary *priceDic = _videoPrices[videoDayCount-1];
        videoModel.salePrice = [priceDic[@"salePrice"] integerValue];
        videoModel.salePrice_vip = [priceDic[@"salePriceVip"] integerValue];
         NSDictionary *priceDic_single = _videoPrices[0];
        videoModel.singlePrice = [priceDic_single[@"salePrice"] integerValue];
         videoModel.singlePrice_vip = [priceDic_single[@"salePriceVip"] integerValue];
        videoModel.advertType = 1;
        [array addObject:videoModel];
    }
    if (photoDayCount>0) {
        printModel.days = photoDayCount;
        NSDictionary *priceDic = _printPrices[photoDayCount-1];
        printModel.salePrice = [priceDic[@"salePrice"] integerValue];
        printModel.salePrice_vip = [priceDic[@"salePriceVip"] integerValue];
        NSDictionary *priceDic_single = _printPrices[0];
        printModel.singlePrice = [priceDic_single[@"salePrice"] integerValue];
        printModel.singlePrice_vip = [priceDic_single[@"salePriceVip"] integerValue];
        printModel.advertType = 2;
        [array addObject:printModel];
    }
    if (groupDayCount>0) {
        groupModel.days = groupDayCount;
        NSDictionary *priceDic = _groupPrices[groupDayCount-1];
        groupModel.salePrice = [priceDic[@"salePrice"] integerValue];
        groupModel.salePrice_vip = [priceDic[@"salePriceVip"] integerValue];
        NSDictionary *priceDic_single = _printPrices[0];
        groupModel.singlePrice = [priceDic_single[@"salePrice"] integerValue];
        groupModel.singlePrice_vip = [priceDic_single[@"salePriceVip"] integerValue];
        groupModel.advertType = 4;
        [array addObject:groupModel];
    }
    if (array.count==0) {//两个都没选 提示选择天数不予退出弹窗
        [SVProgressHUD showImage:nil status:@"请选择天数。"];
        return;
    }
    //传每个的单价 /天数 普通总价 和 vip总价
    self.typeSelectAction(array);
    [self hide];
}
-(void)checkBtnsAndTotalPrice
{
    NSInteger videoDay = [self.videoDay.text integerValue];
    NSInteger printDay = [self.printDay.text integerValue];
    NSInteger groupDay = [self.groupDay.text integerValue];
    if (videoDay==0) {
        self.videoDayMinusBtn.userInteractionEnabled = NO;
        [self.videoDayMinusBtn setImage:[UIImage imageNamed:dayMinusUnable] forState:0];
       // [self setPriceBtnState:self.videoPriceBtn WithSelect:NO];
    }else if (videoDay>0 && videoDay<5){
        self.videoDayMinusBtn.userInteractionEnabled = YES;
        [self.videoDayMinusBtn setImage:[UIImage imageNamed:dayMinusAnable] forState:0];
        self.videoDayPlusBtn.userInteractionEnabled = YES;
        [self.videoDayPlusBtn setImage:[UIImage imageNamed:dayAddEnable] forState:0];
       //   [self setPriceBtnState:self.videoPriceBtn WithSelect:YES];
    }else if (videoDay==5){
        self.videoDayPlusBtn.userInteractionEnabled = NO;
        [self.videoDayPlusBtn setImage:[UIImage imageNamed:dayAddUnable] forState:0];
        }
    
    if (printDay==0) {
        self.printDayMinusBtn.userInteractionEnabled = NO;
        [self.printDayMinusBtn setImage:[UIImage imageNamed:dayMinusUnable] forState:0];
      //    [self setPriceBtnState:self.printPriceBtn WithSelect:NO];
    }else if (printDay>0 && printDay<5){
        self.printDayMinusBtn.userInteractionEnabled = YES;
        [self.printDayMinusBtn setImage:[UIImage imageNamed:dayMinusAnable] forState:0];
        self.printDayPlusBtn.userInteractionEnabled = YES;
        [self.printDayPlusBtn setImage:[UIImage imageNamed:dayAddEnable] forState:0];
         // [self setPriceBtnState:self.printPriceBtn WithSelect:YES];
    }else if (printDay==5){
        self.printDayPlusBtn.userInteractionEnabled = NO;
        [self.printDayPlusBtn setImage:[UIImage imageNamed:dayAddUnable] forState:0];
    }
    
    if (groupDay==0) {
        self.groupDayMinusBtn.userInteractionEnabled = NO;
        [self.groupDayMinusBtn setImage:[UIImage imageNamed:dayMinusUnable] forState:0];
        //  [self setPriceBtnState:self.groupPriceBtn WithSelect:NO];
    }else if (groupDay>0 && groupDay<5){
        self.groupDayMinusBtn.userInteractionEnabled = YES;
        [self.groupDayMinusBtn setImage:[UIImage imageNamed:dayMinusAnable] forState:0];
        self.groupDayPlusBtn.userInteractionEnabled = YES;
        [self.groupDayPlusBtn setImage:[UIImage imageNamed:dayAddEnable] forState:0];
         // [self setPriceBtnState:self.groupPriceBtn WithSelect:YES];
    }else if (groupDay==5){
        self.groupDayPlusBtn.userInteractionEnabled = NO;
        [self.groupDayPlusBtn setImage:[UIImage imageNamed:dayAddUnable] forState:0];
    }
    
    //更新价格
    NSInteger videoPrice = 0;
    if (videoDay>0) {
       NSDictionary *priceDic = [_videoPrices objectAtIndex:videoDay-1];
        videoPrice = [priceDic[@"salePrice"] integerValue];
    }
    NSInteger printPrice = 0;
    if (printDay>0) {
        NSDictionary *priceDic = [_printPrices objectAtIndex:printDay-1];
        printPrice = [priceDic[@"salePrice"] integerValue];
    }
    NSInteger groupPrice = 0;
    if (groupDay>0) {
        NSDictionary *priceDic = [_printPrices objectAtIndex:groupDay-1];
        groupPrice = [priceDic[@"salePrice"] integerValue];
    }
    NSInteger totalPrice = videoPrice+printPrice+groupPrice;
    self.totalPrice.text = [NSString stringWithFormat:@"¥ %ld",totalPrice];
}
-(void)setPriceBtnState:(UIButton *)btn WithSelect:(BOOL)isSelect
{
    if (isSelect) {
        [btn setSelected:YES];
       // [btn setBackgroundColor:red_back_color];
    }else{
        [btn setSelected:NO];
      //  [btn setBackgroundColor:gray_back_color];
    }
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
