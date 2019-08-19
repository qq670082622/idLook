//
//  PhotoM.h
//  miyue
//
//  Created by wsz on 16/5/9.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoM : NSObject

@property (nonatomic,assign)NSInteger fid;         //相片ID

@property (nonatomic,copy)NSString *origin;        //原图
@property (nonatomic,copy)NSString *thumb;         //缩略图
@property (nonatomic,copy)NSString *blurOrigin;    //高斯原图
@property (nonatomic,copy)NSString *blurThumb;     //高斯缩略图

@property (nonatomic,assign)NSInteger lock;       //是否加锁

@property (nonatomic,assign)NSInteger favorate;    //被赞次数

@property (nonatomic,assign)NSInteger status;    //审核状态

- (id)initWithDic:(NSDictionary *)dic;

+ (NSArray *)photoModelArray:(NSArray *)array;


//从归档增加一张相片
+ (void)addPhotoToUserDefault:(NSDictionary *)dic;

@end
