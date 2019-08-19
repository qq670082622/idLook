//
//  CheckGradeModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//查看评价页面model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckGradeModel : NSObject


@property (strong, nonatomic)NSArray *gradeStrings;//评价标签内容

@property (assign, nonatomic)NSInteger actingPower;//": 0,
@property (assign, nonatomic)NSInteger anonymous;// "1:不匿名; 2:匿名",
@property (assign, nonatomic)NSInteger buyerId;// 0,
@property (assign, nonatomic)NSInteger coordination;// 0, 配合度
@property (assign, nonatomic)NSInteger favor;//0,
@property (assign, nonatomic)NSInteger id;// 0,
@property (copy, nonatomic)NSString *inputTime;// "string",
@property (assign, nonatomic)NSInteger level;//"1,好评，2中评，3差评",
@property (assign, nonatomic)NSInteger performance;// 0, 性价比
@property (strong, nonatomic)NSDictionary *actorInfo;
@property (copy, nonatomic)NSString *comment;
@property (strong, nonatomic)NSDictionary *userBriefInfo;
//"actorInfo": {
//    "actorHead": "string",
//    "actorId": 0,
//    "actorName": "string",
//    "masteryName": "string",
//    "performType": "如：甜美|气质|动感",
//    "region": "string",
//    "sex": "1=男;2=女"
//},

@end

NS_ASSUME_NONNULL_END
