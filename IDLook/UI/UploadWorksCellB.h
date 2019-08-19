//
//  UploadWorksCellB.h
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSubButton.h"

@protocol UploadWorksCellBDelegate <NSObject>
-(void)addVideoAndPhotoWithType:(NSInteger)type;

@end

@interface UploadWorksCellB : UITableViewCell
@property(nonatomic,weak)id<UploadWorksCellBDelegate>delegate;
@property(nonatomic,strong)AddSubButton *addBtn;

-(void)reloadUIType:(WorkType)type withImage:(UIImage*)image withTime:(NSString*)time;

@end
