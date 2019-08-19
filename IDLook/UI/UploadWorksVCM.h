//
//  UploadWorksVCM.h
//  IDLook
//
//  Created by HYH on 2018/6/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UploadSubCellAWidth (UI_SCREEN_WIDTH-4*10)/3

extern NSString * const UploadWorksVCMCellClass;    //cell类名_键
extern NSString * const UploadWorksVCMCellHeight;   //cell高度_键
extern NSString * const UploadWorksVCMCellType;     //cell类型_键
extern NSString * const UploadWorksVCMCellData;     //cell数据_键


@interface UploadWorksVCM : NSObject
@property (nonatomic,strong)NSMutableArray *ds;
@property (nonatomic,copy)void(^refreshUIAction)(void);  //刷新数据

-(void)refreshDataWithType:(WorkType)type;

//添加图片时改变高度
-(void)changeHeightWithPhotos:(NSArray*)photos;

//添加单张图片，视频时改变数据源  
-(void)addVideoOrPhotoChangeData:(UIImage*)image withTime:(NSString*)time withType:(WorkType)type;

@end
