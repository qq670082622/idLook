//
//  MyOrderMainVC.h
//  IDLook
//
//  Created by HYH on 2018/5/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderMainVC : UIViewController

@property (nonatomic,assign)NSInteger currIndex;
-(void)refreshData;

//播放视频
-(void)playVideoWithUrl:(NSString *)url;
@end
