//
//  GradeModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/21.
//  Copyright © 2019年 HYH. All rights reserved.
//评价页面model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradeModel : NSObject
@property(nonatomic,copy)NSString *actorName;
@property(nonatomic,assign)NSInteger actorId;
@property(nonatomic,copy)NSString *actorUrl;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,assign)NSInteger sex;//性别
@property(nonatomic,copy)NSString *city;//地方
@property(nonatomic,assign)NSInteger gradeLevel;//差 一般。好 3,2,1
@property(nonatomic,strong) NSArray *gradeAllStrings;//总共的标签(里面装n个array)
@property(nonatomic,strong) NSMutableArray *gradeStrings;//标签//选中的标签
@property(nonatomic,assign)NSInteger pricePower;//性价比
@property(nonatomic,assign)NSInteger actPower;//表演力
@property(nonatomic,assign)NSInteger matchPower;//配合度
@property(nonatomic,assign)NSInteger feeling;//好感度
@property(nonatomic,assign)BOOL anonymity;//匿名
@property(nonatomic,strong)NSIndexPath *indexPath;//model在table第几行
@property(nonatomic,copy)NSString *gradeText;
@end

NS_ASSUME_NONNULL_END

