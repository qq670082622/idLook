//
//  priceGroupPopV.m
//  IDLook
//
//  Created by 吴铭 on 2018/12/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OfferTypePopV2.h"
#import "PriceModel.h"

#import "PlaceOrderModel.h"
@interface OfferTypePopV2 ()
{
    CGFloat Vheight;   //视图高度
    NSInteger kViewType;//1视频 2平面 3组合
}
@property (nonatomic,strong)NSMutableArray *dataS;
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,assign)NSInteger select_video;//视频类选择
@property (nonatomic,assign)NSInteger select_photo;//平面类选择
@end

@implementation OfferTypePopV2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"OfferTypePopV2" owner:nil options:nil] lastObject];
        self.select_video = 0;
        self.select_photo = 0;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}
- (void)showOfferTypeWithPriceList:(NSArray *)list withSelectArray:(NSArray *)array withUserModel:(UserInfoM*)userModel
{
   //测试外籍模特用userModel.mastery = 3;
    self.ensureBtn.layer.masksToBounds=YES;
    self.ensureBtn.layer.cornerRadius=5.0;
  
    NSInteger viewType=0;//页面是组合还是单个 默认单个  1视频 2平面 3组合
   // PriceModel *selectModel = [PriceModel new];
    BOOL isVideo = false;
    BOOL isPhoto = false;
    BOOL hasVideo_tvcAdd = false;//tvc影视广告
    BOOL hasVideo_microFilm = false;//微电影广告
    BOOL hasVideo_advertise = false;//Video宣传片
    BOOL hasPlane_plane = false;//全平面
    BOOL hasPlane_planeAdver = false;//内部宣传
    BOOL hasPlane_planePack = false;//产品包装
    
    for (int i=0; i<list.count; i++) {//装载模型数组，判断弹窗选中服务，梳理没有的服务类型
        PriceModel *model = [[PriceModel alloc]initWithDic:list[i]];
        /**
         广告子类型
         11TVC，12Video宣传，13微电影；
         21全平面，22内部宣传，23产品包装；
         */
        float price1 = [PlaceOrderModel getRatioWithSinglePriceWithNew:model.price]*model.price;//平面或视频原价(含税)
        NSString *ratioPrice = [NSString stringWithFormat:@"%.f元/天",price1];
        NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:ratioPrice];

        [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                                        value:[UIFont systemFontOfSize:11]
                                        range:NSMakeRange(aAttributedString.length-2, 2)];
       
        //选择了视频时，平面的折扣价(含税)
        double PlaneOffPrice = userModel.rate*price1;
        NSInteger PlaneOffPrice2 =round(PlaneOffPrice);
        NSMutableAttributedString * aAttributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld元/天",(long)PlaneOffPrice2]];
        [aAttributedString2 addAttribute:NSFontAttributeName             //文字字体
                                  value:[UIFont systemFontOfSize:11]
                                  range:NSMakeRange(aAttributedString2.length-2, 2)];
        if (model.type == 1) {
            isVideo = YES;
            if (model.subType==Videotype_tvcAdd) {
                hasVideo_tvcAdd = YES;
                //装载UI
                self.tvcAddview_Title.text = model.title;
                self.tvcAddview_priceLabel.attributedText = aAttributedString;
                
            }else if (model.subType==Videotype_microFilm) {
                hasVideo_microFilm = YES;
                self.microFilmview_Title.text = model.title;
                self.microFilmview_priceLabel.attributedText = aAttributedString;
            }else if (model.subType==Videotype_advertise) {
                hasVideo_advertise = YES;
                self.advertiseView_Title.text = model.title;
                self.advertiseview_priceLabel.attributedText = aAttributedString;
            }
        
        }else if (model.type == 2){
            isPhoto = YES;
            if (model.subType==PlaneType_plane) {
                hasPlane_plane = YES;
                self.planeView_Title.text = model.title;
                self.planeview_priceLabel.attributedText = aAttributedString;
                self.planeView_priceNewLabel.attributedText = aAttributedString2;
            }else if (model.subType==PlaneType_planeAdver) {
                hasPlane_planeAdver = YES;
                self.planeAdverView_Title.text = model.title;
                self.planeAdver_priceLabel.attributedText = aAttributedString;
                self.planeAdver_priceNewLabel.attributedText = aAttributedString2;
            }else if (model.subType==PlaneType_planePack) {
                hasPlane_planePack = YES;
                self.planePackView_Title.text = model.title;
                self.planePack_priceLabel.attributedText = aAttributedString;
                self.planePack_priceNewLabel.attributedText = aAttributedString2;
            }
        }
        
      [self.dataS addObject:model];
    }
    for (int i=0; i<array.count; i++) {//便利选中的model
        PriceModel *priceM = array[i];
        if (priceM.subType==Videotype_microFilm||priceM.subType==Videotype_advertise||priceM.subType==Videotype_tvcAdd) {
            self.select_video = priceM.subType;//表示选中视频产品
        }
        if (priceM.subType==PlaneType_plane||priceM.subType==PlaneType_planeAdver||priceM.subType==PlaneType_planePack) {
            self.select_photo =priceM.subType;
        }

    }
    //根据艺人能提供的服务内容给UI进行隐藏
    [self hideProdductWithBoolsHasVideo_tvcAdd:hasVideo_tvcAdd andHasVideo_microFilm:hasVideo_microFilm andHasVideo_advertise:hasVideo_advertise andHasPlane_plane:hasPlane_plane andHasPlane_planeAdver:hasPlane_planeAdver andHasPlane_planePack:hasPlane_planePack];
    //非老外不展示老外提示
    CGFloat foreignHeight = 38;
    BOOL isForeigner = YES;
    if (userModel.mastery != 3) {//不是老外
        self.foreignerTips.hidden = YES;
       isForeigner = NO;
    }
    //选择展示视频还是平面类
        if (isVideo==YES && isPhoto==YES) {//组合全
            viewType = 3;
            if (userModel.mastery != 3) {//不是老外
                self.ensureBtn.y = self.photoView.bottom+30;
            }
            }else if (isVideo==NO && isPhoto==YES){//只有平面
            viewType = 2;
                self.videoView.hidden = YES;

                self.photoView.center = self.videoView.center;
                if (userModel.mastery != 3) {//不是老外
                    self.foreignerTips.hidden = YES;
                    self.ensureBtn.y = self.photoView.bottom+30;
                }else{
                    self.foreignerTips.y = self.photoView.bottom+12;
                    self.ensureBtn.y = self.foreignerTips.bottom+27;
                }
               
            }else if (isVideo==YES && isPhoto==NO){//只有视频
                viewType = 1;
                self.photoView.hidden = YES;
                if (userModel.mastery != 3) {//不是老外
                    self.foreignerTips.hidden = YES;
                     self.ensureBtn.y = self.videoView.bottom+27;
                   }else{
                    self.foreignerTips.y = self.videoView.bottom+12;
                       self.ensureBtn.y = self.foreignerTips.bottom+27;
                    }
    }
     //根据艺人提供的服务内容算出加载的popview的高度
    //单个要-182 603是全部
    Vheight = viewType==3?603:421;
    if (isForeigner == NO) {
        Vheight-=foreignHeight;
    }
  
    kViewType = viewType;
    //确定页面 subviews 1，视频产品进来 展开折扣 2，平面产品进来或者什么都没选进来，关闭折扣
    if (_select_photo>=PlaneType_plane && _select_video<Videotype_tvcAdd) {//说明是纯平面，则关闭折扣
        [self showOffPriceOffUI];
        //纯平面将videoDay置0
        [self setVideoViewDayZero];
        //装载平面选择
            //装载平面天数
        UIButton *tagBtn2 = [UIButton buttonWithType:0];
        [tagBtn2 setTag:200];
            PriceModel *prModel = [array firstObject];
            self.planeView_DayLabel.text = [NSString stringWithFormat:@"%ld",prModel.day];
        [self dayButtonsListenAndFit];//适配天数各种按钮图片和是否能点击
            if (prModel.subType==PlaneType_plane) {
                [self planeViewSelect:tagBtn2];
            }else if (prModel.subType==PlaneType_planeAdver){
                [self planeAdverSelect:tagBtn2];
            }else if (prModel.subType==PlaneType_planePack){
                [self planePackSelect:tagBtn2];
            }
        }
    
    if (_select_video>=Videotype_tvcAdd && _select_photo<PlaneType_plane) {//说明是单个的视频
        //是单个视频，将planeDay置0
        [self setPlaneViewDayZero];
        PriceModel *prModel = [array firstObject];
           //装载视频选
                //装载视频天数
        UIButton *tagBtn = [UIButton buttonWithType:0];
        [tagBtn setTag:100];
                self.videoView_DayLabel.text = [NSString stringWithFormat:@"%ld",prModel.day];
         [self dayButtonsListenAndFit];//适配天数各种按钮图片和是否能点击
                if (prModel.subType==Videotype_tvcAdd) {
                    
                    [self tvcAddview_select:tagBtn];
                }else if (prModel.subType==Videotype_microFilm){
                    [self microFilmview_select:tagBtn];
                }else if (prModel.subType==Videotype_advertise){
                    [self advertiseview_select:tagBtn];
                }
            }
    
    if (_select_video>=Videotype_tvcAdd && _select_photo>=PlaneType_plane) {//说明视频、平面都有选
        //装载选择的天数,两个UI被选择上
        UIButton *tagBtn = [UIButton buttonWithType:0];
        [tagBtn setTag:100];
        UIButton *tagBtn2 = [UIButton buttonWithType:0];
        [tagBtn2 setTag:200];
        for(PriceModel *prModel in array){
            if (prModel.type==1) {//装载视频选择
                //装载视频天数
                self.videoView_DayLabel.text = [NSString stringWithFormat:@"%ld",prModel.day];
                 [self dayButtonsListenAndFit];//适配天数各种按钮图片和是否能点击
                if (prModel.subType==Videotype_tvcAdd) {
                    [self tvcAddview_select:tagBtn];
                }else if (prModel.subType==Videotype_microFilm){
                    [self microFilmview_select:tagBtn];
                }else if (prModel.subType==Videotype_advertise){
                    [self advertiseview_select:tagBtn];
                }
            }else if (prModel.type==2){//装载平面选择
                //装载平面天数
                self.planeView_DayLabel.text = [NSString stringWithFormat:@"%ld",prModel.day];
                 [self dayButtonsListenAndFit];//适配天数各种按钮图片和是否能点击
                if (prModel.subType==PlaneType_plane) {
                    [self planeViewSelect:tagBtn2];
                }else if (prModel.subType==PlaneType_planeAdver){
                    [self planeAdverSelect:tagBtn2];
                }else if (prModel.subType==PlaneType_planePack){
                    [self planePackSelect:tagBtn2];
                }
            }
        }
    }
    if (_select_video<Videotype_tvcAdd && _select_photo<PlaneType_plane) {//说明没选择,则关闭折扣
        [self showOffPriceOffUI];
        //视频、平面 day均置0
       
        [self setVideoViewDayZero];
         [self setPlaneViewDayZero];
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
    
    if (viewType == 3) {//组合类需要折扣价格展示
        //默认就是组合价
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
        if (Vheight>UI_SCREEN_HEIGHT) {//说明弹窗比屏幕还高
            self.frame = CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT);
            self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, Vheight);
            self.scrollView.scrollEnabled = YES;
            self.scrollView.showsVerticalScrollIndicator = YES;
        }else{
            self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
        }
    [UIView commitAnimations];
}
  


- (IBAction)tvcAddview_select:(id)sender { //tvc影视广告被选中  1.已经被选中则取消选中 2.未被选中则选中且取消其他选中，并改变平面折扣UI
    //取消所有视频选中
    [self uncheckUIWithType:1];//先取消所有视频选中
    [self showOffPriceOffUI];//取消折扣UI
   UIButton *btn = (UIButton *)sender;//防止页面刚加载时选择被认为是重复点击导致无法对选择的内容标红
    if (_select_video!=Videotype_tvcAdd || btn.tag==100){//
         //首次被选中时，若平面已经被选中且平面天数大于视频天数，立即将平面天数设置为1
        
    //选中该视频
        [self changeUIWithProductIsSelected:self.tvcAddview_Title andPrice:self.tvcAddview_priceLabel andNewPrice:self.tvcAddview_priceLabel andImage:self.tvcAddview_Image isVideo:YES];
        if (_select_video==0) {//首次选中默认day+1
            self.videoView_DayLabel.text = @"1";
        }//换选day不变
        [self showOnPriceOffUI];//增加折扣UI
    self.select_video = Videotype_tvcAdd;
    }else{//仅取消当前选中，未改变其他选中
       // [self setVideoViewDayZero];
        [self setVideoDayZeroWithNoSelect];
        self.select_video = 0;
}
    [self dayButtonsListenAndFit];
}
- (IBAction)microFilmview_select:(id)sender{//微电影广告被选中
    [self uncheckUIWithType:1];//先取消所有视频选中
    [self showOffPriceOffUI];//取消折扣UI
     UIButton *btn = (UIButton *)sender;//防止页面刚加载时选择被认为是重复点击导致无法对选择的内容标红
    if (_select_video != Videotype_microFilm || btn.tag==100) {
        //首次被选中时，若平面已经被选中且平面天数大于视频天数，立即将平面天数设置为1
        
        [self changeUIWithProductIsSelected:self.microFilmview_Title andPrice:self.microFilmview_priceLabel andNewPrice:self.microFilmview_priceLabel andImage:self.microFilmview_Image isVideo:YES];
        if (_select_video==0) {//首次选中默认day+1
            self.videoView_DayLabel.text = @"1";
        }//换选day不变
        [self showOnPriceOffUI];//增加折扣UI
        self.select_video = Videotype_microFilm;
    }else{
       //  [self setVideoViewDayZero];
         [self setVideoDayZeroWithNoSelect];
        self.select_video = 0;
    }
   [self dayButtonsListenAndFit];
}

- (IBAction)advertiseview_select:(id)sender{//video宣传片被选中
    [self uncheckUIWithType:1];//先取消所有视频选中
    [self showOffPriceOffUI];//取消折扣UI
     UIButton *btn = (UIButton *)sender;//防止页面刚加载时选择被认为是重复点击导致无法对选择的内容标红
    if (_select_video != Videotype_advertise ||btn.tag==100) {
        //首次被选中时，若平面已经被选中且平面天数大于视频天数，立即将平面天数设置为1
        
        [self changeUIWithProductIsSelected:self.advertiseView_Title andPrice:self.advertiseview_priceLabel andNewPrice:self.advertiseview_priceLabel andImage:self.advertiseview_Image isVideo:YES];
        if (_select_video==0) {//首次选中默认day+1
            self.videoView_DayLabel.text = @"1";
        }//换选day不变
         [self showOnPriceOffUI];//增加折扣UI
        self.select_video = Videotype_advertise;
    }else{
       //  [self setVideoViewDayZero];
         [self setVideoDayZeroWithNoSelect];
        self.select_video = 0;
    }
     [self dayButtonsListenAndFit];
 }

- (IBAction)planeViewSelect:(id)sender {//全平面被选中
   
     [self uncheckUIWithType:2];//先取消所有平面选中
    UIButton *btn = (UIButton *)sender;//防止页面刚加载时选择被认为是重复点击导致无法对选择的内容标红
    if (_select_photo!=PlaneType_plane || btn.tag==200) {//选中某个平面
        
        [self changeUIWithProductIsSelected:self.planeView_Title andPrice:self.planeview_priceLabel andNewPrice:self.planeView_priceNewLabel andImage:self.planeview_Image isVideo:NO];
        if (_select_photo==0) {//首次选中默认day+1
            self.planeView_DayLabel.text = @"1";
        }//换选day不变
        self.select_photo = PlaneType_plane;
    }else{
      //  [self setPlaneViewDayZero];
        [self setPlaneDayZeroWithNoSelect];
        self.select_photo = 0;
    }
     [self dayButtonsListenAndFit];
 }

- (IBAction)planeAdverSelect:(id)sender {//内部宣传被选中
   [self uncheckUIWithType:2];
     UIButton *btn = (UIButton *)sender;//防止页面刚加载时选择被认为是重复点击导致无法对选择的内容标红
    if (_select_photo!=PlaneType_planeAdver || btn.tag==200) {
       
        [self changeUIWithProductIsSelected:self.planeAdverView_Title andPrice:self.planeAdver_priceLabel andNewPrice:self.planeAdver_priceNewLabel andImage:self.planeAdver_Image isVideo:NO];
        if (_select_photo==0) {//首次选中默认day+1
            self.planeView_DayLabel.text = @"1";
        }//换选day不变
        self.select_photo = PlaneType_planeAdver;
    }else{
       //  [self setPlaneViewDayZero];
         [self setPlaneDayZeroWithNoSelect];
        self.select_photo = 0;
    }
     [self dayButtonsListenAndFit];
}

- (IBAction)planePackSelect:(id)sender{//产品包装
    [self uncheckUIWithType:2];
    UIButton *btn = (UIButton *)sender;//防止页面刚加载时选择被认为是重复点击导致无法对选择的内容标红
    if (_select_photo!=PlaneType_planePack || btn.tag==200) {
       
        
        [self changeUIWithProductIsSelected:self.planePackView_Title andPrice:self.planePack_priceLabel andNewPrice:self.planePack_priceNewLabel andImage:self.planePack_Image isVideo:NO];
        if (_select_photo==0) {//首次选中默认day+1
            self.planeView_DayLabel.text = @"1";
        }//换选day不变
        self.select_photo = PlaneType_planePack;
    }else{
      //   [self setPlaneViewDayZero];
        [self setPlaneDayZeroWithNoSelect];
        self.select_photo = 0;;
    }
     [self dayButtonsListenAndFit];
}

//选中改变状态
-(void)changeUIWithProductIsSelected:(UILabel *)title andPrice:(UILabel *)price andNewPrice:(UILabel *)newPrice andImage:(UIImageView *)image isVideo:(BOOL)isVideo
{
    title.textColor = [UIColor whiteColor];
    price.textColor = Public_Red_Color;
    if (isVideo) {
        image.image = [UIImage imageNamed:@"priceCheck"];//选中图
        //video选中时若已经有了平面，则平面画原价变黑，新价标红
        if (_select_photo==PlaneType_plane) {
            self.planeview_priceLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];//Public_Text_Color;
            self.planeView_priceNewLabel.textColor = Public_Red_Color;
        }else if (_select_photo==PlaneType_planeAdver){
            self.planeAdver_priceLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];//Public_Text_Color;
            self.planeAdver_priceNewLabel.textColor = Public_Red_Color;
        }else if (_select_photo==PlaneType_planePack){
            self.planePack_priceLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];//Public_Text_Color;
            self.planePack_priceNewLabel.textColor = Public_Red_Color;
        }
    }else{//平面被选中
        //是否是组合图
        if (kViewType==3) {
            //组合平面若视频未被选中，则标红 的应该是原价
            image.image = [UIImage imageNamed:@"priceCheck_off"];
            if (_select_video==0) {//视频没有选中，原价标红
                 price.textColor = Public_Red_Color;
                 image.image = [UIImage imageNamed:@"priceCheck"];
            }else{//视频选中，原价标黑，新价标红
                price.textColor = [UIColor colorWithHexString:@"bcbcbc"];//Public_Text_Color;
                newPrice.textColor = Public_Red_Color;
            }
        }else{
            image.image = [UIImage imageNamed:@"priceCheck"];
            }
        }
}
#pragma - mark 取消产品选中 更改UI
-(void)uncheckUIWithType:(NSInteger)type
{
    if (type==1) {
        //取消视频类的选中 1.改变选中的视频的UI 2改变平面折扣UI 3如果平面被选中，选中UI不变
       // self.select_video = 0;
        [self UIUncheckWithProductIsSelected:self.tvcAddview_Title andPrice:self.tvcAddview_priceLabel andNewPrice:self.tvcAddview_priceLabel andImage:self.tvcAddview_Image isVideo:YES];
        [self UIUncheckWithProductIsSelected:self.microFilmview_Title andPrice:self.microFilmview_priceLabel andNewPrice:self.microFilmview_priceLabel andImage:self.microFilmview_Image isVideo:YES];
        [self UIUncheckWithProductIsSelected:self.advertiseView_Title andPrice:self.advertiseview_priceLabel andNewPrice:self.advertiseview_priceLabel andImage:self.advertiseview_Image isVideo:YES];
    }else if (type==2) {
        //取消平明类的选中
        [self UIUncheckWithProductIsSelected:self.planeView_Title andPrice:self.planeview_priceLabel andNewPrice:self.planeView_priceNewLabel andImage:self.planeview_Image isVideo:NO];
        [self UIUncheckWithProductIsSelected:self.planeAdverView_Title andPrice:self.planeAdver_priceLabel andNewPrice:self.planeAdver_priceNewLabel andImage:self.planeAdver_Image isVideo:NO];
        [self UIUncheckWithProductIsSelected:self.planePackView_Title andPrice:self.planePack_priceLabel andNewPrice:self.planePack_priceNewLabel andImage:self.planePack_Image isVideo:NO];
    }
}
-(void)UIUncheckWithProductIsSelected:(UILabel *)title andPrice:(UILabel *)price andNewPrice:(UILabel *)newPrice andImage:(UIImageView *)image isVideo:(BOOL)isVideo
{
    title.textColor = Public_Text_Color;
    price.textColor = Public_Text_Color;
    newPrice.textColor = Public_Text_Color;
    
    image.image = [UIImage imageNamed:@"priceUncheck"];
    if (!isVideo) {
        //是否是组合图
        if (kViewType==3 && _select_video!=0) {
           image.image = [UIImage imageNamed:@"priceUncheck_off"];
              price.textColor = [UIColor colorWithHexString:@"bcbcbc"];
            }else{
               image.image = [UIImage imageNamed:@"priceUncheck"];
                }
        }
}

- (IBAction)videoView_DayAddBtn:(id)sender{//视频拍摄天数增加
    //每次ttitle增加1 到5的时候改变button颜色 并失去触碰
    NSInteger dayCount = [self.videoView_DayLabel.text integerValue];
    dayCount++;
    self.videoView_DayLabel.text = [NSString stringWithFormat:@"%ld",dayCount];
    if (dayCount==5) {
        [self.videoView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
        self.videoView_DayAddBtn.userInteractionEnabled = NO;
    }
    [self.videoView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:0];
    self.videoView_DayMinusBtn.userInteractionEnabled = YES;
     [self dayButtonsListenAndFit];
}

- (IBAction)videoView_DayMinusBtn:(id)sender{//视频拍摄天数减少
   NSInteger dayCount = [self.videoView_DayLabel.text integerValue];
   
   //当视频被选中时，且平面当前天数等于视频天数，则要随着视频天数进行改变
    //每次ttitle减少1 到0的时候改变button颜色 并失去触碰
   dayCount--;
    self.videoView_DayLabel.text = [NSString stringWithFormat:@"%ld",dayCount];
    if (dayCount==0) {
        [self.videoView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
        self.videoView_DayMinusBtn.userInteractionEnabled = NO;
       
    }
    [self.videoView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:0];
    self.videoView_DayAddBtn.userInteractionEnabled = YES;
     [self dayButtonsListenAndFit];
}

- (IBAction)planeView_DayAddBtn:(id)sender{//平面拍摄天数增加
    //当视频被选中时，平面天数不能超过视频天数，当等于视频天数按钮图，值改变 [此处还要修改视频被选中时平面天数大于视频天数则立即改变平面天数]
    
    NSInteger dayCount = [self.planeView_DayLabel.text integerValue];
   dayCount++;
   self.planeView_DayLabel.text = [NSString stringWithFormat:@"%ld",dayCount];
   if (dayCount==5) {
        [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
        self.planeView_DayAddBtn.userInteractionEnabled = NO;
    }
    [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:0];
    self.planeView_DayMinusBtn.userInteractionEnabled = YES;
     [self dayButtonsListenAndFit];
}

- (IBAction)planeView_DayMinusBtn:(id)sender{//平面拍摄天数减少
    NSInteger dayCount = [self.planeView_DayLabel.text integerValue];
    dayCount--;
    self.planeView_DayLabel.text = [NSString stringWithFormat:@"%ld",dayCount];
    if (dayCount==0) {
        [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
        self.planeView_DayMinusBtn.userInteractionEnabled = NO;
        
    }
    [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:0];
    self.planeView_DayAddBtn.userInteractionEnabled = YES;
     [self dayButtonsListenAndFit];
}

- (IBAction)ensure:(id)sender {
    PriceModel *videoModel = [PriceModel new];
    PriceModel *photoModel = [PriceModel new];
    for (int i =0; i<self.dataS.count; i++)
    {
         PriceModel *model = self.dataS[i];
        if (model.subType == _select_video) {
            videoModel = model;
        }
        if (model.subType == _select_photo) {
            photoModel = model;
        }
    }
    //取出视频服务天数
    NSInteger videoDayCount = [self.videoView_DayLabel.text integerValue];
    //取出平面服务天数
    NSInteger photoDayCount = [self.planeView_DayLabel.text integerValue];
    
    NSMutableArray *array = [NSMutableArray new];
    if (_select_video!=0 && videoDayCount>0) {//初始值默认是0,不是0说明视频服务被选择
        videoModel.day=videoDayCount;
        [array addObject:videoModel];
    }
    if (_select_photo!=0 && photoDayCount>0) {
        photoModel.day = photoDayCount;
        [array addObject:photoModel];
    }
    if (array.count==0) {//两个都没选 提示选择天数不予退出弹窗
       [SVProgressHUD showImage:nil status:@"请选择天数。"];
        return;
    }
    self.typeSelectAction(array);
    [self hide];
}

- (IBAction)closePopV:(id)sender {//关闭弹窗
    [self hide];
}

-(void)changeUIWithSelectProductIndex:(NSInteger)selectIndex//根据选中的产品的subtype更改各类产品选中与否的UI
{
    //            11TVC，12Video宣传，13微电影；
    //            21全平面，22内部宣传，23产品包装；
    if (selectIndex<PlaneType_plane) {
       //取消所有视频类选中状态
        [self uncheckUIWithType:1];
        //说明选中的是视频产品 需要改变平面折扣价格
        [self showOnPriceOffUI];
        //根据选中index标红选中产品
        if (selectIndex==Videotype_tvcAdd) {
            [self changeUIWithProductIsSelected:self.tvcAddview_Title andPrice:self.tvcAddview_priceLabel andNewPrice:self.tvcAddview_priceLabel andImage:self.tvcAddview_Image isVideo:YES] ;
        }else if (selectIndex==Videotype_advertise){
             [self changeUIWithProductIsSelected:self.advertiseView_Title andPrice:self.advertiseview_priceLabel andNewPrice:self.advertiseview_priceLabel andImage:self.advertiseview_Image isVideo:YES];
        }else if (selectIndex==Videotype_microFilm){
           [self changeUIWithProductIsSelected:self.microFilmview_Title andPrice:self.microFilmview_priceLabel andNewPrice:self.microFilmview_priceLabel andImage:self.microFilmview_Image isVideo:YES];
        }
    }else if (selectIndex>=PlaneType_plane){
        //取消所有平面类选中状态
        [self uncheckUIWithType:2];
          //根据选中index标红选中产品
        if (selectIndex==PlaneType_plane) {
            [self changeUIWithProductIsSelected:self.planeView_Title andPrice:self.planeview_priceLabel andNewPrice:self.planeView_priceNewLabel andImage:self.planeview_Image isVideo:NO];
        }else if (selectIndex==PlaneType_planeAdver){
             [self changeUIWithProductIsSelected:self.planeAdverView_Title andPrice:self.planeAdver_priceLabel andNewPrice:self.planeAdver_priceNewLabel andImage:self.planeAdver_Image isVideo:NO];
        }else if (selectIndex==PlaneType_planePack){
          [self changeUIWithProductIsSelected:self.planePackView_Title andPrice:self.planePack_priceLabel andNewPrice:self.planePack_priceNewLabel andImage:self.planePack_Image isVideo:NO];
        }
        
    }
   
}

#pragma - mark 隐藏未提供的服务并重排UI
-(void)hideProdductWithBoolsHasVideo_tvcAdd:(BOOL)hasVideo_tvcAdd andHasVideo_microFilm:(BOOL)hasVideo_microFilm andHasVideo_advertise:(BOOL)hasVideo_advertise andHasPlane_plane:(BOOL)hasPlane_plane andHasPlane_planeAdver:(BOOL)hasPlane_planeAdver andHasPlane_planePack:(BOOL)hasPlane_planePack
{
    //1、隐藏未提供的服务内容
    if (hasVideo_tvcAdd == NO) {
        self.tvcAddView.hidden = YES;
    }
    if (hasVideo_microFilm == NO) {
        self.microFilmView.hidden = YES;
    }
    if (hasVideo_advertise == NO) {
        self.advertiseView.hidden = YES;
    }
    if (hasPlane_plane == NO) {
        self.planView.hidden = YES;
    }
    if (hasPlane_planeAdver == NO) {
        self.planeAdverView.hidden = YES;
    }
    if (hasPlane_planePack == NO) {
        self.planePackView.hidden = YES;
    }
    //2、 重新排序
    //tvc没有 改变宣传片和微电影的x
    if (hasVideo_tvcAdd == NO) {

        self.advertiseView.x = self.tvcAddView.x;
        self.microFilmView.x = self.advertiseView.x;
}
    
    //宣传片没有 改变微电影的x
    if (hasVideo_advertise == NO) {

        self.microFilmView.x = self.advertiseView.x;
    }
    //tvc、宣传片都没有 改变微电影的x
    if (hasVideo_tvcAdd == NO && hasVideo_advertise == NO){

        self.microFilmView.x = self.tvcAddView.x;
    }
    //全平面没有 改变内部宣传、产品包装的x
    if (hasPlane_plane == NO) {

        self.planeAdverView.x = self.planView.x;
        self.planePackView.x = self.planeAdverView.x;
    }
    //内部宣传没有 改变产品包装的x
    if (hasPlane_planeAdver == NO) {

        self.planePackView.x = self.planeAdverView.x;
    }
    //全平面、内部宣传都没有 改变产品包装的x
    if (hasPlane_plane == NO && hasPlane_planeAdver == NO) {

        self.planePackView.x = self.planView.x;
    }
}
#pragma -mark 取消折扣iUI
-(void)showOffPriceOffUI
{
    //取消xib中打折UI
    self.planeView_priceNewLabel.hidden = YES;
    self.planeview_OffLine.hidden = YES;
   
    if (_select_photo == PlaneType_plane) {//本身被选中的
        self.planeview_Image.image = [UIImage imageNamed:@"priceCheck"];
    }else{
        self.planeview_Image.image = [UIImage imageNamed:@"priceUncheck"];
        
    }
    
    self.planView.height = 64;

    self.planeAdver_priceNewLabel.hidden = YES;
    self.planeAdver_OffLine.hidden = YES;
    
    if (_select_photo == PlaneType_planeAdver) {
           self.planeAdver_Image.image = [UIImage imageNamed:@"priceCheck"];
    }else{
    self.planeAdver_Image.image = [UIImage imageNamed:@"priceUncheck"];
    }
        self.planeAdverView.height = 64;
    
    self.planePack_priceNewLabel.hidden = YES;
    self.planePack_OffLine.hidden = YES;
    
    if (_select_photo == PlaneType_planePack) {
          self.planePack_Image.image = [UIImage imageNamed:@"priceCheck"];
    }else{
    self.planePack_Image.image = [UIImage imageNamed:@"priceUncheck"];
    }
        self.planePackView.height = 64;

}
#pragma -mark 展示折扣UI
-(void)showOnPriceOffUI
{

    self.planeView_priceNewLabel.hidden = NO;
    self.planeview_OffLine.hidden = NO;
    if (_select_photo == PlaneType_plane) {//本身被选中的
        self.planeview_Image.image = [UIImage imageNamed:@"priceCheck_off"];
    }else{
        self.planeview_Image.image = [UIImage imageNamed:@"priceUncheck_off"];
    }
    
    self.planView.height = 84;

    self.planeAdver_priceNewLabel.hidden = NO;
    self.planeAdver_OffLine.hidden = NO;
    if (_select_photo == PlaneType_planeAdver) {
        self.planeAdver_Image.image = [UIImage imageNamed:@"priceCheck_off"];
    }else{
        self.planeAdver_Image.image = [UIImage imageNamed:@"priceUncheck_off"];
    }
    self.planeAdverView.height = 84;

    
    self.planePack_priceNewLabel.hidden = NO;
    self.planePack_OffLine.hidden = NO;
    if (_select_photo == PlaneType_planePack) {
        self.planePack_Image.image = [UIImage imageNamed:@"priceCheck_off"];
    }else{
        self.planePack_Image.image = [UIImage imageNamed:@"priceUncheck_off"];
    }
    self.planePackView.height = 84;
    
    self.planeview_priceLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
    self.planeAdver_priceLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
    self.planePack_priceLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
}
-(void)setVideoViewDayZero
{
    self.videoView_DayLabel.text = @"0";
    self.videoView_DayMinusBtn.userInteractionEnabled = NO;
    [self.videoView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
}
-(void)setPlaneViewDayZero
{
    self.planeView_DayLabel.text = @"0";
    self.planeView_DayMinusBtn.userInteractionEnabled = NO;
    [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
}
-(void)setPlaneViewDayOne//视频被选中时，平面选择的天数大于1，立即变成1
{
    self.planeView_DayLabel.text = @"1";
    self.planeView_DayAddBtn.userInteractionEnabled = NO;
    [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
    self.planeView_DayMinusBtn.userInteractionEnabled = YES;
    [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
}
-(void)dayButtonsListenAndFit//适配天数各种按钮图片和是否能点击
{
    NSInteger videoDay = [self.videoView_DayLabel.text integerValue];
    NSInteger planeDay = [self.planeView_DayLabel.text integerValue];
    //基础适配
    if (videoDay==0) {//减号不能用，换图片
        self.videoView_DayMinusBtn.userInteractionEnabled = NO;
        [self.videoView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
    }
    if (videoDay==5) {//加号不能用，换图片
        self.videoView_DayAddBtn.userInteractionEnabled = NO;
        [self.videoView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
    }
    if (planeDay==0) {
        self.planeView_DayMinusBtn.userInteractionEnabled = NO;
        [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
    }
    if (planeDay==5) {
        self.planeView_DayAddBtn.userInteractionEnabled = NO;
        [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
    }
    //视频选择和适配 当视频天数被选择 1，平面天数置1，按钮失去作用
    if([self.videoView_DayLabel.text integerValue] == 1 && self.select_video>=Videotype_tvcAdd){
        self.planeView_DayAddBtn.userInteractionEnabled = NO;
        [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
    }
    //当视频天数取消选中 平面按钮恢复有效
    if(_select_video==0 && [self.planeView_DayLabel.text integerValue]<5){
        self.planeView_DayAddBtn.userInteractionEnabled = YES;
        [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:0];
    }
    //当视频选中状态下添加天数，如果平面天数小于视频天数，平面按钮恢复作用。 比如视频平面都是1，1 视频变2，平面加号有效
    if (self.select_video>=Videotype_tvcAdd && [self.videoView_DayLabel.text integerValue] > 0 && [self.planeView_DayLabel.text integerValue]<[self.videoView_DayLabel.text integerValue]) {
        self.planeView_DayAddBtn.userInteractionEnabled = YES;
        [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:0];
    }
    //当视频选中状态下减小天数，如果平面天数大于视频天数自动减小天数 且加号无用
    if (self.select_video>=Videotype_tvcAdd && [self.planeView_DayLabel.text integerValue]>=[self.videoView_DayLabel.text integerValue]) {
        self.planeView_DayLabel.text = self.videoView_DayLabel.text;
        self.planeView_DayAddBtn.userInteractionEnabled = NO;
        [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
    }
    
    if ([self.planeView_DayLabel.text integerValue]>0) {//任何情况下平面的天数都可以减到0
        self.planeView_DayMinusBtn.userInteractionEnabled = YES;
        [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:0];
    }
    if ([self.videoView_DayLabel.text integerValue]>0) {//任何情况下平面的天数都可以减到0
        self.videoView_DayMinusBtn.userInteractionEnabled = YES;
        [self.videoView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:0];
    }
     NSInteger videoDay2 = [self.videoView_DayLabel.text integerValue];
    NSInteger planeDay2 = [self.planeView_DayLabel.text integerValue];
    if (planeDay2==0) {
        self.planeView_DayMinusBtn.userInteractionEnabled = NO;
        [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
        if (_select_photo == 0) {
            [self setPlaneDayZeroWithNoSelect];
        }
    }
    // 视频或者平面被选中下 最低一天
    if(_select_video>=Videotype_tvcAdd && videoDay2==1){
        self.videoView_DayMinusBtn.userInteractionEnabled = NO;
        [self.videoView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
        self.videoView_DayAddBtn.userInteractionEnabled = YES;
        [self.videoView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:0];
    }
    if (_select_photo>=PlaneType_plane && planeDay2==1) {
        self.planeView_DayMinusBtn.userInteractionEnabled = NO;
        [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
    }
}
//取消选中时按钮置灰
-(void)setVideoDayZeroWithNoSelect
{
self.videoView_DayLabel.text = @"0";
self.videoView_DayMinusBtn.userInteractionEnabled = NO;
[self.videoView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
    self.videoView_DayAddBtn.userInteractionEnabled = NO;
    [self.videoView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
    self.planeview_priceLabel.textColor = Public_Text_Color;
    self.planeAdver_priceLabel.textColor = Public_Text_Color;
    self.planePack_priceLabel.textColor = Public_Text_Color;
}
-(void)setPlaneDayZeroWithNoSelect
{
    self.planeView_DayLabel.text = @"0";
    self.planeView_DayMinusBtn.userInteractionEnabled = NO;
    [self.planeView_DayMinusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
    self.planeView_DayAddBtn.userInteractionEnabled = NO;
    [self.planeView_DayAddBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
}
-(NSMutableArray*)dataS
{
    if (!_dataS) {
        _dataS=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataS;
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
