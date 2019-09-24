//
//  VideoPlayer.m
//  VideoPlayer
//
//  Created by Shelin on 16/3/23.
//  Copyright © 2016年 GreatGate. All rights reserved.
//  https://github.com/ShelinShelin
//  博客：http://www.jianshu.com/users/edad244257e2/latest_articles

#import "VideoPlayer.h"
#import "XLSlider.h"
#import "DownLoadmanager.h"
#import "VIMediaCache.h"
#import <CoreMotion/CoreMotion.h>//锁定竖直状态下仍能获得设备是水平还是横向
static CGFloat const barAnimateSpeed = 0.5f;
static CGFloat const barShowDuration = 5.0f;
static CGFloat const opacity = 0.7f;
static CGFloat const bottomBaHeight = 40.0f;
static CGFloat const playBtnSideLength = 60.0f;

@interface VideoPlayer ()

/**videoPlayer superView*/
@property (nonatomic, strong) UIView *playSuprView;
@property (nonatomic, strong) UIView *bottomBar;         //底部view
@property (nonatomic, strong) UIButton *playOrPauseBtn;    // 播放，暂停按钮
@property (nonatomic, strong) UIButton *backBtn;          //返回按钮
@property (nonatomic, strong) UIButton *downloadBtn;          //下载按钮
@property (nonatomic, strong) UIButton *voiceBtn;          //静音按钮

@property (nonatomic, strong) UILabel *totalDurationLabel;  //总时长
@property (nonatomic, strong) UILabel *progressLabel;       //当前播放时间
@property (nonatomic, strong) XLSlider *slider;          //进度滑块
@property (nonatomic, strong) UIWindow *keyWindow;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;   //加载视图
@property (nonatomic, assign) CGRect playerOriginalFrame;
@property (nonatomic, strong) UIButton *zoomScreenBtn;            //全屏，小屏按钮

@property (nonatomic, strong) AVPlayerItem *playerItem;


/**video total duration*/
@property (nonatomic, assign) CGFloat totalDuration;
@property (nonatomic, assign) CGFloat current;

@property (nonatomic, strong) UITableView *bindTableView;
@property (nonatomic, assign) CGRect currentPlayCellRect;


@property (nonatomic, assign) BOOL isOriginalFrame;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL barHiden;
@property (nonatomic, assign) BOOL inOperation;
@property (nonatomic, assign) BOOL smallWinPlaying;
@property (nonatomic, assign) BOOL landscapeHold;//是否横向持握设备，不是指画面横向了
@property (nonatomic, strong) VIResourceLoaderManager *resourceLoaderManager;
@property(nonatomic,strong) UIView *coverView;
//硬件加速计 监听设备是否横向
@property(nonatomic,strong)CMMotionManager  *cmmotionManager;
@end

@implementation VideoPlayer

#pragma mark - public method

- (instancetype)init {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.keyWindow = [UIApplication sharedApplication].keyWindow;

        //screen orientation change
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
        
        //show or hiden gestureRecognizer
        UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHidenBar)];
        tapOnce.numberOfTapsRequired = 1;
        tapOnce.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapOnce];
        
        //点击两次，全屏或者小屏播放
//        UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionFullScreen)];
//        tapTwice.numberOfTapsRequired = 2;
//        tapTwice.numberOfTouchesRequired = 1;
//        [self addGestureRecognizer:tapTwice];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appwillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        self.barHiden = YES;
        
        CMMotionManager *motionManager = [[CMMotionManager alloc] init];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        WeakSelf(self);
        // 加速计
        if(motionManager.accelerometerAvailable){
            motionManager.accelerometerUpdateInterval = 1;
            self.cmmotionManager = motionManager;
            [_cmmotionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
                NSLog(@"x is %f ////y is %f",accelerometerData.acceleration.x,accelerometerData.acceleration.y);
                if (error) {
                    [weakself.cmmotionManager stopGyroUpdates];
                }else{//if (accelerometerData.acceleration.x>=0.75 || accelerometerData.acceleration.x<=-0.75
                    if (accelerometerData.acceleration.y>=-0.5) {//说明横屏持握了
                        
                        if (weakself.isFullScreen && weakself.landscapeHold==NO) {//全屏模式下，如果手持方向变为横向，则改变旋转UI
                            dispatch_async(dispatch_get_main_queue(), ^{
                                 [weakself orientationLeftFullScreen];
                                 weakself.landscapeHold = YES;
                            });
                          
                        }
                    }else  if ( accelerometerData.acceleration.y<=-0.5){
                        
                        if (weakself.isFullScreen && weakself.landscapeHold==YES) {//全屏模式下，如果手持方向变为竖向，则改变旋转UI
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakself orientationVerticalFullScreen];
                                 weakself.landscapeHold = NO;
                            });
                            
                        }
                    }
                }
            }];
            }else{
                NSLog(@"This device has no accelerometer");
            }
      }
    return self;
}

- (void)setVideoUrl:(NSString *)videoUrl {
    _videoUrl = videoUrl;
    
    NSURL *url = [NSURL URLWithString:videoUrl];
    
    VIResourceLoaderManager *resourceLoaderManager = [VIResourceLoaderManager new];
    self.resourceLoaderManager = resourceLoaderManager;
    
    AVPlayerItem *playerItem = [resourceLoaderManager playerItemWithURL:url];
    self.playerItem = playerItem;
    
    VICacheConfiguration *configuration = [VICacheManager cacheConfigurationForURL:url];
    if (configuration.progress >= 1.0) {
        NSLog(@"cache completed");
    }
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player = player;
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.layer addSublayer:self.playerLayer];
    
    [self addProgressObserver];
    
    [self addObserverToPlayerItem:playerItem];
    
    [self.activityIndicatorView startAnimating];
    self.coverView = [[UIView alloc] initWithFrame:self.bounds];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.userInteractionEnabled = NO;
    self.coverView.alpha = 1;
    self.coverView.x = 0;
    self.coverView.y = 0;
    [self addSubview:_coverView];
    //play from start
    [self playOrPause:self.playOrPauseBtn];
#pragma - mark  此处添加开始播放过渡效果
    [UIView animateWithDuration:2 animations:^{
        self.coverView.alpha = 0;
    }];
    [self addSubview:self.backBtn];
    [self bottomBar];
    
    if (self.isMute) {
        self.player.volume=0;
        self.voiceBtn.selected=NO;
    }
    else
    {
        self.player.volume=1;
        self.voiceBtn.selected=YES;
    }
}

-(void)setOnlyFullScreen:(BOOL)onlyFullScreen
{
    _onlyFullScreen = onlyFullScreen;
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.playerLayer.masksToBounds=YES;
    self.playerLayer.cornerRadius=0.0;
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=0.0;
    self.isFullScreen = YES;
    self.zoomScreenBtn.selected = YES;
    self.backBtn.hidden=NO;
    
    [self.keyWindow addSubview:self];
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI / 2);
        self.frame = self.keyWindow.bounds;
    }];
    
    [self setStatusBarHidden:YES];
}
-(void)setTrillMode:(BOOL)trillMode
{
    _trillMode = trillMode;
    
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
}
//下载视频
-(void)downloadAction
{
    DownLoadmanager *manager = [[DownLoadmanager alloc]init];
    [manager downloadWithUrl:_videoUrl withType:DownloadTypeVideo];
    if (self.dowmLoadBlock) {
        self.dowmLoadBlock();
    }
}

//声音设置
-(void)voiceAction
{
    self.voiceBtn.selected=!self.voiceBtn.selected;
    if (self.voiceBtn.selected==YES) {
        self.player.volume=1;
    }
    else
    {
        self.player.volume=0;
    }
}

- (void)playPause {
    if (self.playOrPauseBtn.selected) {
        [self playOrPause:self.playOrPauseBtn];
    }
}

- (void)destroyPlayer {
    [self.player pause];
    [self.cmmotionManager stopGyroUpdates];
    self.cmmotionManager = nil;
  [self.playerItem cancelPendingSeeks];
     [self.playerItem.asset cancelLoading];
  self.player = nil;
    [self.slider removeFromSuperview];
   self.slider = nil;
    [self removeFromSuperview];
    [self deallocAction];
}

- (void)playerBindTableView:(UITableView *)bindTableView currentIndexPath:(NSIndexPath *)currentIndexPath {
    self.bindTableView = bindTableView;
    self.currentIndexPath = currentIndexPath;
}

- (void)playerScrollIsSupportSmallWindowPlay:(BOOL)support {
    
    NSAssert(self.bindTableView != nil, @"必须绑定对应的tableview！！！");
    
    self.currentPlayCellRect = [self.bindTableView rectForRowAtIndexPath:self.currentIndexPath];
    self.currentIndexPath = self.currentIndexPath;
    
    CGFloat cellBottom = self.currentPlayCellRect.origin.y + self.currentPlayCellRect.size.height;
    CGFloat cellUp = self.currentPlayCellRect.origin.y;
    
    if (self.bindTableView.contentOffset.y > cellBottom) {
        if (!support) {
            [self destroyPlayer];
            return;
        }
        [self smallWindowPlay];
        return;
    }
    
    if (cellUp > self.bindTableView.contentOffset.y + self.bindTableView.frame.size.height) {
        if (!support) {
            [self destroyPlayer];
            return;
        }
        [self smallWindowPlay];
        return;
    }
    
    if (self.bindTableView.contentOffset.y < cellBottom){
        if (!support) return;
        [self returnToOriginView];
        return;
    }
    
    if (cellUp < self.bindTableView.contentOffset.y + self.bindTableView.frame.size.height){
        if (!support) return;
        [self returnToOriginView];
        return;
    }
}

#pragma mark - layoutSubviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;

    if (!self.isOriginalFrame) {
        self.playerOriginalFrame = self.frame;
        self.playSuprView = self.superview;
        self.isOriginalFrame = YES;
    }
}

#pragma mark - status hiden

- (void)setStatusBarHidden:(BOOL)hidden {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.hidden = hidden;
}

#pragma mark - Screen Orientation

- (void)statusBarOrientationChange:(NSNotification *)notification {
    if (self.smallWinPlaying) return;
    if (self.onlyFullScreen) return;
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft) {
//        NSLog(@"UIDeviceOrientationLandscapeLeft");
     //   [self orientationLeftFullScreen];

    }else if (orientation == UIDeviceOrientationLandscapeRight) {
//        NSLog(@"UIDeviceOrientationLandscapeRight");
      //  [self orientationRightFullScreen];

    }else if (orientation == UIDeviceOrientationPortrait) {
//        NSLog(@"UIDeviceOrientationPortrait");
      //  [self smallScreen];

    }
}

- (void)actionFullScreen {
    
    if (!self.isFullScreen) { //非全屏点击fullscrenn时，如竖直持握设备，画面不横转。当横向持握设备时且当前是大屏播放状态自动横转
        if (_landscapeHold) {//横向持握设备点击全屏播放
             [self orientationLeftFullScreen];
        }else{//竖向持握设备
            [self orientationVerticalFullScreen];
           
        }
       
        NSLog(@"--大屏");
    }else {
        [self smallScreen];
        NSLog(@"--小屏");
    }
     self.activityIndicatorView.hidden = YES;
}
-(void)orientationVerticalFullScreen
{
    self.playerLayer.masksToBounds=YES;
    self.playerLayer.cornerRadius=5.0;
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=5.0;
    self.isFullScreen = YES;
    self.zoomScreenBtn.selected = YES;
    self.backBtn.hidden=NO;
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    
     [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.width = UI_SCREEN_WIDTH;
        self.height = UI_SCREEN_WIDTH*9/16;
        self.x = 0;
        self.y = (UI_SCREEN_HEIGHT - self.height)/2;
//        self.activityIndicatorView.center = CGPointMake(self.playerOriginalFrame.size.width / 2, self.playerOriginalFrame.size.height / 2);
//        self.activityIndicatorView.hidden = YES;
        [self updateConstraintsIfNeeded];
    }];
   
    [self setStatusBarHidden:NO];
    
    
    UIView *bkView = [_keyWindow viewWithTag:1919];
    if (!bkView) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        backView.backgroundColor = [UIColor blackColor];
        [backView addSubview:self];
        [backView setTag:1919];
        [_keyWindow addSubview:backView];
    }
  
    
}
- (void)orientationLeftFullScreen {
    
    self.playerLayer.masksToBounds=YES;
    self.playerLayer.cornerRadius=0.0;
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=0.0;
    self.isFullScreen = YES;
    self.zoomScreenBtn.selected = YES;
    self.backBtn.hidden=NO;
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;

    [self.keyWindow addSubview:self];
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    [self updateConstraintsIfNeeded];

    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI / 2);
        self.frame = self.keyWindow.bounds;
    }];
    
    [self setStatusBarHidden:YES];
}

- (void)orientationRightFullScreen {
    self.isFullScreen = YES;
    self.zoomScreenBtn.selected = YES;
    self.backBtn.hidden=NO;
    [self.keyWindow addSubview:self];
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;

    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeRight] forKey:@"orientation"];
    
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        self.frame = self.keyWindow.bounds;
    }];
    [self setStatusBarHidden:YES];
}

- (void)smallScreen {
    
    if (self.onlyFullScreen) {
        if (self.completedPlayingBlock) {
            [self setStatusBarHidden:NO];
            self.completedPlayingBlock(self);
            self.completedPlayingBlock = nil;
        }
    }
   //退回横屏，记得要把黑底给去掉
    UIView *bkView = [self.keyWindow viewWithTag:1919];
    if (bkView) {
         [bkView removeFromSuperview];
    }
   
    
    self.playerLayer.masksToBounds=YES;
    self.playerLayer.cornerRadius=5.0;
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=5.0;
    self.isFullScreen = NO;
    self.zoomScreenBtn.selected = NO;
    self.backBtn.hidden=YES;
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
   
    if (self.bindTableView) {
        UITableViewCell *cell = [self.bindTableView cellForRowAtIndexPath:self.currentIndexPath];
#pragma - mark  此处添加小屏幕播放时frame重置代码
        UIScrollView *videoScroll = [cell.contentView viewWithTag:555];//此处考虑到没用到scrollview的视图里此代码无效，所以直接用cell
        if (!videoScroll) {
            [cell.contentView addSubview:self];
        }else{
       [videoScroll addSubview:self];
        }
//        [cell.contentView addSubview:self] 原先是这样的 导致回缩小弹窗后，父视图iscrollview不能滑动
       }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = self.playerOriginalFrame;
        self.activityIndicatorView.center = CGPointMake(self.playerOriginalFrame.size.width / 2, self.playerOriginalFrame.size.height / 2);
       [self updateConstraintsIfNeeded];
    }];
//    self.y = 110;
//    self.x = 22;
    NSLog(@"self.frame is %@ ",NSStringFromCGRect(self.frame));
   [self setStatusBarHidden:NO];
}

#pragma mark - app notif

- (void)appDidEnterBackground:(NSNotification*)note {
    
    NSLog(@"appDidEnterBackground");
}

- (void)appWillEnterForeground:(NSNotification*)note {
    NSLog(@"appWillEnterForeground");
}

- (void)appwillResignActive:(NSNotification *)note {
    NSLog(@"appwillResignActive");
    [self playOrPause:self.playOrPauseBtn];
}

- (void)appBecomeActive:(NSNotification *)note {
    [self playOrPause:self.playOrPauseBtn];
}

#pragma mark - button action

- (void)playOrPause:(UIButton *)btn {
    if(self.player.rate == 0.0){      //pause
        btn.selected = YES;
        [self.player play];
    }else if(self.player.rate == 1.0f){    //playing
        [self.player pause];
        btn.selected = NO;
    }
}

//显示或隐藏bar
- (void)showOrHidenBar {
    if (self.barHiden) {
        [self show];
    }else {
        [self hiden];
    }
}

- (void)show {
    [UIView animateWithDuration:barAnimateSpeed animations:^{
        self.bottomBar.layer.opacity = opacity;
        self.playOrPauseBtn.layer.opacity = opacity;
        self.backBtn.layer.opacity=opacity;
    } completion:^(BOOL finished) {
        if (finished) {
            self.barHiden = !self.barHiden;
            [self performBlock:^{
                if (!self.barHiden && !self.inOperation) {
                    [self hiden];
                }
            } afterDelay:barShowDuration];
        }
    }];
}

- (void)hiden {
    self.inOperation = NO;
    [UIView animateWithDuration:barAnimateSpeed animations:^{
        self.bottomBar.layer.opacity = 0.0f;
        self.playOrPauseBtn.layer.opacity = 0.0f;
        self.backBtn.layer.opacity=0.0f;
    } completion:^(BOOL finished){
        if (finished) {
            self.barHiden = !self.barHiden;
        }
    }];
}

#pragma mark - call back

- (void)sliderValueChange:(XLSlider *)slider {
    self.progressLabel.text = [self timeFormatted:slider.value * self.totalDuration];
}

- (void)finishChange {
    self.inOperation = NO;
  [self performBlock:^{
        if (!self.barHiden && !self.inOperation) {
            [self hiden];
        }
    } afterDelay:barShowDuration];
    
    [self.player pause];
    
    CMTime currentCMTime = CMTimeMake(self.slider.value * self.totalDuration, 1);
    if (self.slider.middleValue) {
        [self.player seekToTime:currentCMTime completionHandler:^(BOOL finished) {
            [self.player play];
            self.playOrPauseBtn.selected = YES;
        }];
    }
}

//Dragging the thumb to suspend video playback

- (void)dragSlider {
    self.inOperation = YES;
    [self.player pause];
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(callBlockAfterDelay:) withObject:block afterDelay:delay];
}

- (void)callBlockAfterDelay:(void (^)(void))block {
    block();
}

#pragma mark - monitor video playing course

-(void)addProgressObserver{
    
    //get current playerItem object
    AVPlayerItem *playerItem = self.player.currentItem;
    WeakSelf(self);
    
    //Set once per second
    [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(0.1f, NSEC_PER_SEC)  queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        float current = CMTimeGetSeconds(time);
        weakself.current = current;
        float total = CMTimeGetSeconds([playerItem duration]);
        weakself.progressLabel.text = [weakself timeFormatted:current];
        if (current) {
//            NSLog(@"current --- %f", current );
            
            if (!weakself.inOperation&&total>0) {
                 weakself.slider.value = current / total;
            }
            if (weakself.slider.value == 1.0f) {      //complete block
                weakself.isFullScreen = NO;
                if (weakself.completedPlayingBlock) {
                    [weakself setStatusBarHidden:NO];
                    
                    UIView *bkView = [weakself.keyWindow viewWithTag:1919];
                    if (bkView) {
                        [bkView removeFromSuperview];
                    }
                    if ( weakself.completedPlayingBlock) {
                        weakself.completedPlayingBlock(weakself);
                    }
                    weakself.completedPlayingBlock = nil;
                }else {       //finish and loop playback
                    weakself.playOrPauseBtn.selected = NO;
                    [weakself showOrHidenBar];
                    CMTime currentCMTime = CMTimeMake(0, 1);
                    [weakself.player seekToTime:currentCMTime completionHandler:^(BOOL finished) {
                        weakself.slider.value = 0.0f;
                    }];
                }
            }
        }
    }];
}

#pragma mark - PlayerItem （status，loadedTimeRanges）

-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //network loading progress
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  通过KVO监控播放器状态
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if(status == AVPlayerStatusReadyToPlay){
            self.totalDuration = CMTimeGetSeconds(playerItem.duration);
            self.totalDurationLabel.text = [self timeFormatted:self.totalDuration];
            self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;

//            [self setvideoGravityiWithAsset:playerItem.asset];
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        if (CMTimeGetSeconds(playerItem.duration)>0) {
            self.slider.middleValue = totalBuffer / CMTimeGetSeconds(playerItem.duration);
        }
//        NSLog(@"totalBuffer：%.2f",totalBuffer);
        
        //loading animation
        if (self.slider.middleValue  <= self.slider.value || (totalBuffer - 1.0) < self.current) {
            NSLog(@"正在缓冲...");
            
            self.activityIndicatorView.hidden = NO;
            [self.activityIndicatorView startAnimating];
        }else {
            self.activityIndicatorView.hidden = YES;

            if (self.playOrPauseBtn.selected) {
                [self.player play];
               
            }
        }
    }
}

#pragma mark - timeFormat
//设置视频的填充模式
-(void)setvideoGravityiWithAsset:(AVAsset*)asset
{

    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGFloat width  = videoTrack.naturalSize.width;
        CGFloat height = videoTrack.naturalSize.height;
        NSLog(@"width-%lf,height--%f",width,height);
        if (width==0||height==0) {
            return;
        }
        CGFloat ratio = width / height;
        if (ratio<1) {  //竖屏
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;//视频填充模式
        }
        else
        {
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//视频填充模式
        }
    }
}

//获取视频时长
- (NSString *)timeFormatted:(int)totalSeconds {
    if (totalSeconds==0) {
        return @"00:00";
    }
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
//    int hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

#pragma mark - animation smallWindowPlay

- (void)smallWindowPlay {
    if ([self.superview isKindOfClass:[UIWindow class]]) return;
    self.smallWinPlaying = YES;
    self.playOrPauseBtn.hidden = YES;
    if (!_trillMode) {
         self.bottomBar.hidden = YES;
    }
   
    self.backBtn.hidden=YES;

    CGRect tableViewframe = [self.bindTableView convertRect:self.bindTableView.bounds toView:self.keyWindow];
    self.frame = [self convertRect:self.frame toView:self.keyWindow];
    [self.keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGFloat w = self.playerOriginalFrame.size.width * 0.5;
        CGFloat h = self.playerOriginalFrame.size.height * 0.5;
        CGRect smallFrame = CGRectMake(tableViewframe.origin.x + tableViewframe.size.width - w, tableViewframe.origin.y + tableViewframe.size.height - h, w, h);
        self.frame = smallFrame;
        self.playerLayer.frame = self.bounds;
        self.activityIndicatorView.center = CGPointMake(w / 2.0, h / 2.0);
    }];
}

- (void)returnToOriginView {
    if (![self.superview isKindOfClass:[UIWindow class]]) return;
    self.smallWinPlaying = NO;
    self.playOrPauseBtn.hidden = NO;
    if (!_trillMode) {
        self.bottomBar.hidden = NO;
    }
    self.backBtn.hidden =NO;

    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(self.currentPlayCellRect.origin.x, self.currentPlayCellRect.origin.y, self.playerOriginalFrame.size.width, self.playerOriginalFrame.size.height);
        self.playerLayer.frame = self.bounds;
        self.activityIndicatorView.center = CGPointMake(self.playerOriginalFrame.size.width / 2, self.playerOriginalFrame.size.height / 2);
    } completion:^(BOOL finished) {
        self.frame = self.playerOriginalFrame;
        UITableViewCell *cell = [self.bindTableView cellForRowAtIndexPath:self.currentIndexPath];
        [cell.contentView addSubview:self];
    }];
}

#pragma mark - lazy loading

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self insertSubview:_activityIndicatorView aboveSubview:self.playOrPauseBtn];
        [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.playOrPauseBtn);
            make.centerY.mas_equalTo(self.playOrPauseBtn);
        }];
    }
    return _activityIndicatorView;
}

- (UIView *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[UIView alloc] init];
        _bottomBar.backgroundColor = [UIColor blackColor];
        _bottomBar.layer.opacity = 0.0f;
        [self addSubview:_bottomBar];
        if (_trillMode) {
            _bottomBar.frame = CGRectMake(0, self.height-60, self.width, 40);
        }else{
        [_bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
           make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(40);
        }];
        }
       
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.translatesAutoresizingMaskIntoConstraints = NO;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = @"00:00";
        label1.font = [UIFont systemFontOfSize:12.0f];
        label1.textColor = [UIColor whiteColor];
        [_bottomBar addSubview:label1];
        self.progressLabel = label1;
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bottomBar);
            make.centerY.mas_equalTo(_bottomBar);
            make.size.mas_equalTo(CGSizeMake(50, 40));
        }];
        
        UIButton *fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fullScreenBtn.translatesAutoresizingMaskIntoConstraints = NO;
        fullScreenBtn.contentMode = UIViewContentModeCenter;
        [fullScreenBtn setImage:[UIImage imageNamed:@"u_screen"] forState:UIControlStateNormal];
        [fullScreenBtn setImage:[UIImage imageNamed:@"u_screen"] forState:UIControlStateSelected];
        [fullScreenBtn addTarget:self action:@selector(actionFullScreen) forControlEvents:UIControlEventTouchDown];

        [_bottomBar addSubview:fullScreenBtn];

        self.zoomScreenBtn = fullScreenBtn;
        [fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_bottomBar);
            make.centerY.mas_equalTo(_bottomBar);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downloadBtn.translatesAutoresizingMaskIntoConstraints = NO;
        downloadBtn.contentMode = UIViewContentModeCenter;
        [downloadBtn setImage:[UIImage imageNamed:@"u_download"] forState:UIControlStateNormal];
        [downloadBtn setImage:[UIImage imageNamed:@"u_download"] forState:UIControlStateSelected];
        [downloadBtn addTarget:self action:@selector(downloadAction) forControlEvents:UIControlEventTouchDown];

             [_bottomBar addSubview:downloadBtn];

       
        self.downloadBtn = downloadBtn;
        [downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(fullScreenBtn.mas_left);
            make.centerY.mas_equalTo(_bottomBar);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        if (_trillMode) {
            UIView *bg = [UIView new];
            bg.backgroundColor = [UIColor blackColor];
            [_bottomBar addSubview:bg];
            [bg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(downloadBtn);
                make.right.mas_equalTo(fullScreenBtn);
                make.top.mas_equalTo(fullScreenBtn);
                make.bottom.mas_equalTo(fullScreenBtn);
            }];
            
            UIButton *closeBtn = [UIButton buttonWithType:0];
            [closeBtn setTitle:@"关闭" forState:0];
            [closeBtn setTitleColor:[UIColor whiteColor] forState:0];
            closeBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
            [closeBtn addTarget:self action:@selector(closePlayer) forControlEvents:UIControlEventTouchUpInside];
            [bg addSubview:closeBtn];
            [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(bg);
                make.right.mas_equalTo(bg);
                make.top.mas_equalTo(bg);
                make.bottom.mas_equalTo(bg);
                
            }];
        }
        
        UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        voiceBtn.translatesAutoresizingMaskIntoConstraints = NO;
        voiceBtn.contentMode = UIViewContentModeCenter;
        [voiceBtn setImage:[UIImage imageNamed:@"icon_noVoice"] forState:UIControlStateNormal];
        [voiceBtn setImage:[UIImage imageNamed:@"icon_voice"] forState:UIControlStateSelected];
        [voiceBtn addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchDown];
        [_bottomBar addSubview:voiceBtn];
        self.voiceBtn = voiceBtn;
        [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(downloadBtn.mas_left);
            make.centerY.mas_equalTo(_bottomBar);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.translatesAutoresizingMaskIntoConstraints = NO;
        label2.textAlignment = NSTextAlignmentCenter;
        label2.text = @"00:00";
        label2.font = [UIFont systemFontOfSize:12.0f];
        label2.textColor = [UIColor whiteColor];
        [_bottomBar addSubview:label2];
        self.totalDurationLabel = label2;
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(voiceBtn.mas_left);
            make.centerY.mas_equalTo(_bottomBar);
            make.size.mas_equalTo(CGSizeMake(50, 40));
        }];
        
        XLSlider *slider = [[XLSlider alloc] init];
        slider.value = 0.0f;
        slider.middleValue = 0.0f;
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        [_bottomBar addSubview:slider];
        self.slider = slider;
        [slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label1.mas_right);
            make.right.mas_equalTo(label2.mas_left);
            make.centerY.mas_equalTo(_bottomBar);
            make.height.mas_equalTo(40);
        }];
        WeakSelf(self);
        slider.valueChangeBlock = ^(XLSlider *slider){
            [weakself sliderValueChange:slider];
        };
        slider.finishChangeBlock = ^(XLSlider *slider){
            [weakself finishChange];
        };
        slider.draggingSliderBlock = ^(XLSlider *slider){
            [weakself dragSlider];
        };
        
        [self updateConstraintsIfNeeded];
    }
    return _bottomBar;
}
-(void)closePlayer
{
    self.completedPlayingBlock(self);
}
- (UIButton *)playOrPauseBtn {
    if (!_playOrPauseBtn) {
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playOrPauseBtn.layer.opacity = 0.0f;
        _playOrPauseBtn.contentMode = UIViewContentModeCenter;
        [_playOrPauseBtn setBackgroundImage:[UIImage imageNamed:@"u_play_big"] forState:UIControlStateNormal];
        [_playOrPauseBtn setBackgroundImage:[UIImage imageNamed:@"u_pause_big"] forState:UIControlStateSelected];
        [_playOrPauseBtn addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchDown];
        [self insertSubview:self.playOrPauseBtn aboveSubview:self.activityIndicatorView];
        if (_trillMode) {
            _playOrPauseBtn.frame = CGRectMake((self.width-playBtnSideLength)/2, (self.height-playBtnSideLength)/2, playBtnSideLength, playBtnSideLength);
        }else{
        [_playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(playBtnSideLength, playBtnSideLength));
        }];
        }
    }
    return _playOrPauseBtn;
}

-(UIButton*)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,15, 44, 44)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"video_back"] forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"video_back"] forState:UIControlStateHighlighted];
        [_backBtn addTarget:self action:@selector(actionFullScreen) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.hidden=YES;
    }
    return _backBtn;
}

#pragma mark - dealloc

- (void)deallocAction {
    //用于异常捕获，避免重复移除监听
    @try {
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    } @catch (NSException *exception) {
        
    } @finally {
        
    };
}

@end
