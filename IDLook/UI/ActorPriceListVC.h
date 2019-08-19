//
//  ActorPriceListVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/5/29.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetialInfoM.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ActorPriceListVCDelegate <NSObject>

-(void)selectPrices:(NSArray *)prices andYear:(NSInteger)year andRegion:(NSInteger)region andYidi:(NSInteger)yidi andTotal_vip:(NSInteger)total_vip andTotalNormal:(NSInteger)totalNormal;

@end
@interface ActorPriceListVC : UIViewController
/*******需要传的参数*******/
@property(nonatomic,assign)NSInteger actorId;
@property(nonatomic,copy)NSString *projectId;//没有传"",但要传UserDetialInfoM
@property (nonatomic,strong) UserDetialInfoM *info;
@property(nonatomic,strong)NSArray *selectArr;//选择了哪些拍摄项目 装AskCalendarPriceModel 的数组 没有就传空数组[NSArray new]

@property(nonatomic,assign)NSInteger pushType;//进来的方式 1从演员主页的报价选择进来 2从演员主页询档按钮进来 3从询档页面里的报价选择进来
/*******传回去的参数*******/
@property(nonatomic,weak)id<ActorPriceListVCDelegate>delegate;
@property(nonatomic,assign)NSInteger year;//几年
@property(nonatomic,assign)NSInteger region;//使用范围
@property(nonatomic,assign)NSInteger yidi;//上午下午
@property(nonatomic,strong)NSMutableArray *selectPrice;
@end

NS_ASSUME_NONNULL_END
