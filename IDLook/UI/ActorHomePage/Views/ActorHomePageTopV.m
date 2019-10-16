//
//  ActorHomePageTopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/19.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorHomePageTopV.h"
#import "YLVerticalAlignmentLabel.h"
#import "NoVipPopV2.h"
@interface ActorHomePageTopV()
@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *region_daren;
@property (weak, nonatomic) IBOutlet UILabel *community;
@property (weak, nonatomic) IBOutlet UILabel *collection;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UIImageView *agencyLogo;

@property (weak, nonatomic) IBOutlet UIView *fansView;
- (IBAction)fansAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *subFanView2;
@property (weak, nonatomic) IBOutlet UILabel *fan1Account;
@property (weak, nonatomic) IBOutlet UILabel *fan1Count;
@property (weak, nonatomic) IBOutlet UILabel *fan2Account;
@property (weak, nonatomic) IBOutlet UILabel *fan2Count;
@property (weak, nonatomic) IBOutlet UIView *fanBtnCoverView;

@property (weak, nonatomic) IBOutlet UIView *introView;
@property (weak, nonatomic) IBOutlet UILabel *intro1;
//@property (weak, nonatomic) IBOutlet YLVerticalAlignmentLabel *intro2;
@property (weak, nonatomic) IBOutlet YLVerticalAlignmentLabel *intro2;

- (IBAction)introAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *gradeView;
@property (weak, nonatomic) IBOutlet UILabel *gradeCount;
@property (weak, nonatomic) IBOutlet UILabel *gradeName;
@property (weak, nonatomic) IBOutlet UIImageView *gradeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *vipimg;
@property (weak, nonatomic) IBOutlet UILabel *gradeStr;
@property (weak, nonatomic) IBOutlet UILabel *gradeTime;
- (IBAction)checkGrade:(id)sender;


@end
@implementation ActorHomePageTopV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ActorHomePageTopV" owner:nil options:nil] lastObject];
    }
 return self;
}
-(void)setModel:(UserDetialInfoM *)model
{
    _model = model;
     [_backImg sd_setImageWithUrlStr:model.avatar placeholderImage:[UIImage imageNamed:@"masses"]];
    [_userIcon sd_setImageWithUrlStr:model.avatar placeholderImage:[UIImage imageNamed:@"default_icon"]];

    _name.text=model.nickName;
   if (model.sex==1) {
        _sexImg.image=[UIImage imageNamed:@"u_info_man"];
    }
    else if (model.sex==2)
    {
        _sexImg.image=[UIImage imageNamed:@"u_info_woman"];
    }
   
    if (model.region.length>0) {
        self.region_daren.text = [NSString stringWithFormat:@"• %@ • 带货达人",model.region];
    }else{
        self.region_daren.text = @"• 带货达人";
}
    if (model.academy.length>0) {
         self.community.text = [NSString stringWithFormat:@"%@毕业生",model.academy];
    }else{
        self.community.text = @"";
    }
      self.collection.text=  [NSString stringWithFormat:@"%ld收藏  |  %ld点赞",model.collect,model.praise];
    if (!model.agencyOperation) {
        self.agencyLogo.hidden = YES;
    }
//    CGFloat fanLbaelWid = UI_SCREEN_WIDTH/(model.fansInfo.count);
//    for(int i =0;i<model.fansInfo.count;i++){
//        NSString *plat = [model.fansInfo[i] objectForKey:@"name"];
//        float count = [[model.fansInfo[i] objectForKey:@"fansCount"] floatValue];
//        NSString *labelStr = [NSString stringWithFormat:@"%@粉丝%.1fW",plat,count];
//        UILabel *fanLabel = [UILabel new];
//        fanLabel.textColor = [UIColor colorWithHexString:@"ffb200"];
//        fanLabel.font = [UIFont systemFontOfSize:13];
//        fanLabel.textAlignment = NSTextAlignmentCenter;
//        fanLabel.backgroundColor = [UIColor whiteColor];
//        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:labelStr];
//        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,plat.length+2)];
//        fanLabel.attributedText=attStr;
//        CGFloat fx = i*fanLbaelWid;
//        fanLabel.frame = CGRectMake(fx, 0, fanLbaelWid, 43);
//        if (model.fansInfo.count==1) {
//            fanLabel.frame = CGRectMake(16, 0, UI_SCREEN_WIDTH/3, 43);
//            fanLabel.textAlignment = NSTextAlignmentLeft;
//        }
//        [self.fansView addSubview:fanLabel];
//    }
    if (model.fansInfo.count==1) {
        self.subFanView2.hidden = YES;
    }
    if (model.fansInfo.count==0) {
        self.fansView.hidden = YES;
        self.introView.y = self.fansView.y;
    }
    for(int i =0;i<model.fansInfo.count;i++){
        NSDictionary *fanDic = model.fansInfo[i];
        NSString *name = fanDic[@"name"];
        NSString *fansCount = fanDic[@"fansCount"];
        NSString *account = fanDic[@"account"];
        if (i==0) {
            self.fan1Account.text = [NSString stringWithFormat:@"%@账号:%@",name,account];
            self.fan1Count.text = fansCount;
        }else if (i==1){
            self.fan2Account.text = [NSString stringWithFormat:@"%@账号:%@",name,account];
                       self.fan2Count.text = fansCount;
        }
    }
          NSInteger level = [UserInfoManager getUserVip];
          if (level != 301) {//说明非会员
              self.fanBtnCoverView.hidden = YES;
                }
    self.intro1.text=[NSString stringWithFormat:@"身高：%ldcm    体重：%ldkg",model.height,model.weight];
    self.intro2.text = [NSString stringWithFormat:@"代表作品:%@",model.representativeWork.length>0?model.representativeWork:@"暂无"];
    [_intro2 sizeToFit];
    if (model.lastComment!=nil) {
        NSInteger count = [model.commentInfo[@"count"]integerValue];
        self.gradeCount.text = [NSString stringWithFormat:@"评价(%ld)",count];
        NSDictionary *lastGradeDic = model.lastComment;
        NSString *avatar =(NSString*)safeObjectForKey(lastGradeDic, @"avatar");  //头像
        NSString *userName = (NSString*)safeObjectForKey(lastGradeDic, @"userName");  //名称
        NSString *commentDate = (NSString*)safeObjectForKey(lastGradeDic, @"commentDate");  //日期
         NSString *content = (NSString*)safeObjectForKey(lastGradeDic, @"content");  //评价内容
        BOOL isVIP = [lastGradeDic[@"isVIP"]boolValue];  //是否vip
        NSString *tags = (NSString*)safeObjectForKey(lastGradeDic, @"tags");  //标签
       NSInteger performance = [lastGradeDic[@"performance"]integerValue];  //性价比
        NSInteger actingPower = [lastGradeDic[@"actingPower"]integerValue];  //表演力
        NSInteger coordination = [lastGradeDic[@"coordination"]integerValue];  //配合度
        NSInteger favor = [lastGradeDic[@"favor"]integerValue];     //好感度
        [self.gradeIcon sd_setImageWithUrlStr:avatar placeholderImage:[UIImage imageNamed:@"icon_gradeHead"]];
        self.gradeName.text=userName;
        self.vipimg.hidden=!isVIP;
        [self.gradeName sizeToFit];
        self.vipimg.x = _gradeName.right+10;
        self.gradeTime.text=commentDate;
        self.gradeStr.text = content.length>0?content:tags;
      
    }
    _introView.height = _intro2.bottom+15;
    _gradeView.y = _introView.bottom+10;
    _topVHei = _gradeView.bottom+10;
}
- (IBAction)introAction:(id)sender {
    self.introDetail();
}
- (IBAction)checkGrade:(id)sender {
    self.checkGrade();
}
- (IBAction)fansAction:(id)sender {
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist){
        [SVProgressHUD showImage:nil status:@"请先登录"];
            return;
    }
        NSInteger level = [UserInfoManager getUserVip];
      if (level != 301) {
            NoVipPopV2 *pop = [[NoVipPopV2 alloc] init];
            [pop show];
//            pop.apply = ^(NSString * _Nonnull name, NSString * _Nonnull phoneNum, NSString * _Nonnull remrak) {
//                NSInteger f = 6;
//            };
            }
}
@end
