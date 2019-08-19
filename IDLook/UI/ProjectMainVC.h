//
//  ProjectMainVC.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectMainVCM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectMainVC : UIViewController
@property(nonatomic,strong)ProjectMainVCM *dsm;
//播放视频
-(void)playVideoWithUrl:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
