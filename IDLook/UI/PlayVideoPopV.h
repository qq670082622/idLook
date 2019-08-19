//
//  PlayVideoPopV.h
//  HYHexample
//
//  Created by HYH on 16/8/16.
//  Copyright © 2016年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayVideoPopV : UIView

@property (nonatomic, copy) NSString *videoUrl;

- (void)play;

-(void)pause;

- (void)destroyPlayer;

-(void)show;

@end
