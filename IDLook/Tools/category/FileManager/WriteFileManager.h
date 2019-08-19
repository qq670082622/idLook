//
//  WriteFileManager.h
//  hishow
//
//  Created by Chard on 15/3/14.
//  Copyright (c) 2015年 haixun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WriteFileManager : NSObject

// plist存储
+ (NSArray *)saveFileWithArray:(NSArray *)array Name:(NSString *)name;

+ (NSArray *)readFielWithName:(NSString *)name;
// plist储存 mutableArray
+ (NSMutableArray *)WMsaveData:(NSMutableArray *)array name:(NSString *)name;

+ (NSMutableArray *)WMreadData:(NSString *)name;
// 模型存储
+ (void)saveObject:(id)object name:(NSString *)name;
+ (id)readObject:(NSString *)name;

+ (void)saveData:(NSArray *)array name:(NSString *)name;

+ (NSArray *)readData:(NSString *)name;


//userDefault
+(NSString *)userDefaultForKey:(NSString *)key;
+(void)userDefaultSetObj:(NSString *)obj WithKey:(NSString *)key;


// 保存图片
+ (BOOL)saveImageToCacheDir:(NSString *)directoryPath image:(UIImage *)image imageName:(NSString *)imageName imageType:(NSString *)imageType;

// 读取图片
+ (NSData *)loadImageData:(NSString *)directoryPath imageName:(NSString *)imageName;

+(void)upDateModelsArrayWithModelArrayName:(NSString *)name andModel:(id)model;
@end
