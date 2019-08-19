//
//  LookImageCell.h
//  IDLook
//
//  Created by HYH on 2018/6/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoProgressV;

@interface LookImageCell : UIScrollView

@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,copy)void(^tapOnece)(void);
@property (nonatomic,copy)void(^tapTwice)(void);

- (void)checkHasLoadedOriginPhoto;

- (void)loadUIWithPhotoUrl:(NSString *)imageUrl
                  withRect:(CGRect)rect;

- (void)revoverToOriginRect;
@end

