//
//  HomeService.h
//  IDLook
//
//  Created by HYH on 2018/5/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeMainVCM.h"
#import "UserModel.h"
@protocol HomeServiceDelegate <NSObject>
@optional
-(void)didClick1WithType:(NSInteger)type;
-(void)didClick2WithType:(NSInteger)type;

//进入用户主页
-(void)didClickUser:(UserModel*)info withSelect:(NSString*)select;

//更多推荐
-(void)entryMoreRecommend;

//查看报价
-(void)lookUserPriceInfo:(UserModel*)info;

//播放视频
-(void)playVideoWithModel:(WorksModel*)model withIndexPath:(NSIndexPath*)indexPath andPage:(NSInteger)page;

//查看大图
-(void)lookPictureWithModel:(WorksModel*)model withIndexPath:(NSIndexPath*)indexPath andPage:(NSInteger)page;
//停止滑动
-(void)endDeceleratingPlay;

//滑出屏幕
-(void)scrollUpScreen;

//结束滑动
-(void)scrollViewEndScrollView;

//进入广告，影视，外籍模特页面
-(void)clickEntryVideoWithType:(NSInteger)type;

@end

@interface HomeService : NSObject <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)id<HomeServiceDelegate>delegate;
@property(nonatomic,strong)HomeMainVCM *dsm;
@end
