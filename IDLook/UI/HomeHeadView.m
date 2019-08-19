//
//  HomeHeadView.m
//  IDLook
//
//  Created by HYH on 2018/5/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeHeadView.h"
@interface HomeHeadView()
- (IBAction)adverAction:(id)sender;
- (IBAction)movieAction:(id)sender;
- (IBAction)foreignModel:(id)sender;
- (IBAction)massesAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UIView *btnViews;
@property (weak, nonatomic) IBOutlet UIView *annunciateView;

- (IBAction)checkAnnunciate:(id)sender;

- (IBAction)testAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *testView;

- (IBAction)insuranceAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *insuranceView;

- (IBAction)storeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *storeView;

- (IBAction)guideAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *guideView;

@property (weak, nonatomic) IBOutlet UIView *vip;
- (IBAction)vipAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end
@implementation HomeHeadView

//-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
//        self.contentView.backgroundColor=[UIColor clearColor];
//        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
//        self.contentView.layer.borderWidth=0.0;
//        self.backgroundView = ({
//            UIView * view = [[UIView alloc] initWithFrame:self.bounds];
//            view.backgroundColor = [UIColor whiteColor];
//            view;
//        });
//        [self initUI];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeadView" owner:nil options:nil] lastObject];
    }
    [self initUI];
    return self;
}
-(void)initUI
{
   _testView.layer.cornerRadius=4.0;
    _testView.layer.shadowOffset = CGSizeMake(0, 0);
    _testView.layer.shadowOpacity = 0.3;
    _testView.layer.shadowColor = [[UIColor colorWithHexString:@"#090E13"] colorWithAlphaComponent:0.2].CGColor;
    _testView.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
    _testView.layer.borderWidth= 1 ;
  //  _testView.layer.masksToBounds = YES;
  
    _insuranceView.layer.cornerRadius=5.0;
    _insuranceView.layer.shadowOffset = CGSizeMake(0, 0);
    _insuranceView.layer.shadowOpacity = 0.3;
    _insuranceView.layer.shadowColor = [[UIColor colorWithHexString:@"#090E13"] colorWithAlphaComponent:0.2].CGColor;
    _insuranceView.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
    _insuranceView.layer.borderWidth= 1 ;
  //  _insuranceView.layer.masksToBounds = YES;
    
    _storeView.layer.cornerRadius=4.0;
    _storeView.layer.shadowOffset = CGSizeMake(0, 0);
    _storeView.layer.shadowOpacity = 0.3;
    _storeView.layer.shadowColor = [[UIColor colorWithHexString:@"#090E13"] colorWithAlphaComponent:0.2].CGColor;
    _storeView.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
    _storeView.layer.borderWidth= 1 ;
 //   _storeView.layer.masksToBounds = YES;
  
    _guideView.layer.cornerRadius=4.0;
    _guideView.layer.shadowOffset = CGSizeMake(0, 0);
    _guideView.layer.shadowOpacity = 0.3;
    _guideView.layer.shadowColor = [[UIColor colorWithHexString:@"#090E13"] colorWithAlphaComponent:0.2].CGColor;
    _guideView.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
    _guideView.layer.borderWidth= 1 ;
  //  _guideView.layer.masksToBounds = YES;
    
    _annunciateView.layer.cornerRadius = 6;
    _annunciateView.layer.masksToBounds = YES;
    
   
    NSDictionary *configDic =   [UserInfoManager getPublicConfig];
        NSDictionary  *homePageInfo = configDic[@"homePageInfo"];
        NSString *homePageTitle = homePageInfo[@"homePageTitle"];
    BOOL enable =  YES;//[homePageInfo[@"EnableShotBroadcast"] boolValue];//是不是有通告
    _tipLabel.text = @"推荐演员";
    if(homePageTitle.length>0){
        _tipLabel.text = homePageTitle;
    }
    self.vip.layer.cornerRadius = 3;
    self.vip.layer.masksToBounds = YES;
    
//  self.annunciateView.hidden = YES;
  
    if ([UserInfoManager getUserType] == 0) {//游客
        self.vip.hidden = NO;
        self.btnViews.hidden = NO;
        self.line.hidden = YES;
       // self.tipView.y = 110;
        if (enable) {
            self.annunciateView.hidden = NO;
           // self.tipView.y = 199;
        }
    }
    if ([UserInfoManager getUserType] == 2) {//资源方  需要隐藏vip提示 4个新增按钮 购买方和游客可以显示
        self.vip.hidden = YES;
        self.btnViews.hidden = YES;
        self.line.hidden = YES;
        self.annunciateView.y = 110;
      //  self.tipView.y = 110;
        if (enable) {
            self.annunciateView.hidden = NO;
            self.tipView.y = 199;
        }
    }
    if ([UserInfoManager getUserType] == 1) {//买方
        
        NSInteger status = [UserInfoManager getUserStatus];
      
        if (status>200) {
            self.vip.hidden = YES;
            self.tipView.y = 180;
        }else{
            self.vip.hidden = NO;
            self.vip.y = 180;
            self.tipView.y = 235;
        }
      //  if (enable) {
            self.annunciateView.hidden = YES;
//            self.tipView.y = 235;
      //  }
    }
    self.headerHeight = _tipView.bottom;
}

-(void)clickType:(UITapGestureRecognizer*)tap
{
    if (self.clickTypeBlock) {
        self.clickTypeBlock(tap.view.tag-100);
    }
}

- (IBAction)adverAction:(id)sender {
      self.clickTypeBlock(0);
}

- (IBAction)movieAction:(id)sender {
      self.clickTypeBlock(1);
}

- (IBAction)foreignModel:(id)sender {
     self.clickTypeBlock(2);
}

- (IBAction)massesAction:(id)sender {
     self.clickTypeBlock(3);
}


- (IBAction)testAction:(id)sender {
     self.clickTypeBlock(10);
}

- (IBAction)insuranceAction:(id)sender {
     self.clickTypeBlock(11);
}

- (IBAction)storeAction:(id)sender {
     self.clickTypeBlock(12);
}

- (IBAction)guideAction:(id)sender {
     self.clickTypeBlock(13);
}
- (IBAction)vipAction:(id)sender {
     self.clickTypeBlock(14);
}
//查看通告
- (IBAction)checkAnnunciate:(id)sender {
      self.clickTypeBlock(20);
}
@end

//
//@interface HomeHeadSubCell ()
//@property(nonatomic,strong)UIImageView *icon;
//@property(nonatomic,strong)UILabel *name;
//
//@end
//
//@implementation HomeHeadSubCell
//
//-(UIImageView*)icon
//{
//    if (!_icon) {
//        _icon=[[UIImageView alloc]init];
//        [self addSubview:_icon];
//        _icon.contentMode=UIViewContentModeScaleAspectFill;
//        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self);
//            make.centerY.mas_equalTo(self).offset(-10);
//        }];
//
//    }
//    return _icon;
//}
//
//-(UILabel*)name
//{
//    if (!_name) {
//        _name=[[UILabel alloc]init];
//         [self addSubview:_name];
//        if (_type==1) {
//            _name.font=[UIFont systemFontOfSize:13.0];
//            _name.textColor=[UIColor colorWithHexString:@"333333"];
//        }else{
//        _name.font=[UIFont systemFontOfSize:15.0];
//        _name.textColor=Public_Text_Color;
//        }
//        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self);
//            make.top.mas_equalTo(self.icon.mas_bottom).offset(4);
//        }];
//    }
//    return _name;
//}
//
//-(void)reloadUIWithDic:(NSDictionary*)dic
//{
//    self.icon.image=[UIImage imageNamed:dic[@"image"]];
//    self.name.text=dic[@"title"];
//}
//
//@end
