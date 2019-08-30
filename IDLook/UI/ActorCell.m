//
//  ActorCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ActorCell.h"
#import "ActorVideoView.h"
#import "ActorVideoViewModel.h"
#import "AskPriceView.h"
#import "WriteFileManager.h"
@interface ActorCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *sexIcon;
@property (weak, nonatomic) IBOutlet UILabel *region;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *collection_Prise;
@property (weak, nonatomic) IBOutlet UIImageView *authLogo;
@property (weak, nonatomic) IBOutlet UIScrollView *typeScroll;
@property (weak, nonatomic) IBOutlet UIScrollView *videoScroll;
@property(nonatomic,assign)NSInteger cureIndex;
@property(nonatomic,strong)NSMutableArray *showList;
@property (weak, nonatomic) IBOutlet UIButton *authBtn;
@property (weak, nonatomic) IBOutlet UIView *vipView;
@property (weak, nonatomic) IBOutlet UILabel *vipPrice;
@property (weak, nonatomic) IBOutlet UILabel *normalPrice;
@property (weak, nonatomic) IBOutlet UIView *offLine;

- (IBAction)authAction:(id)sender;

//装值，resetUI，typescroll逻辑，videoscroll逻辑
@end
@implementation ActorCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"ActorCell";
    ActorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActorCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.icon.layer.cornerRadius=27;
     cell.icon.layer.masksToBounds=YES;
     cell.icon.contentMode=UIViewContentModeScaleAspectFill;
     cell.icon.clipsToBounds=YES;
    
    cell.typeScroll.showsVerticalScrollIndicator=NO;
    cell.typeScroll.showsHorizontalScrollIndicator=NO;
    [cell.typeScroll setTag:444];
    
     cell.videoScroll.showsVerticalScrollIndicator=NO;
     cell.videoScroll.showsHorizontalScrollIndicator=NO;
     cell.videoScroll.delegate = cell;
     cell.videoScroll.pagingEnabled = YES;
    [cell.videoScroll setTag:555];
    
   
    
    return cell;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
  
}
-(void)setModel:(UserModel *)model
{
    WeakSelf(self);
    _model = model;
  //  model.startPrice = 0;
    
   [self.icon sd_setImageWithUrlStr:model.actorHeadMini placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.name.text = model.nickName;
 if (model.sex==1) {//男
        self.sexIcon.image = [UIImage imageNamed:@"icon_male"];
    }else{
         self.sexIcon.image = [UIImage imageNamed:@"icon_female"];
    }
    self.region.text = [NSString stringWithFormat:@"• %@",model.region];
    NSInteger typeL = [UserInfoManager getUserType];
    NSInteger authState = [UserInfoManager getUserAuthState_wm];
   
    if ([UserInfoManager getUserType] == 1 && [UserInfoManager getUserAuthState_wm]==1) {
        if (model.startPrice==0) {
             self.authBtn.hidden = NO;
             self.vipView.hidden = YES;
            self.price.textColor = [UIColor clearColor];
            [self.authBtn setTitle:@"咨询价格" forState:0];//认证提示提示
        }else{
         self.authBtn.hidden = YES;
        }
    }
    NSInteger status = 201;//[UserInfoManager getUserStatus];
    if (status>200 &&model.startPrice!=0) {
        self.vipView.hidden = NO;
        self.vipPrice.text = [NSString stringWithFormat:@"¥ %ld起/天",model.startPriceVip];;
        self.normalPrice.text = [NSString stringWithFormat:@"¥ %ld/天",model.startPrice];
        [self.vipPrice sizeToFit];
        [self.normalPrice sizeToFit];
        self.vipPrice.frame = CGRectMake(33, 0, _vipPrice.width, 29);
        self.normalPrice.frame =  CGRectMake(_vipPrice.right+6,0,_normalPrice.width,29);
        self.offLine.x = _normalPrice.x-3;
        self.offLine.width = _normalPrice.width+6;
    }else{
        self.vipView.hidden = YES;
    }
    if ( [UserInfoManager getUserType] == 2) {//资源方  需要隐藏价格
        self.price.textColor = [UIColor clearColor];//资源方隐藏
        self.authBtn.hidden = YES;
        self.vipView.hidden = YES;
    }
    if ([UserInfoManager getUserAuthState_wm]!=1 &&  [UserInfoManager getUserLoginType] != UserLoginTypeTourist) {
     //   [self.authBtn setTitle:@"认证后查看报价" forState:0];//认证提示提示
        [self.authBtn setTitle:@"查看价格" forState:0];
        self.price.textColor = [UIColor clearColor];
         self.vipView.hidden = YES;
    }
    
    if( [UserInfoManager getUserLoginType] == UserLoginTypeTourist){
        [self.authBtn setTitle:@"登录后查看报价" forState:0];//游客提示
        self.price.textColor = [UIColor clearColor];
        self.vipView.hidden = YES;
    }
   
  
    self.price.text = [NSString stringWithFormat:@"¥ %ld/天",model.startPrice];
   
  
    self.collection_Prise.text = [NSString stringWithFormat:@"%ld收藏 | %ld点赞",model.collect,model.praise];
    
    if (model.actorStudio!=1) {
        self.authLogo.hidden = YES;
    }
    self.showList = [NSMutableArray arrayWithArray:model.showList];
    
    self.name.width = 18*model.nickName.length;
    self.sexIcon.x = self.name.x + self.name.width +7;
    self.region.x = self.sexIcon.x+23;
    
    _videoScroll.contentSize = CGSizeMake(self.showList.count*UI_SCREEN_WIDTH, _videoScroll.height);
    _videoScroll.contentOffset = CGPointMake(0, 0);
    _videoScroll.scrollEnabled = YES;
    _videoScroll.userInteractionEnabled = YES;
//    for(UIView *scroll in [self.contentView subviews]){
//        if ([scroll isKindOfClass:[UIScrollView class]] && scroll.tag != 555 && scroll.tag != 444) {
//            [scroll removeFromSuperview];
//        }
//    }
//    for(UIView *view in [self.videoScroll subviews]){
//        [view removeFromSuperview];
//    }
//
    self.typeScroll.contentSize=CGSizeMake(88*self.showList.count+12, 0);
    self.typeScroll.contentOffset=CGPointMake(0, 0);
    _videoScroll.contentSize = CGSizeMake(self.showList.count*UI_SCREEN_WIDTH, _videoScroll.height);
    for (int i =0; i<self.showList.count;i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.typeScroll addSubview:btn];
        btn.tag=1000+i;
        btn.frame=CGRectMake(10+59*i,7,59,28);//28 10 13
        [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#464646"] forState:UIControlStateSelected];
       
        btn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [btn setBackgroundImage:[[UIImage alloc]init] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"button_garyback"] forState:UIControlStateSelected];
        [btn setTitle:self.showList[i][@"cateName"] forState:UIControlStateNormal];
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(-2, 0, 0, 0)];
        [btn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            btn.selected=YES;
            self.typeContent = btn.titleLabel.text;
        }
        
        if (i == 0) {
            ActorVideoView *videoView = [[ActorVideoView alloc]initWithFrame:CGRectMake(i*UI_SCREEN_WIDTH,0,UI_SCREEN_WIDTH,_videoScroll.height)];
            videoView.x = i*UI_SCREEN_WIDTH;
            videoView.y = 0;
            videoView.width = UI_SCREEN_WIDTH;
            videoView.height = _videoScroll.height;
            // NSLog(@"i = %d frame is %@",i,NSStringFromCGRect(videoView.frame));
            [videoView setTag:4000+i];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickVideoTap:)];
            [videoView addGestureRecognizer:tap];
            NSDictionary *videoDic = self.showList[i];
            videoView.videoViewModel = [ActorVideoViewModel yy_modelWithDictionary:videoDic];
            [_videoScroll addSubview:videoView];
            WorksModel *workModel = [self getVideoImageWithIndex:self.cureIndex];
            videoView.workModel = workModel;
            videoView.index = _cureIndex;
            videoView.playVideo = ^(WorksModel * _Nonnull work, NSInteger index) {
                long timeNow = (long)[[NSDate date] timeIntervalSince1970];
                [UserInfoManager setLastestVideoPlayTime:timeNow];
                weakself.playVideWithUrl(work,index);
            };
            videoView.lookPicture = ^(WorksModel * _Nonnull work, NSInteger index) {
                weakself.lookPicture(work, index);
            };
        }
     }
    if(_index_row==0 || _index_row==1){
        [self reloadOtherVideoViews];
    }
    
   
}
-(void)reloadOtherVideoViews
{
  
    NSArray *subviews = _videoScroll.subviews;
    NSInteger count=0;
    for(id sub in subviews) {
        if ([sub isKindOfClass:[ActorVideoView class]]) {
            count++;
        }
    }
    if (count>1) {//避免重复加载
      return;
    }
    for(int i = 1;i<self.showList.count;i++){
        ActorVideoView *videoView = [[ActorVideoView alloc]initWithFrame:CGRectMake(i*UI_SCREEN_WIDTH,0,UI_SCREEN_WIDTH,_videoScroll.height)];
        videoView.x = i*UI_SCREEN_WIDTH;
        videoView.y = 0;
        videoView.width = UI_SCREEN_WIDTH;
        videoView.height = _videoScroll.height;
        // NSLog(@"i = %d frame is %@",i,NSStringFromCGRect(videoView.frame));
        [videoView setTag:4000+i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickVideoTap:)];
        [videoView addGestureRecognizer:tap];
        NSDictionary *videoDic = self.showList[i];
        videoView.videoViewModel = [ActorVideoViewModel yy_modelWithDictionary:videoDic];
        [_videoScroll addSubview:videoView];
        WorksModel *workModel = [self getVideoImageWithIndex:self.cureIndex];
        videoView.workModel = workModel;
        videoView.index = _cureIndex;
        WeakSelf(self);
        videoView.playVideo = ^(WorksModel * _Nonnull work, NSInteger index) {
            long timeNow = (long)[[NSDate date] timeIntervalSince1970];
            [UserInfoManager setLastestVideoPlayTime:timeNow];
            weakself.playVideWithUrl(work,index);
        };
        videoView.lookPicture = ^(WorksModel * _Nonnull work, NSInteger index) {
            weakself.lookPicture(work, index);
        };
    }
}
//btn点击
-(void)typeClick:(UIButton*)sender
{
    self.typeContent = sender.titleLabel.text;
    
    self.cureIndex=sender.tag-1000;
    for (int i =0; i<self.showList.count; i++) {
        UIButton *btn = [self.typeScroll viewWithTag:1000+i];
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
        self.videoScroll.contentOffset = CGPointMake(_cureIndex*UI_SCREEN_WIDTH, 0);
    }];
    if (workModel.video.length<2) {
      //  self.lookPicture(workModel, _cureIndex);
    }else{
    if (self.playVideWithUrl && [UserInfoManager getWifiAuthPlay]) {
#warning -- 自动播放处
        long timeNow = (long)[[NSDate date] timeIntervalSince1970];
        long timeBefore = [UserInfoManager getLastedVideoPlayTime];
        if ((timeNow - timeBefore)>videoPlayMergin) {
             self.playVideWithUrl(workModel,_cureIndex);
            [UserInfoManager setLastestVideoPlayTime:timeNow];
        }
       }
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
   
    if (workModel.video.length<2) {
         self.lookPicture(workModel, _cureIndex);
    }else{
        if (self.playVideWithUrl ) {
             long timeNow = (long)[[NSDate date] timeIntervalSince1970];
            [UserInfoManager setLastestVideoPlayTime:timeNow];
            self.playVideWithUrl(workModel,_cureIndex);
        }
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offX = scrollView.contentOffset.x;
    NSInteger page = offX/UI_SCREEN_WIDTH;
    if (_cureIndex == page) {
        return;
    }
    _cureIndex = page;
   
    scrollView.contentOffset = CGPointMake(_cureIndex*UI_SCREEN_WIDTH, 0);
    if (page>6 && page<=12) {
        [UIView animateWithDuration:0.3 animations:^{
            self.typeScroll.contentOffset = CGPointMake(UI_SCREEN_WIDTH, 0);
        }];
    }
    if (page>12) {
        [UIView animateWithDuration:0.3 animations:^{
            self.typeScroll.contentOffset = CGPointMake(2*UI_SCREEN_WIDTH, 0);
        }];
    }
    if (page<7 &&self.typeScroll.contentOffset.x>0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.typeScroll.contentOffset = CGPointMake(0, 0);
        }];

    }
    
    for(int i = 0;i<_showList.count;i++){
        UIButton *btn = [self.typeScroll viewWithTag:(i+1000)];
        if (page==i) {//选中h该按钮，置灰其他按钮
            btn.selected = YES;
            
        }else{
            btn.selected = NO;
        }
    }
    WorksModel *workModel = [self getVideoImageWithIndex:self.cureIndex];
    #warning -- 自动播放处
    if (workModel.video.length<2) {
       // self.lookPicture(workModel, _cureIndex);
    }else{
        if (self.playVideWithUrl && [UserInfoManager getWifiAuthPlay]) {
            long timeNow = (long)[[NSDate date] timeIntervalSince1970];
            long timeBefore = [UserInfoManager getLastedVideoPlayTime];
            if ((timeNow - timeBefore)>videoPlayMergin) {
                self.playVideWithUrl(workModel,_cureIndex);
                [UserInfoManager setLastestVideoPlayTime:timeNow];
            }
    }
    }
}

//等到showlist数据
-(WorksModel*)getVideoImageWithIndex:(NSInteger)index
{
    NSDictionary *dic = self.showList[index];
    ActorVideoViewModel *videoModel = [ActorVideoViewModel yy_modelWithDictionary:dic];
    WorksModel *model = [[WorksModel alloc]init];
    model.workType = videoModel.vtype;
    model.creativeid = [NSString stringWithFormat:@"%d",videoModel.id];
    model.video = videoModel.videoUrl;
    model.cutvideo = videoModel.cutVideo;
    return model;
}
-(NSMutableArray*)showList
{
    if (!_showList) {
        _showList=[NSMutableArray new];
    }
    return _showList;
}
- (void)awakeFromNib {
    [super awakeFromNib];

    UILabel *view1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 64, 64)];
    UILabel *view2 = [[UILabel alloc] initWithFrame:CGRectMake(81, 20, 150, 23)];
     UILabel *view3 = [[UILabel alloc] initWithFrame:CGRectMake(81, 48, UI_SCREEN_WIDTH-81, 23)];
     UILabel *view4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 77, UI_SCREEN_WIDTH, 230)];
        [self.contentView addSubview:view1];
        [self.contentView addSubview:view2];
        [self.contentView addSubview:view3];
        [self.contentView addSubview:view4];
        view1.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        view2.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        view3.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        view4.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)authAction:(id)sender {
  
    if ([UserInfoManager getUserAuthState_wm]!=1) {
//        [SVProgressHUD showImage:nil status:@"认证后可查看报价！"];
//        弹窗
        }
    if( [UserInfoManager getUserLoginType] == UserLoginTypeTourist){
        [SVProgressHUD showImage:nil status:@"登录后可查看报价！"];
    }
    if ([_authBtn.titleLabel.text isEqualToString:@"咨询价格"]){
        AskPriceView *ap  = [[AskPriceView alloc] init];
        [ap showWithTitle:@"咨询价格" desc:@"此演员价格受拍摄日期，脚本影响较大，无固定价格。具体价格请拨打400-833-6969咨询脸探副导。" leftBtn:@"" rightBtn:@"" phoneNum:@"4008336969"];
    }
}
@end



