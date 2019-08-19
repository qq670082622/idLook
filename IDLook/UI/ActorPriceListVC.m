//
//  ActorPriceListVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/5/29.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorPriceListVC.h"
#import "AskPriceListView.h"
#import "AskCalendarPriceModel.h"
#import "VIPViewController.h"
#import "AskCalendarVC.h"
#import "AskPriceView.h"
//#import "PriceModel_java.h"
@interface ActorPriceListVC ()<AskPriceListViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *vipView;
- (IBAction)vipAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/*******拍摄类型相关***********/
@property (weak, nonatomic) IBOutlet UIView *shotTypeView;
- (IBAction)big_phoneBtnAction:(id)sender;


/*******肖像年限相关***********/
@property (weak, nonatomic) IBOutlet UIView *portraitTimeView;

@property (weak, nonatomic) IBOutlet UIButton *year1Btn;
- (IBAction)year1Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *year1Price;

@property (weak, nonatomic) IBOutlet UIButton *year2Btn;
- (IBAction)year2Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *year2Price;

@property (weak, nonatomic) IBOutlet UIButton *year3Btn;
- (IBAction)year3Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *year3Price;

@property (weak, nonatomic) IBOutlet UIButton *foreverBtn;
- (IBAction)foreverAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *foreverPrice;
/*******肖像范围相关***********/
@property (weak, nonatomic) IBOutlet UIView *portraitRegionView;

@property (weak, nonatomic) IBOutlet UILabel *mainLandPrice;
@property (weak, nonatomic) IBOutlet UIButton *mainLandBtn;
- (IBAction)mainLandAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *GATPrice;
@property (weak, nonatomic) IBOutlet UIButton *GATBtn;
- (IBAction)GATAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *globalPrice;
@property (weak, nonatomic) IBOutlet UIButton *globalBtn;
- (IBAction)globalAction:(id)sender;
/*******异地拍摄相关***********/
@property (weak, nonatomic) IBOutlet UIView *yiDiView;
@property (weak, nonatomic) IBOutlet UILabel *bendiPrice;
- (IBAction)benDi:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bendiBtn;

@property (weak, nonatomic) IBOutlet UILabel *afterNoonPrice;
@property (weak, nonatomic) IBOutlet UIButton *afterNoonBtn;
- (IBAction)afterNoonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *beforeNoonPrice;
@property (weak, nonatomic) IBOutlet UIButton *beforeNoonBtn;
- (IBAction)beforeNoonAction:(id)sender;
/*******底部固定条***********/
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
- (IBAction)priceDetailAction:(id)sender;
- (IBAction)serviceAction:(id)sender;
- (IBAction)ensure:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ensure;
/*******税费提示***********/
@property (weak, nonatomic) IBOutlet UIView *tipView;
- (IBAction)colseTipvIEW:(id)sender;

/*******弹起价格明细***********/
@property (weak, nonatomic) IBOutlet UIView *priceDetailPopView;
- (IBAction)closeDetail:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *actorCost;
@property (weak, nonatomic) IBOutlet UILabel *portraitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *portraitTimeCost;
@property (weak, nonatomic) IBOutlet UILabel *portraitRegionLabel;
@property (weak, nonatomic) IBOutlet UILabel *portraitRegionCost;
@property (weak, nonatomic) IBOutlet UILabel *yidiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yidiCost;
@property (weak, nonatomic) IBOutlet UILabel *actorOff;
@property (weak, nonatomic) IBOutlet UILabel *vipOff;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;
@property(nonatomic,strong)UIView *maskV;
/*******最终参数***********/
@property(nonatomic,assign)NSInteger maxPrice;
@property(nonatomic,assign)NSInteger total_vip;
@property(nonatomic,assign)NSInteger total_normal;
@end

@implementation ActorPriceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectPrice = [NSMutableArray new];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选择拍摄类别"]];
   
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    if (_pushType == 2) {
//       NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:@"下一步，\n填写询问档期单"];
//
//        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(4,7)];
//        [self.ensure setAttributedTitle:attStr forState:0];//.titleLabel.attributedText=attStr;
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"下一步，\n"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        NSAttributedString *title2 = [[NSAttributedString alloc] initWithString:@"填写询问档期单" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [title appendAttributedString:title2];
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        [paraStyle setLineSpacing:5];
        paraStyle.alignment = NSTextAlignmentCenter;
        [title addAttributes:@{NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, title.length)];
        
       
        self.ensure.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.ensure setAttributedTitle:title forState:UIControlStateNormal];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.priceDetailPopView.y = self.view.height;
    
    NSInteger status = [UserInfoManager getUserStatus];
    if (status>200) {//vip
        self.vipView.hidden = YES;
        self.shotTypeView.y = 0;
    }
    NSDictionary *arg = @{
                          @"actorId":@(_actorId),
                          @"userId":@([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA getQuotaListWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            CGFloat shotViewHeight = 0;

            NSArray *quotationList = object[@"body"][@"quotationList"];
            for(int i = 0 ;i<quotationList.count;i++){
                NSDictionary *priceDic = quotationList[i];
                AskPriceListView *priceView = [[AskPriceListView alloc] initWithFrame:CGRectMake(0, 45+58*i, UI_SCREEN_WIDTH, 58)];
                priceView.topY = 45+58*i;
                [self.shotTypeView addSubview:priceView];
                priceView.priceList = priceDic[@"priceList"];
                NSDictionary *oneDayDic = priceView.priceList.firstObject;
                NSInteger status = [UserInfoManager getUserStatus];
                NSInteger startPrice = [oneDayDic[@"salePrice"] integerValue];
                if (status>200) {//vip
                    startPrice = [oneDayDic[@"salePriceVip"] integerValue];
                }
                priceView.startPrice = startPrice;
                priceView.type= [priceDic[@"singleType"] integerValue];
                [priceView setTag:priceView.type];
                priceView.delegate = self;
                shotViewHeight = 45+58*i +177;
                if (_selectArr.count>0) {//装载已经选择了的拍摄类型
                    for (AskCalendarPriceModel *akM in _selectArr) {
                        [self selectType:akM.type withDay:akM.day andSinglePrice:akM.price isDelete:NO];
                        if (priceView.type == akM.type) {
                            [priceView reloadWithDay:akM.day];
                        }
                    }
                    if (_year==1) {
                        [self year1Action:nil];
                    }else if (_year==2){
                         [self year2Action:nil];
                    }else if (_year==3){
                        [self year3Action:nil];
                    }else if (_year==4){
                        [self foreverAction:nil];
                    }
                    if (_region==1) {
                        [self mainLandAction:nil];
                    }else if (_region==2) {
                        [self GATAction:nil];
                    }else if (_region==3) {
                        [self globalAction:nil];
                    }
                    
                    if (_yidi==1) {
                        [self benDi:nil];
                    }else if (_yidi==2){
                        [self afterNoonAction:nil];
                    }else if (_yidi==3){
                        [self beforeNoonAction:nil];
                    }
                }
                
            }
        
            self.shotTypeView.height = shotViewHeight;
            self.portraitTimeView.y = self.shotTypeView.bottom;
            self.portraitRegionView.y = self.portraitTimeView.bottom;
            self.yiDiView.y = self.portraitRegionView.bottom;
            self.scrollView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, self.view.height-59);
            self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _yiDiView.bottom+54);
         
            [self.view reloadInputViews];
              [self setOtherPriceLabel];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
   
}
-(void)selectType:(NSInteger)type withDay:(NSInteger)day andSinglePrice:(NSInteger)price isDelete:(BOOL)del
{
    AskCalendarPriceModel *model = [AskCalendarPriceModel new];
    model.type = type;
    model.day = day;
    model.price = price;
    if (_selectPrice.count>0) {
        for (int i=0;i<_selectPrice.count;i++) {
            AskCalendarPriceModel *akModel = _selectPrice[i];
        if (del) {
            if (akModel.type == model.type) {
                [_selectPrice removeObject:akModel];
            }
        }else{
        if (akModel.type==model.type) {
            [_selectPrice removeObject:akModel];
            [_selectPrice addObject:model];
        }else{
            [_selectPrice addObject:model];
        }
       }
    }
    }else{
        [_selectPrice addObject:model];
      }
    
    _maxPrice = 0;
     for (AskCalendarPriceModel *akModel in _selectPrice) {
         if (akModel.price>_maxPrice) {
             _maxPrice = akModel.price;
         }
     }
    [self setOtherPriceLabel];
}
-(void)setOtherPriceLabel
{


    NSDictionary *config = [UserInfoManager getPublicConfig];
    NSArray *portraitYearRatio = config[@"shotCycle"];//肖像年限
    for(int i=0;i<portraitYearRatio.count;i++){
        NSDictionary *yearDic = portraitYearRatio[i];
        double ratio = [yearDic[@"ratio"] doubleValue];
        NSString *attrname = yearDic[@"attrname"];
        if ([attrname isEqualToString:@"2年"]) {
            NSString *priceText = [NSString stringWithFormat:@"+ ￥%ld(不含税)",(NSInteger)(_maxPrice*ratio)];
                   NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:priceText];
            
                    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} range:NSMakeRange(priceText.length-5,5)];
                  self.year2Price.attributedText = attStr;
//            self.year2Price.text = [NSString stringWithFormat:@"+ ￥%ld",(NSInteger)(_maxPrice*ratio)];
        }else if ([attrname isEqualToString:@"3年"]){
            NSString *priceText = [NSString stringWithFormat:@"+ ￥%ld(不含税)",(NSInteger)(_maxPrice*ratio)];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:priceText];
            
            [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} range:NSMakeRange(priceText.length-5,5)];
            self.year3Price.attributedText = attStr;
//            self.year3Price.text = [NSString stringWithFormat:@"+ ￥%ld",(NSInteger)(_maxPrice*ratio)];
        }
    }
    NSArray *shotRegion = config[@"shotRegion"];//肖像范围
    for(int i=0;i<shotRegion.count;i++){
        NSDictionary *regionDic = shotRegion[i];
        double ratio = [regionDic[@"ratio"] doubleValue];
        NSString *attrname = regionDic[@"attrname"];
        if ([attrname isEqualToString:@"港澳台"]) {
            NSString *priceText = [NSString stringWithFormat:@"+ ￥%ld(不含税)",(NSInteger)(_maxPrice*ratio)];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:priceText];
            
            [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} range:NSMakeRange(priceText.length-5,5)];
            self.GATPrice.attributedText = attStr;
          //  self.GATPrice.text = [NSString stringWithFormat:@"+ ￥%ld",(NSInteger)(_maxPrice*ratio)];
        }else if ([attrname isEqualToString:@"海外其他"]){
            NSString *priceText = [NSString stringWithFormat:@"+ ￥%ld(不含税)",(NSInteger)(_maxPrice*ratio)];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:priceText];
            
            [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} range:NSMakeRange(priceText.length-5,5)];
            self.globalPrice.attributedText = attStr;
//            self.globalPrice.text = [NSString stringWithFormat:@"+ ￥%ld",(NSInteger)(_maxPrice*ratio)];
        }
    }
    NSArray *shotTravel = config[@"shotTravel"];//是否异地
    for(int i=0;i<shotTravel.count;i++){
        NSDictionary *travalDic = shotTravel[i];
        double ratio = [travalDic[@"ratio"] doubleValue];
        NSString *attrname = travalDic[@"attrname"];
        if ([attrname isEqualToString:@"提前1天下午出发"]) {
            if (ratio==0) {
                ratio=0.3;
            }
            NSString *priceText = [NSString stringWithFormat:@"+ ￥%ld(不含税)",(NSInteger)(_maxPrice*ratio)];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:priceText];
            
            [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} range:NSMakeRange(priceText.length-5,5)];
            self.afterNoonPrice.attributedText = attStr;
//            self.afterNoonPrice.text = [NSString stringWithFormat:@"+ ￥%ld",(NSInteger)(_maxPrice*ratio)];
        }else if ([attrname isEqualToString:@"提前1天上午出发"]){
            if (ratio==0) {
                ratio=0.5;
            }
            NSString *priceText = [NSString stringWithFormat:@"+ ￥%ld(不含税)",(NSInteger)(_maxPrice*ratio)];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:priceText];
            
            [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} range:NSMakeRange(priceText.length-5,5)];
            self.beforeNoonPrice.attributedText = attStr;
//            self.beforeNoonPrice.text = [NSString stringWithFormat:@"+ ￥%ld",(NSInteger)(_maxPrice*ratio)];
        }
    }
    
    if (_maxPrice==0) {
        self.year2Price.text = @"+ ￥待定";
        self.year3Price.text = @"+ ￥待定";
        self.GATPrice.text = @"+ ￥待定";
        self.globalPrice.text = @"+ ￥待定";
        self.afterNoonPrice.text = @"+ ￥待定";
        self.beforeNoonPrice.text = @"+ ￥待定";
    }
    
        NSInteger status = [UserInfoManager getUserStatus];
    if (status>200) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
            [self addVipIconWithPriceLabel:self.year1Price];
            [self addVipIconWithPriceLabel:self.year2Price];
            [self addVipIconWithPriceLabel:self.year3Price];
          [self addVipIconWithPriceLabel:self.foreverPrice];
            [self addVipIconWithPriceLabel:self.mainLandPrice];
            [self addVipIconWithPriceLabel:self.GATPrice];
            [self addVipIconWithPriceLabel:self.globalPrice];
            [self addVipIconWithPriceLabel:self.bendiPrice];
            [self addVipIconWithPriceLabel:self.afterNoonPrice];
            [self addVipIconWithPriceLabel:self.beforeNoonPrice];
      //  });
      
    }
      [self calculate];
}


- (IBAction)year1Action:(id)sender {
    [self.year1Btn setSelected:YES];
    [self.year2Btn setSelected:NO];
    [self.year3Btn setSelected:NO];
    [self.foreverBtn setSelected:NO];
    self.year = 1;
      self.portraitTimeLabel.text = @"肖像年限(1年)";
     [self calculate];
}
- (IBAction)year2Action:(id)sender {
    [self.year1Btn setSelected:NO];
    [self.year2Btn setSelected:YES];
    [self.year3Btn setSelected:NO];
    [self.foreverBtn setSelected:NO];
     self.year = 2;self.portraitTimeLabel.text = @"肖像年限(2年)";
     [self calculate];
}
- (IBAction)year3Action:(id)sender {
    [self.year1Btn setSelected:NO];
    [self.year2Btn setSelected:NO];
    [self.year3Btn setSelected:YES];
    [self.foreverBtn setSelected:NO];
     self.year = 3;
    self.portraitTimeLabel.text = @"肖像年限(3年)";
     [self calculate];
}
- (IBAction)foreverAction:(id)sender {
    [self.year1Btn setSelected:NO];
    [self.year2Btn setSelected:NO];
    [self.year3Btn setSelected:NO];
    [self.foreverBtn setSelected:YES];
    self.portraitTimeLabel.text = @"肖像年限(独家买断)";
     self.year = 6;
     [self calculate];
}

- (IBAction)mainLandAction:(id)sender {
    [self.mainLandBtn setSelected:YES];
    [self.GATBtn setSelected:NO];
    [self.globalBtn setSelected:NO];
    self.region = 1;
    self.portraitRegionLabel.text = @"肖像范围(中国大陆)";
     [self calculate];
}
- (IBAction)GATAction:(id)sender {
    [self.mainLandBtn setSelected:NO];
    [self.GATBtn setSelected:YES];
    [self.globalBtn setSelected:NO];
     self.region = 2;
      self.portraitRegionLabel.text = @"肖像范围(港澳台)";
     [self calculate];
}
- (IBAction)globalAction:(id)sender {
    [self.mainLandBtn setSelected:NO];
    [self.GATBtn setSelected:NO];
    [self.globalBtn setSelected:YES];
     self.region = 3;
      self.portraitRegionLabel.text = @"肖像范围(海外全球)";
     [self calculate];
}
- (IBAction)benDi:(id)sender {
    [self.bendiBtn setSelected:YES];
    [self.afterNoonBtn setSelected:NO];
    [self.beforeNoonBtn setSelected:NO];
    self.yidi = 1;
     [self calculate];
}
- (IBAction)afterNoonAction:(id)sender {
    [self.bendiBtn setSelected:NO];
    [self.afterNoonBtn setSelected:YES];
    [self.beforeNoonBtn setSelected:NO];
      self.yidi = 2;
     [self calculate];
}
- (IBAction)beforeNoonAction:(id)sender {
    [self.bendiBtn setSelected:NO];
    [self.afterNoonBtn setSelected:NO];
    [self.beforeNoonBtn setSelected:YES];
      self.yidi = 3;
    [self calculate];
}
-(void)calculate
{
    if (self.year>0 && self.region>0 && self.yidi>0 && _selectPrice.count>0) {
        NSMutableArray *itemList = [NSMutableArray new];
        for (AskCalendarPriceModel *model in _selectPrice) {
            NSDictionary *priceDic = @{
                                       @"singleType":@(model.type),
                                       @"price":@(model.price),
                                       @"days":@(model.day)
                                       };
            [itemList addObject:priceDic];
        }
        NSInteger shotCycle = self.year;
        NSInteger shotRegion = self.region+16;
        NSInteger shotTravel = self.yidi-1;
        NSDictionary *shotOrderType = @{
                                        @"shotCycle":@(shotCycle),
                                        @"shotRegion":@(shotRegion),
                                        @"shotTravel":@(shotTravel)
                                        };
        NSDictionary *arg = @{
                              @"actorId":@(_actorId),
                              @"projectId":_projectId,
                              @"userId":[UserInfoManager getUserUID],
                              @"itemList":[itemList copy],
                              @"shotOrderType":shotOrderType
                              };
        [AFWebAPI_JAVA getTotalPriceDetailWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSDictionary *priceInfo = object[@"body"][@"orderPriceDetail"];
                NSInteger shotCyclePrice = [priceInfo[@"shotCyclePrice"] integerValue];//年限
                NSInteger shotRegionPrice = [priceInfo[@"shotRegionPrice"] integerValue];//范围
                NSInteger shotTravelPrice = [priceInfo[@"shotTravelPrice"] integerValue];//异地
                NSInteger showPrice = [priceInfo[@"showPrice"] integerValue];//演员费
                NSInteger showFreePrice = [priceInfo[@"showFreePrice"] integerValue];//演员费优惠
                NSInteger vipFreePrice = [priceInfo[@"vipFreePrice"] integerValue];//vip优惠
                NSInteger totalPrice = [object[@"body"][@"totalPrice"] integerValue];//总价
                
                self.actorCost.text = [NSString stringWithFormat:@"￥ %ld",showPrice];
//                self.portraitTimeLabel.text = [NSString stringWithFormat:@"肖像年限(%ld年)",_year];
                self.portraitTimeCost.text = [NSString stringWithFormat:@"￥ %ld",shotCyclePrice];
//                NSArray *regions = @[@"大陆",@"港澳台",@"海外全球"];
//                self.portraitRegionLabel.text = [NSString stringWithFormat:@"肖像范围(%@)",[regions objectAtIndex:_region-1]];
                self.portraitRegionCost.text = [NSString stringWithFormat:@"￥ %ld",shotRegionPrice];
                 self.yidiCost.text = [NSString stringWithFormat:@"￥ %ld",shotTravelPrice];
                 self.actorOff.text = [NSString stringWithFormat:@"-￥ %ld",showFreePrice];
                 self.vipOff.text = [NSString stringWithFormat:@"-￥ %ld",vipFreePrice];
                   self.totalPrice.text = [NSString stringWithFormat:@"￥%ld",totalPrice];
                 self.orderTotalLabel.text = [NSString stringWithFormat:@"￥ %ld",totalPrice];
                self.total_vip = totalPrice;
                self.total_normal = totalPrice+vipFreePrice;
            }
        }];
    }else{
        self.totalPrice.text = @"￥ 0";
    }
}
- (IBAction)priceDetailAction:(id)sender {

//    @property (weak, nonatomic) IBOutlet UILabel *actorCost;
//    @property (weak, nonatomic) IBOutlet UILabel *portraitTimeLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *portraitTimeCost;
//    @property (weak, nonatomic) IBOutlet UILabel *portraitRegionLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *portraitRegionCost;
//    @property (weak, nonatomic) IBOutlet UILabel *yidiCost;
//    @property (weak, nonatomic) IBOutlet UILabel *actorOff;
//    @property (weak, nonatomic) IBOutlet UILabel *vipOff;
//    @property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;
    
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
    
    UIView *maskV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    maskV.backgroundColor = [UIColor blackColor] ;
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    self.maskV=maskV;
    
   [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 0.65f;
     maskV.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-self.priceDetailPopView.height);
    self.priceDetailPopView.frame = CGRectMake(0, self.view.height-_priceDetailPopView.height, UI_SCREEN_WIDTH,_priceDetailPopView.height);
    
    [UIView commitAnimations];
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
 
    self.maskV.alpha = 0.f;
    self.maskV.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    self.priceDetailPopView.frame = CGRectMake(0, self.view.height, UI_SCREEN_WIDTH,_priceDetailPopView.height);
    [UIView commitAnimations];
}
- (IBAction)serviceAction:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"telprompt://4008336969"]];
}

- (IBAction)ensure:(id)sender {
//     if (self.year>0 && self.region>0 && self.yidi>0 && _selectPrice.count>0)
    if(_year == 0){
        [SVProgressHUD showErrorWithStatus:@"请选择肖像使用年限"];
        return;
    }
    if(_region == 0){
        [SVProgressHUD showErrorWithStatus:@"请选择肖像使用范围"];
        return;
    }

    if(_yidi == 0){
        [SVProgressHUD showErrorWithStatus:@"请选择是否异地拍摄"];
        return;
    }
    if(_selectPrice.count == 0){
        [SVProgressHUD showErrorWithStatus:@"请选择拍摄类型"];
        return;
    }
    if (_year==6) {
        AskPriceView *ap  = [[AskPriceView alloc] init];
        [ap showWithTitle:@"咨询价格" desc:@"独家买断肖像权价格受拍摄脚本，品牌方影响较大，无固定价格。具体价格请拨打400-833-6969详询脸探副导。" leftBtn:@"" rightBtn:@"" phoneNum:@"4008336969"];
        return;
    }
    if (_pushType==1||_pushType==3) {//从演员主页的报价选择进来,从询档页面里的报价选择进来
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate selectPrices:_selectPrice andYear:_year andRegion:_region andYidi:_yidi andTotal_vip:_total_vip andTotalNormal:_total_normal];
    }else if (_pushType==2){ //从演员主页询档按钮进来
        AskCalendarVC *acvc = [AskCalendarVC new];
        acvc.info = _info;
        acvc.selectArray = _selectPrice;
        acvc.orderYear = _year;
        acvc.orderRegion = _region;
        acvc.otherArea = _yidi;
        acvc.total_vip = _total_vip;
        acvc.total_normal = _total_normal;
        [self.navigationController pushViewController:acvc animated:YES];
    }
 
}
- (IBAction)closeDetail:(id)sender {
    [self hide];
}
- (IBAction)vipAction:(id)sender {
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {   //游客模式
        LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
        [self presentViewController:login animated:YES completion:nil];
        return;
    }
    
    VIPViewController *vip=[[VIPViewController alloc]init];
    vip.hidesBottomBarWhenPushed=YES;
    vip.reloadUI = ^{
        // [weakself.tableV reloadData];
    };
    [self.navigationController pushViewController:vip animated:YES];
}
//给label带上vip图标
-(void)addVipIconWithPriceLabel:(UILabel *)label
{
    UIImageView *tagImg = [label.superview viewWithTag:label.tag+10];
    if (tagImg) {
        return;
    }
    CGFloat y = label.y;
    CGFloat hei = label.height;
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_vipPrice"]];
    [img setTag:label.tag+10];
    [label sizeToFit];
    CGFloat wid = label.width+96;
    label.frame = CGRectMake(UI_SCREEN_WIDTH-74-wid, y,wid , hei);
    img.frame = CGRectMake(label.right+3, label.y+5, 25, 10);
    [label.superview addSubview:img];
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)big_phoneBtnAction:(id)sender {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"telprompt://4008336969"]];
}
- (IBAction)colseTipvIEW:(id)sender {
    self.tipView.hidden = YES;
}
@end
