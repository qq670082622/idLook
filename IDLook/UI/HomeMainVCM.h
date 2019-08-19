//
//  HomeMainVCM.h
//  IDLook
//
//  Created by HYH on 2018/7/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kHomeVCMCellClass;    //cell类名_键
extern NSString * const kHomeVCMCellHeight;   //cell高度_键
extern NSString * const kHomeVCMCellData;     //cell数据_键
extern NSString * const kHomeVCMCellType;     //cell类型_键

@interface HomeMainVCM : NSObject

@property (nonatomic,copy)void(^newDataNeedRefreshed)(BOOL success);

@property (nonatomic,copy)void(^refreshBanner)(BOOL success);

@property (nonatomic,strong)NSMutableArray *ds;

@property (nonatomic,strong)NSArray *bannerArray;


-(void)refreshHomeInfoWithSortPage:(NSInteger)sortpage withRefreshType:(RefreshType)type;

@end
