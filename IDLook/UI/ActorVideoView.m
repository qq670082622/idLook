//
//  ActorVideoView.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ActorVideoView.h"

@implementation ActorVideoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ActorVideoView" owner:nil options:nil] lastObject];
    }
    self.subView.y = 0;
    self.width = UI_SCREEN_WIDTH;
    return self;
}

- (void)setVideoViewModel:(ActorVideoViewModel *)videoViewModel
{
    _videoViewModel = videoViewModel;
    [self.videoIcon sd_setImageWithUrlStr:videoViewModel.cutVideo placeholderImage:[UIImage imageNamed:@"default_video"]];
    if (videoViewModel.videoUrl.length<2) {
        self.play_img.hidden = YES;
        self.duration.hidden = YES;
    }
    _subView.userInteractionEnabled=YES;
    _videoIcon.contentMode=UIViewContentModeScaleAspectFill;
    _subView.clipsToBounds=YES;
    _subView.layer.masksToBounds=YES;
    _subView.layer.cornerRadius=5.0;
    self.videoTitle.text = videoViewModel.cateName;
    self.look_download.text = [NSString stringWithFormat:@"%ld次浏览 | %ld次下载",(long)videoViewModel.plays,(long)videoViewModel.downloads];
    
    [self.duration setTitle:[NSString stringWithFormat:@" %@",[self timeWithDuration:videoViewModel.timeVideo]] forState:0];
    
  
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.subView.y = 0;
    self.width = UI_SCREEN_WIDTH;
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
- (IBAction)play:(id)sender {
    if (_videoViewModel.videoUrl.length<2) {
        self.lookPicture(_workModel, _index);
    }else{
    self.playVideo(_workModel, _index);
    }
}
-(void)setWorkModel:(WorksModel *)workModel
{
    _workModel = workModel;
}
-(void)setIndex:(NSInteger)index
{
    _index = index;
}
@end
