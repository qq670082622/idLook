//
//  HomeMainCellD.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeMainCellD.h"
#import "PublicPageControl.h"
#import "WorksModel.h"

@interface HomeMainCellD ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIView *bg;          //背景
@property(nonatomic,strong)UIImageView *icon;   //头像
@property(nonatomic,strong)UIImageView *auth;   //认证
@property(nonatomic,strong)UIImageView *studioIcon;   //工作室

@property(nonatomic,strong)UILabel *name;    //名称
@property(nonatomic,strong)UILabel *infoDetial;   //个人详情

@property(nonatomic,strong)UIButton *lookPriceBtn;  //查看报价
@property(nonatomic,strong) UIButton *reginBtn;  //所在地
@property(nonatomic,strong)UILabel *occupationLab; //职业
@property(nonatomic,strong)UserInfoM *info;
@property(nonatomic,strong)UIScrollView *typeView;
@property(nonatomic,strong)UIScrollView *videoScrollView;

@property(nonatomic,assign)NSInteger cureIndex;
@property(nonatomic,strong)NSMutableArray *showList;
@end

@implementation HomeMainCellD

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self bg];
        [self icon];
        [self auth];
        [self name];
        [self videoScrollView];
        }
    return self;
}

-(NSMutableArray*)showList
{
    if (!_showList) {
        _showList=[NSMutableArray new];
    }
    return _showList;
}

-(UIView*)bg
{
    if (!_bg) {
        _bg = [[UIView alloc] init];
        _bg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bg];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _bg;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.cornerRadius=22;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds=YES;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg).offset(15);
            make.top.mas_equalTo(self.bg).offset(15);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        _icon.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    }
    return _icon;
}

-(UIImageView*)auth//v标志
{
    if (!_auth) {
        _auth=[[UIImageView alloc]init];
        [self.contentView addSubview:_auth];
        _auth.image=[UIImage imageNamed:@"home_auth"];
        _auth.contentMode=UIViewContentModeScaleAspectFill;
        [_auth mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.icon).offset(0);
            make.bottom.mas_equalTo(self.icon).offset(0);
        }];
    }
    return _auth;
}

-(UILabel*)name
{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont systemFontOfSize:15.0];
        _name.textColor=Public_Text_Color;
       [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.top.mas_equalTo(self.bg).offset(20);
        }];
    }
     _name.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    return _name;
}

-(UIImageView*)studioIcon //脸探云工作室
{
    if (!_studioIcon) {
        _studioIcon=[[UIImageView alloc]init];
        [self.contentView addSubview:_studioIcon];
        _studioIcon.image=[UIImage imageNamed:@"home_logo"];
        _studioIcon.contentMode=UIViewContentModeScaleAspectFill;
        [_studioIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.icon).offset(0);
        }];
    }
    return _studioIcon;
}

-(UILabel*)infoDetial
{
    if (!_infoDetial) {
        _infoDetial=[[UILabel alloc]init];
        _infoDetial.font=[UIFont systemFontOfSize:11.0];
        _infoDetial.text=@"个人详情 >";
        _infoDetial.textColor=[UIColor colorWithHexString:@"#ff7e4e"];
        [self.contentView addSubview:_infoDetial];
        [_infoDetial mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.studioIcon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.icon).offset(0);
        }];
    }
    return _infoDetial;
}

-(UIButton*)lookPriceBtn
{
    if (!_lookPriceBtn) {
        _lookPriceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_lookPriceBtn];
//        _lookPriceBtn.backgroundColor=Public_Red_Color;
        _lookPriceBtn.layer.masksToBounds=YES;
        _lookPriceBtn.layer.cornerRadius=12.0;
        _lookPriceBtn.layer.borderColor=[UIColor colorWithHexString:@"#EBEBEB"].CGColor;
        _lookPriceBtn.layer.borderWidth=1.0;
        [_lookPriceBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        _lookPriceBtn.titleLabel.font=[UIFont systemFontOfSize:11.0];
        _lookPriceBtn.imageEdgeInsets=UIEdgeInsetsMake(0,-3,0,3);
        [_lookPriceBtn setTitle:@"查看报价" forState:UIControlStateNormal];
        [_lookPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon);
            make.right.mas_equalTo(self.contentView).offset(-22);
            make.size.mas_equalTo(CGSizeMake(80, 24));
        }];
        [_lookPriceBtn addTarget:self action:@selector(lookUserOfferAction) forControlEvents:UIControlEventTouchUpInside];
        

    }
    return _lookPriceBtn;
}

-(UIButton*)reginBtn//位置+图标
{
    if (!_reginBtn) {
        _reginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_reginBtn];
        [_reginBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
        _reginBtn.titleLabel.font=[UIFont systemFontOfSize:11.0];
        [_reginBtn setImage:[UIImage imageNamed:@"home_postion_gray"] forState:UIControlStateNormal];
        [_reginBtn setImage:[UIImage imageNamed:@"home_postion_gray"] forState:UIControlStateHighlighted];
        [_reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.occupationLab.mas_right).offset(10);
            make.centerY.mas_equalTo(self.name);
        }];
        _reginBtn.enabled=NO;
        
        //粗体
        if (IsBoldSize()) {
            _reginBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 7);
        }
    }
    return _reginBtn;
}

-(UILabel*)occupationLab//广告演员
{
    if (!_occupationLab) {
        _occupationLab=[[UILabel alloc]init];
        [self.contentView addSubview:_occupationLab];
        _occupationLab.layer.masksToBounds=YES;
        _occupationLab.layer.cornerRadius=9.0;
        _occupationLab.textAlignment=NSTextAlignmentCenter;
        _occupationLab.backgroundColor=[[UIColor colorWithHexString:@"#FF2C54"]colorWithAlphaComponent:0.1];
        _occupationLab.textColor =[UIColor colorWithHexString:@"#FF2C54"];
        _occupationLab.font=[UIFont systemFontOfSize:11.0];
        [_occupationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.name.mas_right).offset(5);
            make.centerY.mas_equalTo(self.name);
            make.size.mas_equalTo(CGSizeMake(70, 18));
        }];
    }
    return _occupationLab;
}

-(UIScrollView*)typeView//标签滑动
{
    if (!_typeView) {
        _typeView=[[UIScrollView alloc]init];
//        _typeView.userInteractionEnabled=YES;
        _typeView.showsVerticalScrollIndicator=NO;
        _typeView.showsHorizontalScrollIndicator=NO;
        [_typeView setTag:444];
        [self.contentView addSubview:_typeView];
        [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg);
            make.right.mas_equalTo(self.bg);
            make.bottom.mas_equalTo(self.videoScrollView.mas_top);
            make.top.mas_equalTo(self.icon.mas_bottom);
        }];
    }
    _typeView.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    return _typeView;
}

-(UIScrollView *)videoScrollView
{
    if (!_videoScrollView) {
        self.videoScrollView =  [[UIScrollView alloc]init];
        //        _typeView.userInteractionEnabled=YES;
        _videoScrollView.showsVerticalScrollIndicator=NO;
        _videoScrollView.showsHorizontalScrollIndicator=NO;
        _videoScrollView.backgroundColor = [UIColor whiteColor];
        _videoScrollView.delegate = self;
        _videoScrollView.pagingEnabled = YES;
        [_videoScrollView setTag:555];
        [self.contentView addSubview:_videoScrollView];
        _videoScrollView.frame = CGRectMake(0, 108, UI_SCREEN_WIDTH, 193);
        _videoScrollView.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    }
    return _videoScrollView;
}

-(void)reloadUIWithModel:(UserInfoM *)model withSelect:(NSString*)select
{
    self.cureIndex=0;
    self.info=model;
    self.showList = [NSMutableArray arrayWithArray:self.info.showlist];
    
    //将值放到第一个
    for (int i=0; i<self.showList.count; i++) {
        NSDictionary *dic = self.showList[i];
        if ([dic[@"catename"] isEqualToString:select]) {
            [self.showList removeObjectAtIndex:i];
            [self.showList insertObject:dic atIndex:0];
            break;
        }
    }

    self.info.showlist = self.showList;
    
    [self bg];
    [self.icon sd_setImageWithUrlStr:model.head placeholderImage:[UIImage imageNamed:@"default_home"]];
    
    if (model.studio==1) {
        self.studioIcon.hidden=NO;
        [self.infoDetial mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.studioIcon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.icon).offset(0);
        }];
    }
    else
    {
        self.studioIcon.hidden=YES;
        [self.infoDetial mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.icon).offset(0);
        }];
    }
    
    [self infoDetial];
    
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist || [UserInfoManager getUserAuthState]!=1) {
        [self.lookPriceBtn setImage:[UIImage imageNamed:@"home_lock"] forState:UIControlStateNormal];
        self.lookPriceBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 3, 0, -3);
    }
    else
    {
        [self.lookPriceBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    if ([UserInfoManager getUserType]==UserTypeResourcer)
    {
        self.lookPriceBtn.hidden=YES;
    }
    else
    {
        self.lookPriceBtn.hidden=NO;
    }
    
    self.reginBtn.hidden=model.region.length>0?NO:YES;
    [self.reginBtn setTitle:model.region forState:UIControlStateNormal];
    
    self.occupationLab.hidden=model.mastery>0?NO:YES;
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"masteryType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if (model.mastery == [dic[@"attrid"] integerValue]) {
            self.occupationLab.text = dic[@"attrname"];
        }
    }
    
    
    NSString *sex = @"";
    if (model.sex==1) {
        sex=@"/男";
    }
    else if (model.sex==2)
    {
        sex=@"/女";
    }
    else
    {
        sex=@"  ";
    }
    
    NSString *str=[NSString stringWithFormat:@"%@%@",model.nick.length>0?model.nick:model.name,sex];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} range:NSMakeRange(str.length-2,2)];
    self.name.attributedText=attStr;
    
    for (UIView *view in self.typeView.subviews) {
        [view removeFromSuperview];
    }
   
  
    _videoScrollView.contentSize = CGSizeMake(self.showList.count*UI_SCREEN_WIDTH, _videoScrollView.height);
    _videoScrollView.contentOffset = CGPointMake(0, 0);
    _videoScrollView.scrollEnabled = YES;
    _videoScrollView.userInteractionEnabled = YES;
    for(UIView *scroll in [self.contentView subviews]){
        if ([scroll isKindOfClass:[UIScrollView class]] && scroll.tag != 555 && scroll.tag != 444) {
            [scroll removeFromSuperview];
        }
    }
    for(UIView *view in [self.videoScrollView subviews]){
        [view removeFromSuperview];
    }

    self.typeView.contentSize=CGSizeMake(88*self.showList.count+12, 0);
    self.typeView.contentOffset=CGPointMake(0, 0);

    UIImage *image = [UIImage imageNamed:@"home_type_n"];
    for (int i =0; i<self.showList.count;i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.typeView addSubview:btn];
        btn.tag=1000+i;
        btn.frame=CGRectMake(10+image.size.width*i,0,image.size.width,image.size.height);
        [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [btn setBackgroundImage:[UIImage imageNamed:@"home_type_n"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"home_type_h"] forState:UIControlStateSelected];
        [btn setTitle:self.showList[i][@"catename"] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(-2, 0, 0, 0)];
        [btn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            btn.selected=YES;
            self.typeContent = btn.titleLabel.text;
        }
        
        WorksModel *workModel = [self getVideoImageWithIndex:i];
        HomeMainSubV *subV = [[HomeMainSubV alloc]initWithFrame:CGRectMake((15)*(i+1) + i*(UI_SCREEN_WIDTH-30) + 15*i,0,UI_SCREEN_WIDTH-30,_videoScrollView.height)];
        [self.videoScrollView addSubview:subV];
        [subV setTag:4000+i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickVideoTap:)];
        [subV addGestureRecognizer:tap];
        [subV reloadUIWithModel:workModel];
    }
    _videoScrollView.contentSize = CGSizeMake(self.showList.count*UI_SCREEN_WIDTH, _videoScrollView.height);
}

//查看用户主页
-(void)clickUserHead
{
    if (self.clickUserInfo) {
        self.clickUserInfo();
    }
}

//查看报价
-(void)lookUserOfferAction
{
    if (self.lookUserOffer) {
        self.lookUserOffer();
    }
}

//播放视频  icon点击
-(void)clickVideoTap:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    
    _cureIndex = tap.view.tag-4000;
    if (self.showList.count==0) {
        return;
    }
    
    WorksModel *workModel = [self getVideoImageWithIndex:self.cureIndex];
    if (self.playVideWithUrl) {
        self.playVideWithUrl(workModel,_cureIndex);
    }
}

//btn点击
-(void)typeClick:(UIButton*)sender
{
    self.typeContent = sender.titleLabel.text;
    
    self.cureIndex=sender.tag-1000;
    for (int i =0; i<self.showList.count; i++) {
        UIButton *btn = [self.typeView viewWithTag:1000+i];
        if (i==sender.tag-1000) {
            btn.selected=YES;
        }
        else
        {
            btn.selected=NO;
        }
    }
    WorksModel *workModel = [self getVideoImageWithIndex:self.cureIndex];

    [UIView animateWithDuration:0.3 animations:^{
        self.videoScrollView.contentOffset = CGPointMake(_cureIndex*UI_SCREEN_WIDTH, 0);
    }];

    if (self.playVideWithUrl) {
        self.playVideWithUrl(workModel,_cureIndex);
    }
}

//等到showlist数据
-(WorksModel*)getVideoImageWithIndex:(NSInteger)index
{
    NSDictionary *list = self.showList[index][@"lists"];
    NSArray *talent = (NSArray*)safeObjectForKey(list, @"talent");
    NSArray *pastwork = (NSArray*)safeObjectForKey(list, @"pastwork");
    NSArray *modelcard = (NSArray*)safeObjectForKey(list, @"modelcard");
    
    WorksModel *model = [[WorksModel alloc]init];
    
    if (talent.count>0) {
        model = [[WorksModel alloc]initWithWorksDic:[talent firstObject]];
        model.workType=WorkTypePerformance;
    }
    else if (pastwork.count>0)
    {
        model = [[WorksModel alloc]initWithPastWorkDic:[pastwork firstObject]];
        model.workType=WorkTypePastworks;
    }
    else if (modelcard.count>0)
    {
        model = [[WorksModel alloc]initModelCardDic:[modelcard firstObject]];
        model.workType=WorkTypeIntroduction;

    }
    return model;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offX = scrollView.contentOffset.x;
    NSInteger page = offX/UI_SCREEN_WIDTH;
    if (_cureIndex == page) {
        return;
    }
//    if (page - _cureIndex > 1) {
//        _cureIndex++;
//        scrollView.contentOffset = CGPointMake(_cureIndex*UI_SCREEN_WIDTH, 0);
//        page = _cureIndex;
//    }else{
//          _cureIndex = page;
//    }
    _cureIndex = page;
    scrollView.contentOffset = CGPointMake(_cureIndex*UI_SCREEN_WIDTH, 0);
    if (page>3 && page<=8) {
        [UIView animateWithDuration:0.3 animations:^{
           self.typeView.contentOffset = CGPointMake(UI_SCREEN_WIDTH, 0);
        }];
}
    if (page>8) {
        [UIView animateWithDuration:0.3 animations:^{
            self.typeView.contentOffset = CGPointMake(2*UI_SCREEN_WIDTH, 0);
        }];
    }
    if (page<4 &&self.typeView.contentOffset.x>0) {
        [UIView animateWithDuration:0.3 animations:^{
           self.typeView.contentOffset = CGPointMake(0, 0);
        }];
       
    }
 
    for(int i = 0;i<_showList.count;i++){
        UIButton *btn = [self.typeView viewWithTag:(i+1000)];
        if (page==i) {//选中h该按钮，置灰其他按钮
            btn.selected = YES;
            //            self.typeContent = btn.titleLabel.text;
            //            self.cureIndex = page;
            //[self typeClick:btn];
        }else{
            btn.selected = NO;
        }
    }
    WorksModel *workModel = [self getVideoImageWithIndex:self.cureIndex];
    
    if (self.playVideWithUrl) {
        self.playVideWithUrl(workModel,_cureIndex);
    }
}

@end


@interface HomeMainSubV ()
@property(nonatomic,strong)UIImageView *videoIcon;
@property(nonatomic,strong)UIButton *timeBtn;
@property(nonatomic,strong)UILabel *totalLab;    //
@end

@implementation HomeMainSubV

-(UIImageView*)videoIcon
{
    if (!_videoIcon) {
        _videoIcon=[[UIImageView alloc]init];
        [self addSubview:_videoIcon];
        _videoIcon.userInteractionEnabled=YES;
        _videoIcon.contentMode=UIViewContentModeScaleAspectFill;
        _videoIcon.clipsToBounds=YES;
        _videoIcon.layer.masksToBounds=YES;
        _videoIcon.layer.cornerRadius=5.0;
        [_videoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
    }
    return _videoIcon;
}

-(UILabel*)totalLab
{
    if (!_totalLab) {
        _totalLab=[[UILabel alloc]init];
        _totalLab.font=[UIFont systemFontOfSize:12.0];
        _totalLab.textColor=[UIColor whiteColor];
        [self addSubview:_totalLab];
        [_totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.videoIcon).offset(15);
            make.bottom.mas_equalTo(self.videoIcon).offset(-10);
        }];
    }
    return _totalLab;
}

-(UIButton*)timeBtn
{
    if (!_timeBtn) {
        _timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_timeBtn];
        _timeBtn.layer.masksToBounds=YES;
        _timeBtn.layer.cornerRadius=9;
        _timeBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
        _timeBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeBtn setImage:[UIImage imageNamed:@"u_video_s"] forState:UIControlStateNormal];
        [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.videoIcon.mas_right).offset(-10);
            make.bottom.mas_equalTo(self.videoIcon).offset(-10);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}

-(void)reloadUIWithModel:(WorksModel *)model
{
    [self.videoIcon sd_setImageWithUrlStr:model.cutvideo placeholderImage:[UIImage imageNamed:@"default_video"]];
    [self.timeBtn setTitle:model.timevideo forState:UIControlStateNormal];
//    self.totalLab.text=[NSString stringWithFormat:@"893次观看  |  15次下载"];
}

@end
