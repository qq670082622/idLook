//
//  WorksModel.m
//  IDLook
//
//  Created by HYH on 2018/5/30.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "WorksModel.h"

@implementation WorksModel

//作品数据解析
-(id)initWithWorksDic:(NSDictionary*)dic
{
    if (self=[super init]) {
        
        self.keyword = (NSString*)safeObjectForKey(dic, @"keyword");
        self.cutvideo = (NSString*)safeObjectForKey(dic, @"cutvideo");
        self.video = (NSString*)safeObjectForKey(dic, @"workvideourl");
        self.type = (NSString*)safeObjectForKey(dic, @"workvideotype");
        self.title = (NSString*)safeObjectForKey(dic, @"title");
        self.role = [(NSNumber*)safeObjectForKey(dic, @"filmactorrole") integerValue];

        self.creativeid    = [NSString stringWithFormat:@"%ld",(long)[(NSNumber *)safeObjectForKey(dic, @"creativeid") integerValue]];
        
        int time =  [(NSNumber*)safeObjectForKey(dic, @"timevideo") intValue];
        self.timevideo = [PublicManager timeFormatted:time];
        self.status=-1;
        self.status =  [(NSNumber*)safeObjectForKey(dic, @"status") integerValue];
        
        self.bitrate =  [(NSNumber*)safeObjectForKey(dic, @"bitrate") floatValue];
        self.size =  [(NSNumber*)safeObjectForKey(dic, @"size") floatValue];
        self.widthpx =[(NSNumber*)safeObjectForKey(dic, @"widthpx") floatValue];
        self.heightpx =[(NSNumber*)safeObjectForKey(dic, @"heightpx") floatValue];
        self.format = (NSString*)safeObjectForKey(dic, @"format");
    }
    return self;
}

-(id)initWithMirrDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        
        self.url = (NSString*)safeObjectForKey(dic, @"microworkurl");
        self.title = (NSString*)safeObjectForKey(dic, @"worktitle");
        self.microtype = [(NSNumber *)safeObjectForKey(dic, @"microtype") integerValue];
        self.cutvideo = (NSString*)safeObjectForKey(dic, @"cutvideo");
        self.creativeid    = [NSString stringWithFormat:@"%ld",(long)[(NSNumber *)safeObjectForKey(dic, @"creativeid") integerValue]];
        
        int time =  [(NSNumber*)safeObjectForKey(dic, @"timevideo") intValue];
        self.timevideo = [PublicManager timeFormatted:time];
        
        self.bitrate =  [(NSNumber*)safeObjectForKey(dic, @"bitrate") floatValue];
        self.size =  [(NSNumber*)safeObjectForKey(dic, @"size") floatValue];
        self.widthpx =[(NSNumber*)safeObjectForKey(dic, @"widthpx") floatValue];
        self.heightpx =[(NSNumber*)safeObjectForKey(dic, @"heightpx") floatValue];
        self.format = (NSString*)safeObjectForKey(dic, @"format");
        self.status =  [(NSNumber*)safeObjectForKey(dic, @"status") integerValue];
        
    }
    return self;
}

//过往作品
-(id)initWithPastWorkDic:(NSDictionary*)dic
{
    if (self=[super init]) {
        self.video = (NSString*)safeObjectForKey(dic, @"pturl");
        self.url = (NSString*)safeObjectForKey(dic, @"pturl");
        self.title = (NSString*)safeObjectForKey(dic, @"title");
        self.microtype = [(NSNumber *)safeObjectForKey(dic, @"type") integerValue];
        self.cutvideo = (NSString*)safeObjectForKey(dic, @"cutvideo");
        self.creativeid    = [NSString stringWithFormat:@"%ld",(long)[(NSNumber *)safeObjectForKey(dic, @"creativeid") integerValue]];
        self.type = (NSString*)safeObjectForKey(dic, @"producetype");
        self.keyword = (NSString*)safeObjectForKey(dic, @"keyword");
        self.role = [(NSNumber*)safeObjectForKey(dic, @"filmactorrole") integerValue];

        int time =  [(NSNumber*)safeObjectForKey(dic, @"timevideo") intValue];
        self.timevideo = [PublicManager timeFormatted:time];
        
        self.bitrate =  [(NSNumber*)safeObjectForKey(dic, @"bitrate") floatValue];
        self.size =  [(NSNumber*)safeObjectForKey(dic, @"size") floatValue];
        self.widthpx =[(NSNumber*)safeObjectForKey(dic, @"widthpx") floatValue];
        self.heightpx =[(NSNumber*)safeObjectForKey(dic, @"heightpx") floatValue];
        self.format = (NSString*)safeObjectForKey(dic, @"format");
        self.status =  [(NSNumber*)safeObjectForKey(dic, @"status") integerValue];
        
    }
    return self;
}

//解析模特卡
-(id)initModelCardDic:(NSDictionary*)dic
{
    if (self=[super init]) {
        self.cutvideo = (NSString*)safeObjectForKey(dic, @"cutvideo");
        self.video = (NSString*)safeObjectForKey(dic, @"video");
        self.imageurl = (NSString*)safeObjectForKey(dic, @"image");
        self.keyword = (NSString*)safeObjectForKey(dic, @"keyword");
        self.role = [(NSNumber*)safeObjectForKey(dic, @"filmactorrole") integerValue];

        self.creativeid    = [NSString stringWithFormat:@"%ld",(long)[(NSNumber *)safeObjectForKey(dic, @"creativeid") integerValue]];
        
        int time =  [(NSNumber*)safeObjectForKey(dic, @"timevideo") intValue];
        self.timevideo = [PublicManager timeFormatted:time];
        
        self.type = (NSString*)safeObjectForKey(dic, @"type");
        
        self.status=-1;
        self.status =  [(NSNumber*)safeObjectForKey(dic, @"status") integerValue];
    }
    return self;
}

@end
