//
//  VideoPlayer.h
//  VideoPlayer
//
//  Created by Shelin on 16/3/23.
//  Copyright © 2016年 GreatGate. All rights reserved.
//  https://github.com/ShelinShelin
//  博客：http://www.jianshu.com/users/edad244257e2/latest_articles

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class VideoPlayer;

typedef void (^VideoCompletedPlayingBlock) (VideoPlayer *videoPlayer);

@interface VideoPlayer : UIView

@property (nonatomic, copy) VideoCompletedPlayingBlock completedPlayingBlock;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;//当前播放的index 用来判断画滑动需不需要销毁当前播放器
/**video player*/
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/**
 下载回掉
 */
@property(nonatomic,copy)void(^dowmLoadBlock)(void);

/**
 *  video url 视频路径
 */
@property (nonatomic, strong) NSString *videoUrl;

/**
 video volume 是否静音 ,  列表播放时静音
 */
@property (nonatomic,assign) BOOL isMute;
@property(nonatomic,assign)BOOL trillMode;//抖音模式 全屏按钮变关闭按钮
/**
 *  play or pause
 */
- (void)playPause;

/**
 *  dealloc 销毁
 */
- (void)destroyPlayer;

/**
 *  在cell上播放必须绑定TableView、当前播放cell的IndexPath
 */
- (void)playerBindTableView:(UITableView *)bindTableView currentIndexPath:(NSIndexPath *)currentIndexPath;

/**
 *  在scrollview的scrollViewDidScroll代理中调用
 *
 *  @param support        是否支持右下角小窗悬停播放
 */
- (void)playerScrollIsSupportSmallWindowPlay:(BOOL)support;


/**
 是否直接全屏播放
 */
@property(nonatomic,assign)BOOL onlyFullScreen;

@end
