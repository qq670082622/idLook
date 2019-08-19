//
//  PhotoM.m
//  miyue
//
//  Created by wsz on 16/5/9.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import "PhotoM.h"

@implementation PhotoM

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        self.fid = [(NSNumber *)safeObjectForKey(dic, @"id") integerValue];
        self.origin = (NSString *)safeObjectForKey(dic, @"image");
        self.thumb = (NSString *)safeObjectForKey(dic, @"thumb");
        self.blurOrigin = (NSString *)safeObjectForKey(dic, @"");
        self.blurThumb = (NSString *)safeObjectForKey(dic, @"");
        self.favorate = [(NSNumber *)safeObjectForKey(dic, @"like") integerValue];
        self.lock=[(NSNumber*)safeObjectForKey(dic, @"lock") integerValue];
        self.status=[(NSNumber*)safeObjectForKey(dic, @"status") integerValue];

    }
    return self;
}

+ (NSArray *)photoModelArray:(NSArray *)array
{
    NSMutableArray *dataSource = [NSMutableArray array];
    for(id obj in array)
    {
        if([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = (NSDictionary *)obj;
            
            [dataSource addObject:[[PhotoM alloc] initWithDic:dic]];
        }
    }
    return dataSource;
}



+ (void)addPhotoToUserDefault:(NSDictionary *)dic
{
    //查看是否有相投的fid 如果有则先删除
    
//    NSInteger fid = [(NSNumber *)safeObjectForKey(dic, @"id") integerValue];
//    [PhotoM deletePhotoFromUserDefault:fid];
    
//    NSArray *arr = [UserInfoManager getUserPhotos];
//    NSMutableArray *mutiArr = [NSMutableArray arrayWithArray:arr];
//    [mutiArr addObject:dic];
//    [UserInfoManager setUserPhotos:mutiArr];
}


@end
