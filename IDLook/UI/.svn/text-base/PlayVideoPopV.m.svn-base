//
//  PlayVideoPopV.m
//  HYHexample
//
//  Created by 胡永辉 on 16/8/16.
//  Copyright © 2016年 胡永辉. All rights reserved.
//

#import "PlayVideoPopV.h"
#import <AVFoundation/AVFoundation.h>


@interface PlayVideoPopV ()


@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/**video player*/
@property (nonatomic,strong) AVPlayer *player;

@end

@implementation PlayVideoPopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

-(void)moviePlayDidEnd:(NSNotification*)noti
{
    [self.player pause];
    [self hide];
}


- (void)hide
{
    [self destroyPlayer];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
}


-(void)show
{
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    [self creatClickLayout];

    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
    
}

-(void)creatClickLayout
{
    [self.layer addSublayer:self.playerLayer];
    self.playerLayer.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    [self.player play];
}

- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.backgroundColor = [UIColor clearColor].CGColor;
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;//视频填充模式
    }
    return _playerLayer;
}


- (AVPlayer *)player{
    if (!_player) {
        AVPlayerItem *playerItem = [self getAVPlayItem];
        self.playerItem = playerItem;
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        [_player setActionAtItemEnd:AVPlayerActionAtItemEndPause];
        
        [self addObserverToPlayerItem:playerItem];
        
        // 解决8.1系统播放无声音问题，8.0、9.0以上未发现此问题
        AVAudioSession * session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];
    }
    return _player;
}

//initialize AVPlayerItem
- (AVPlayerItem *)getAVPlayItem{
    
    NSAssert(self.videoUrl != nil, @"必须先传入视频url！！！");
    
    if ([self.videoUrl rangeOfString:@"http"].location != NSNotFound) {
        AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:[NSURL URLWithString:[self.videoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        return playerItem;
    }else{
    
//        NSString *audioPath = [[NSBundle mainBundle] pathForResource:self.videoUrl ofType:nil];

        AVAsset *movieAsset  = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:self.videoUrl ] options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.videoUrl]];
        return playerItem;
    }
}

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
            NSLog(@"ready play");
        }
        else if (status==AVPlayerStatusFailed)
        {
            NSLog(@"failed");
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        NSLog(@"loadedTimeRanges");
    }
}

-(void)removeObserve
{
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];

}
- (void)play
{
    [self.player play];
}

-(void)pause
{
    [self.player pause];
}

- (void)destroyPlayer
{
    [self removeObserve];
    
    [self.player pause];
    
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
}



@end
