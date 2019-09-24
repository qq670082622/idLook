//
//  ActorHomePageTopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/19.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorHomePageTopV.h"
@interface ActorHomePageTopV()
@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *region_daren;
@property (weak, nonatomic) IBOutlet UILabel *community;
@property (weak, nonatomic) IBOutlet UILabel *collection;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

@property (weak, nonatomic) IBOutlet UIView *fansView;

@property (weak, nonatomic) IBOutlet UIView *introView;
@property (weak, nonatomic) IBOutlet UILabel *intro1;
@property (weak, nonatomic) IBOutlet UILabel *intro2;
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
    CGFloat fanLbaelWid = UI_SCREEN_WIDTH/(model.fansInfo.count);
    for(int i =0;i<model.fansInfo.count;i++){
        NSString *plat = [model.fansInfo[i] objectForKey:@"name"];
        float count = [[model.fansInfo[i] objectForKey:@"fansCount"] floatValue];
        NSString *labelStr = [NSString stringWithFormat:@"%@粉丝%.1fW",plat,count];
        UILabel *fanLabel = [UILabel new];
        fanLabel.textColor = [UIColor colorWithHexString:@"ffb200"];
        fanLabel.font = [UIFont systemFontOfSize:13];
        fanLabel.textAlignment = NSTextAlignmentCenter;
        fanLabel.backgroundColor = [UIColor whiteColor];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:labelStr];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,plat.length+2)];
        fanLabel.attributedText=attStr;
        CGFloat fx = i*fanLbaelWid;
        fanLabel.frame = CGRectMake(fx, 0, fanLbaelWid, 43);
        [self.fansView addSubview:fanLabel];
    }
    self.intro1.text=[NSString stringWithFormat:@"身高：%ldcm    体重：%ldkg",model.height,model.weight];
    self.intro2.text = [NSString stringWithFormat:@"代表作品:%@",model.representativeWork.length>0?model.representativeWork:@"暂无"];
    
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
}
- (IBAction)introAction:(id)sender {
    self.introDetail();
}
- (IBAction)checkGrade:(id)sender {
    self.checkGrade();
}
@end
