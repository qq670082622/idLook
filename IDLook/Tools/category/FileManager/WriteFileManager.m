//
//  WriteFileManager.m
//  hishow
//
//  Created by Chard on 15/3/14.
//  Copyright (c) 2015年 haixun. All rights reserved.
//

#import "WriteFileManager.h"

@implementation WriteFileManager

+ (NSArray *)saveFileWithArray:(NSArray *)array Name:(NSString *)name
{
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    
    [array writeToFile:filePath atomically:YES];
    return array;
}


+ (NSArray *)readFielWithName:(NSString *)name
{
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    return data;
}


//-----wm
+ (NSMutableArray *)WMsaveData:(NSMutableArray *)array name:(NSString *)name{
  
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    
    [array writeToFile:filePath atomically:YES];
    return array;

}


+ (NSMutableArray *)WMreadData:(NSString *)name{
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    
    NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile:filePath];
    return data;

}


//-------wm

// 模型存储
+ (void)saveObject:(id)object name:(NSString *)name {
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:name];
    [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}

+ (id)readObject:(NSString *)name {
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:name];
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return object;
}

+ (void)saveData:(NSArray *)array name:(NSString *)name {
   // NSString *name2 = [NSString stringWithFormat:@"%@%@",name,[self userDefaultForKey:@"Name"]];
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:name];
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
}

+ (NSArray *)readData:(NSString *)name {
  //  NSString *name2 = [NSString stringWithFormat:@"%@%@",name,[self userDefaultForKey:@"Name"]];
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:name];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return arr;
}

//userDefault
+(NSString *)userDefaultForKey:(NSString *)key
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *str;
    if (![key isEqualToString:@"Name"] ) {
        NSString *newKey = [NSString stringWithFormat:@"%@%@",[self userDefaultForKey:@"Name"],key];
        str = [def objectForKey:newKey];
    }else{
        str = [def objectForKey:key];
    }
   
    [def synchronize];
    return str;
    
}
+(void)userDefaultSetObj:(NSString *)obj WithKey:(NSString *)key
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if (![key isEqualToString:@"Name"] ) {
        NSString *newKey = [NSString stringWithFormat:@"%@%@",[self userDefaultForKey:@"Name"],key];
        [def setObject:obj forKey:newKey];
    }else{
     [def setObject:obj forKey:key];
    }
   
   
    [def synchronize];
  
}

// 保存图片
+ (BOOL)saveImageToCacheDir:(NSString *)directoryPath image:(UIImage *)image imageName:(NSString *)imageName imageType:(NSString *)imageType
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    bool isSaved = false;
    if ( isDir == YES && existed == YES )
    {
        if ([[imageType lowercaseString] isEqualToString:@"png"])
        {
            isSaved = [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
        }
        else if ([[imageType lowercaseString] isEqualToString:@"jpg"] || [[imageType lowercaseString] isEqualToString:@"jpeg"])
        {
            isSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
        }
        else
        {
            NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", imageType);
        }
    }
    return isSaved;
}



// 读取图片
+ (NSData *)loadImageData:(NSString *)directoryPath imageName:(NSString *)imageName
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( isDir == YES && dirExisted == YES )
    {
        NSString *imagePath = [directoryPath stringByAppendingString : imageName];
        BOOL fileExisted = [fileManager fileExistsAtPath:imagePath];
        if (!fileExisted) {
            return NULL;
        }
        NSData *imageData = [NSData dataWithContentsOfFile : imagePath];
        return imageData;
    }
    else
    {
        return NULL;
    }
}
+(void)upDateModelsArrayWithModelArrayName:(NSString *)name andModel:(id)model
{
    NSMutableArray *models = [NSMutableArray arrayWithArray:[WriteFileManager readData:name]];
   // NSMutableArray *muArr = [NSMutableArray arrayWithArray:models];
    //[muArr addObject:model];
    [models insertObject:model atIndex:0];
    [self saveData:models name:name];
   // NSArray *test = [WriteFileManager readData:name];
}
@end
