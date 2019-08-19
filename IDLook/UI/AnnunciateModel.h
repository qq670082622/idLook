//
//  AnnunciateModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnunciateModel : NSObject
@property(nonatomic,assign)NSInteger id; //= 2;
@property(nonatomic,assign)NSInteger priceEnd;// = 0;
@property(nonatomic,assign)NSInteger priceStart;// = 0;
@property(nonatomic,strong)NSArray *roleList; //= "\U5973\U4e3b\U3001\U7f57\U4f2f\U7279";
@property(nonatomic,copy)NSString *roleListString;
@property(nonatomic,copy)NSString *shotCity;// = "\U5317\U4eac";
@property(nonatomic,assign)NSInteger shotCycle;// = 3;
@property(nonatomic,assign)NSInteger shotDays; //= 3;
@property(nonatomic,copy)NSString *shotEndDate;// = "2019-05-06";
@property(nonatomic,copy)NSString *shotRegion;// = "\U4e2d\U56fd\U5927\U9646";
@property(nonatomic,copy)NSString *shotStartDate; //= "2019-05-04";
@property(nonatomic,copy)NSString *title;// = "\U5317\U4eac\U67d0\U54c1\U724c\U6c7d\U8f66\U5e7f\U544a";
@property(nonatomic,assign)NSInteger browseCount;//浏览次数
@property(nonatomic,assign)NSInteger applyCount;//报名次数
@end

NS_ASSUME_NONNULL_END
