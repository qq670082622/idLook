//
//  QNTestVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/2/13.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "QNTestVC.h"
#import <QNRTCKit/QNRTCKit.h>
#import "QRDUserView.h"
@interface QNTestVC ()<QNRTCEngineDelegate>
//呼叫页面
@property (weak, nonatomic) IBOutlet UIView *callView;
@property (weak, nonatomic) IBOutlet UIButton *callView_closeBtn;
- (IBAction)closeCallView:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *callView_icon;
@property (weak, nonatomic) IBOutlet UILabel *callView_actorName;
@property (weak, nonatomic) IBOutlet UILabel *callView_statuesLabel;
@property (weak, nonatomic) IBOutlet UILabel *callView_time;
@property (weak, nonatomic) IBOutlet UILabel *callView_tip;
@property (weak, nonatomic) IBOutlet UIView *callView_btnView;
@property (weak, nonatomic) IBOutlet UIButton *callView_finishBtn;
- (IBAction)callView_finish:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *callView_startBtn;
- (IBAction)callViewStart:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *callView_contactBtn;
- (IBAction)callView_contact:(id)sender;

@property(nonatomic,strong) NSTimer *statuesTimer;
@property(nonatomic,assign)NSInteger time;
@property (weak, nonatomic) IBOutlet UILabel *leaveTip;

//直播相关
@property (nonatomic, strong) QNRTCEngine *engine;

@property(nonatomic,assign)BOOL remoteScreenBig;//远端流对应的试图是大的还是小的
@property(nonatomic,strong)QNVideoView *remoteView;//远端视频

@property (weak, nonatomic) IBOutlet UIImageView *actorIcon;
@property (weak, nonatomic) IBOutlet UILabel *actorName;
- (IBAction)finish:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property(nonatomic,assign)NSInteger videoTime;
@end

@implementation QNTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.callView_icon.layer.cornerRadius = 40;
//    self.callView_icon.layer.masksToBounds = YES;
//    self.callView_btnView.layer.cornerRadius = 46;
//    self.callView_btnView.layer.masksToBounds = YES;
//    self.callView_contactBtn.layer.cornerRadius = 8;
//    self.callView_contactBtn.layer.masksToBounds = YES;
    
//    告知出入试镜间
    NSDictionary *arg = @{
                          @"operation":@(1),
                          @"roomName":_roomName,
                          @"userId":@([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA roomOperationWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSLog(@"房间操作返回object is %@",object);
        }
    }];
    
    UIButton *auditionBtn = [[UIApplication sharedApplication].keyWindow viewWithTag:336699];
    auditionBtn.hidden = YES;
    self.actorIcon.layer.cornerRadius = 22;
    self.actorIcon.layer.masksToBounds = YES;
    [self.actorIcon sd_setImageWithUrlStr:_hisAvatar placeholderImage:[UIImage imageNamed:@"default_home"]];
    [self.callView_icon sd_setImageWithUrlStr:_hisAvatar placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.actorName.text = _hisName;
    self.callView_actorName.text = _hisName;
     self.leaveTip.alpha = 0;
    self.leaveTip.text = [NSString stringWithFormat:@"%@离开了试镜间",_hisName];
    self.engine = [[QNRTCEngine alloc] init];
    self.engine.delegate = self;
//  if (@available(iOS 9.0, *)) {
//        self.engine.sessionPreset = AVCaptureSessionPreset3840x2160;
//    } else {
//        self.engine.sessionPreset = AVCaptureSessionPreset1920x1080;
//    };
   self.engine.videoFrameRate = 20;
    [self.engine setBeautifyModeOn:YES];
//    self.engine.screenRecorderFrameRate = 20;

    [self setSubViews];

    
  
}
-(void)setSubViews
{
    if ([UserInfoManager getUserType]==1) {//购买方
           _isBuyer = YES;
    }else{//资源方
           _isBuyer = NO;
    }
    if (_isBuyer) {//购买方  //普通用户token
       // if (_isCall) {//主动call
//            self.callView_statuesLabel.text = @"____   等待艺人接入   ____";
//            self.callView_btnView.frame = CGRectMake((UI_SCREEN_WIDTH-92)/2, 439, 92, 92);
//            self.callView_finishBtn.frame = CGRectMake((UI_SCREEN_WIDTH-54)/2, 458, 54, 54);
//            self.callView_startBtn.hidden = YES;
//            self.callView_closeBtn.hidden = YES;
//            self.time = 31;
//            self.callView_contactBtn.hidden = YES;
//              self.statuesTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpData) userInfo:nil repeats:YES];
        
           [self.engine joinRoomWithToken:_token];
//         [self.engine joinRoomWithToken:@"jdSRYoxsQjziaYM0HACtiS9A0uuCU8sIWvZxzbR7:o95Uab7q3OMiqOq9bDJjjoVRofE=:eyJhcHBJZCI6ImUwbG42YmpnbiIsInJvb21OYW1lIjoibGl2ZUF1ZGl0aW9uYW8yMDE5MDczMDE0MzczOTAxODAiLCJ1c2VySWQiOiIxMTExMTEiLCJleHBpcmVBdCI6MTU2NDU3Mjk3NCwicGVybWlzc2lvbiI6InVzZXIifQ=="];
           // [self.engine publishAudio];
     //   }
//        else{//被呼
//            self.callView_tip.hidden = YES;
//            self.time = 31;
//             self.callView_statuesLabel.text = @"____   等待您的接入   ____";
//            self.callView_contactBtn.hidden = YES;
//               self.callView_closeBtn.hidden = YES;
//            self.statuesTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpData) userInfo:nil repeats:YES];
//        }
    
    }else{//资源方  //管理员token
        
        self.engine.previewView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
        [self.view insertSubview:self.engine.previewView atIndex:0];
        [self bringSubViewsToTheFront];
       // self.engine.previewView.backgroundColor = [UIColor redColor];
//        UITapGestureRecognizer *singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewTap:)];
//        [self.engine.previewView addGestureRecognizer:singletap];//自己的视频
       
//        if (_isCall) {//主动call
//            self.callView_statuesLabel.text = @"____   等待买家接入   ____";
//            self.callView_btnView.frame = CGRectMake((UI_SCREEN_WIDTH-92)/2, 439, 92, 92);
//            self.callView_finishBtn.frame = CGRectMake((UI_SCREEN_WIDTH-54)/2, 458, 54, 54);
//            self.callView_startBtn.hidden = YES;
//            self.callView_closeBtn.hidden = YES;
//            self.time = 31;
//            self.callView_contactBtn.hidden = YES;
//            self.statuesTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpData) userInfo:nil repeats:YES];
//
//             [self.engine joinRoomWithToken:_token];
//        }else{//被呼
//            self.callView_tip.hidden = YES;
//             self.callView_statuesLabel.text = @"____   等待您的接入   ____";
//            self.time = 31;
//            self.callView_contactBtn.hidden = YES;
//            self.callView_closeBtn.hidden = YES;
//            self.statuesTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpData) userInfo:nil repeats:YES];
//        }
      
        
          [self.engine startCapture];
        [self.engine joinRoomWithToken:_token];
//         [self.engine joinRoomWithToken:@"jdSRYoxsQjziaYM0HACtiS9A0uuCU8sIWvZxzbR7:zgXol7QLoPdIKXcoIiZmnWIcbkQ=:eyJhcHBJZCI6ImUwbG42YmpnbiIsInJvb21OYW1lIjoic2IyNTAiLCJ1c2VySWQiOiIxMTIyMzMiLCJleHBpcmVBdCI6MTU2NjcyMjk5MCwicGVybWlzc2lvbiI6ImFkbWluIn0="];
       
//          [self.engine publish];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 //   self.navigationController.navigationBar.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

  //  self.navigationController.navigationBar.hidden = NO;
}
//当远端用户发布视频后，在远端用户视频首帧解码后的回调中，渲染画面并返回相应类
- (QNVideoRender *)RTCEngine:(QNRTCEngine *)engine firstVideoDidDecodeOfTrackId:(NSString *)trackId remoteUserId:(NSString *)userId {
  
    QNVideoRender *render = [[QNVideoRender alloc] init];
    if (_isBuyer) {
      QNVideoView *videoView = [[QNVideoView alloc]initWithFrame: CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        [self.view addSubview:videoView];
//        UITapGestureRecognizer *singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remoteViewTap:)];
//        [videoView addGestureRecognizer:singletap];
        render.renderView = videoView;
        self.remoteView = videoView;
      }
    [self bringSubViewsToTheFront];
     return render;

}
- (void)RTCEngine:(QNRTCEngine *)engine didPublishLocalTracks:(NSArray<QNTrackInfo *> *)tracks {
    NSLog(@"自己的推送发布成功了！！！！！！！！！！！tracks is %@",tracks);
}
//房间内任意用户发布流后成功后的回调
-(void)RTCEngine:(QNRTCEngine *)engine didGetAudioBuffer:(AudioBuffer *)audioBuffer bitsPerSample:(NSUInteger)bitsPerSample sampleRate:(NSUInteger)sampleRate ofTrackId:(NSString *)trackId remoteUserId:(NSString *)userId
{
    dispatch_async(dispatch_get_main_queue(), ^{
         self.leaveTip.alpha = 0;
        
    });
   
    NSLog(@"房间内任意用户发布流后成功后的回调trackid is %@ , userId is %@",trackId,userId);
}
//有人进来了
-(void)RTCEngine:(QNRTCEngine *)engine didJoinOfRemoteUserId:(nonnull NSString *)userId userData:(nonnull NSString *)userData
{
    NSLog(@"有人进来了 %@--------------%@",userId,userData);
    if (_isBuyer) {
        [self.engine publishAudio];
    }else{
     [self.engine publish];
    }
//    购买方不需要publish  资源方需要c
    // [SVProgressHUD showImage:nil status:@"对方加入试镜间"];
//    [UIView animateWithDuration:0.8 animations:^{
//        self.callView.y = -self.callView.height;
//    }];
//    [self.statuesTimer invalidate];
//    self.statuesTimer = nil;
//    self.statuesTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAdd) userInfo:nil repeats:YES];

}
//呼叫页面 接受呼叫
- (IBAction)callViewStart:(id)sender {
//    if (_isBuyer) {
//        [self.engine joinRoomWithToken:@"jdSRYoxsQjziaYM0HACtiS9A0uuCU8sIWvZxzbR7:H6ybdecq-MLezjfVKnYArpkuIio=:eyJhcHBJZCI6ImUwbG42YmpnbiIsInJvb21OYW1lIjoiY2FzdGluZ18xMjMiLCJ1c2VySWQiOiJzaHVzaHUyIiwiZXhwaXJlQXQiOjE1ODA1NDgyNzcsInBlcm1pc3Npb24iOiJ1c2VyIn0="];//shushu1 casting_123
//         [self.engine joinRoomWithToken:_token];
//        [self.engine publishAudio];
 //   }else{
//        [self.engine joinRoomWithToken:@"jdSRYoxsQjziaYM0HACtiS9A0uuCU8sIWvZxzbR7:N4oq_o2VZ5ctrjobXLR2pq-dhxM=:eyJhcHBJZCI6ImUwbG42YmpnbiIsInJvb21OYW1lIjoiY2FzdGluZ18xMjMiLCJ1c2VySWQiOiJzaHVzaHUxIiwiZXhwaXJlQXQiOjE1ODA1NDgyNzcsInBlcm1pc3Npb24iOiJhZG1pbiJ9"];//shushu1 casting_123
//         [self.engine joinRoomWithToken:_token];
//        [self.engine publish];
 //   }
//    [UIView animateWithDuration:0.8 animations:^{
//        self.callView.y = -self.callView.height;
//    }];
//    [self.statuesTimer invalidate];
//    self.statuesTimer = nil;
//    self.statuesTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAdd) userInfo:nil repeats:YES];
}
//有屌毛离开房间了
- (void)RTCEngine:(QNRTCEngine *)engine didLeaveOfRemoteUserId:(NSString *)userId
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view bringSubviewToFront:_leaveTip];
        self.leaveTip.alpha = 1;
      
    });
    [UIView animateWithDuration:4 animations:^{
        
    }completion:^(BOOL finished) {
        self.leaveTip.alpha = 0;
    }];
  
    [SVProgressHUD showImage:nil status:@"对方离开试镜间"];
//    [self.engine leaveRoom];
//
//    [self.statuesTimer invalidate];
//    self.statuesTimer = nil;
//    if (_isBuyer) {
//        [UIView animateWithDuration:0.8 animations:^{
//            self.callView.y = 0;
//        }];
//        self.callView_btnView.hidden = YES;
//        self.callView_tip.text = @"试镜时常";
//        self.callView_statuesLabel.text = @"____   试镜结束   ____";
//         [self.callView_contactBtn setTitle:@"下载试镜视频" forState:0];
//    }else{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
   
}
//结束试镜
- (IBAction)finish:(id)sender {
    [SVProgressHUD showImage:nil status:@"您离开了试镜间"];
    [self.engine leaveRoom];
//
    [self.statuesTimer invalidate];
    self.statuesTimer = nil;
//    if (_isBuyer) {
//        [UIView animateWithDuration:0.8 animations:^{
//            self.callView.y = 0;
//        }];
//        self.callView_btnView.hidden = YES;
//        self.callView_tip.text = @"试镜时常";
//        self.callView_statuesLabel.text = @"____   试镜结束   ____";
//        [self.callView_contactBtn setTitle:@"下载试镜视频" forState:0];
//    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    
    
    
    UIButton *auditionBtn = [[UIApplication sharedApplication].keyWindow viewWithTag:336699];
    auditionBtn.hidden = NO;
    NSDictionary *arg = @{
                          @"operation":@(2),
                          @"roomName":_roomName,
                          @"userId":@([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA roomOperationWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSLog(@"房间操作返回object is %@",object);
        }
    }];
}
//成功订阅对方的track
- (void)RTCEngine:(QNRTCEngine *)engine didSubscribeTracks:(NSArray<QNTrackInfo *> *)tracks ofRemoteUserId:(NSString *)userId {

    NSLog(@"成功订阅对方的track--------------------------");
}
//错误提示
- (void)RTCEngine:(QNRTCEngine *)engine didFailWithError:(NSError *)error
{
    NSLog(@"-----------error:%@---------------",error);

}
//远端被点击
-(void)remoteViewTap:(UITapGestureRecognizer *)gesture
{
    //判断是自己的流还是对方的流
    if (_remoteScreenBig) {//远端是大的，近端小  不动

    }else{//远端要调大，近端变小
        self.remoteView.frame = CGRectMake(0, 0,UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
        self.engine.previewView.frame = CGRectMake(10, 10, UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT/3);
        [self.view bringSubviewToFront:self.engine.previewView];
    }
}
-(void)previewTap:(UITapGestureRecognizer *)gesture
{
    if (_remoteScreenBig) {//远端是大的，近端小  s把远端调小近端调大
        self.remoteView.frame = CGRectMake(10, 10, UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT/3);
        self.engine.previewView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
         [self.view bringSubviewToFront:self.remoteView];
    }else{//远端要调大，近端变小

    }
}
//呼叫倒计时
-(void)timeUpData
{
       if (_time>1) {
            _time--;
            self.callView_time.text = [NSString stringWithFormat:@"%ldS",_time];
         
        }else{
            if (_isCall) {//主动call
                [self.engine leaveRoom];
                  self.callView_statuesLabel.text = @"____   对方超时未接入   ____";
                 self.callView_closeBtn.hidden = NO;
                 self.callView_contactBtn.hidden = NO;
            }else{//被动call 直接pop出去
                [self closeCallView:nil];
            }
           
            
            [self.statuesTimer invalidate];
            self.statuesTimer = nil;
        }
    
}
//视频计时
-(void)timeAdd
{
    _videoTime++;
    self.callView_statuesLabel.text = [self timeWithDuration:_videoTime];
}
//呼叫页面关闭页面
- (IBAction)closeCallView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//呼叫页面 结束呼叫
- (IBAction)callView_finish:(id)sender {
    [self closeCallView:nil];
}

//呼叫页面 联系脸探 或下载试镜视频
- (IBAction)callView_contact:(id)sender {
    if ([_callView_contactBtn.titleLabel.text containsString:@"联系"]) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:400-833-6969"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{//下载
        
    }
  
}

-(NSString *)timeWithDuration:(NSInteger)duration
{
    NSInteger duration_int = duration;
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02d",(duration_int%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02d",duration_int%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
}

-(void)bringSubViewsToTheFront
{
    [self.view bringSubviewToFront:self.actorName];
    [self.view bringSubviewToFront:self.actorIcon];
    [self.view bringSubviewToFront:self.finishBtn];
}
@end
