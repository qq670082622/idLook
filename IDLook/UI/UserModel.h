//
//  ActorModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
@property(nonatomic,copy)NSString *actorHeadMini;
@property(nonatomic,copy)NSString *actorHeadPorUrl;
@property(nonatomic,copy)NSString *actorName;
@property(nonatomic,copy)NSString *actorNickname;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *actorRegion;
@property(nonatomic,copy)NSString *region;
@property(nonatomic,copy)NSString *actorPerformType;
@property(nonatomic,assign)NSInteger sex;
@property(nonatomic,assign)NSInteger actorStudio;
@property(nonatomic,assign)NSInteger collect;
@property(nonatomic,assign)NSInteger praise;
@property(nonatomic,assign)NSInteger startPrice;
@property(nonatomic,assign)NSInteger startPriceVip;
@property(nonatomic,assign)NSInteger actorId;
@property(nonatomic,assign)NSInteger userId;
@property(nonatomic,assign)NSInteger sortpage;
@property(nonatomic,strong)NSArray *showList;
@property(nonatomic,assign)NSInteger mastery;
@property(nonatomic,assign)NSInteger actorOccupation;
@end

NS_ASSUME_NONNULL_END
