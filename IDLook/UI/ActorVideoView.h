//
//  ActorVideoView.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorVideoViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActorVideoView : UIView
@property (weak, nonatomic) IBOutlet UIView *subView;
@property(nonatomic,strong)ActorVideoViewModel *videoViewModel;
@property (weak, nonatomic) IBOutlet UIImageView *videoIcon;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
- (IBAction)play:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *look_download;
@property (weak, nonatomic) IBOutlet UIButton *duration;
@property(nonatomic,copy)void(^playVideo)(WorksModel *work,NSInteger index);
@property(nonatomic,copy)void(^lookPicture)(WorksModel *work,NSInteger index);
@property(nonatomic,strong)WorksModel *workModel;
@property(nonatomic,assign)NSInteger index;
@property (weak, nonatomic) IBOutlet UIImageView *play_img;
@end

NS_ASSUME_NONNULL_END
