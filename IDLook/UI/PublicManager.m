//
//  PublicManager.m
//  IDLook
//
//  Created by HYH on 2018/5/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PublicManager.h"

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

@implementation PublicManager

+(NSArray*)getPickerDataWithType:(PickerType)type
{
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
    
    if (type==PickerTypeHeight) {
        for (int i = 20  ; i<=260; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    else if (type==PickerTypeWeight)
    {
        for (int i = 10  ; i<=120; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    else if (type==PickerTypeBust)
    {
        for (int i = 0  ; i<=200; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [array addObject:@"暂不填写"];
    }
    
    else if (type==PickerTypeWaist)
    {
        for (int i = 0  ; i<=200; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [array addObject:@"暂不填写"];

    }
    
    else if (type==PickerTypeHipline)
    {
        for (int i = 0  ; i<=200; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [array addObject:@"暂不填写"];
    }
    
    else if (type==PickerTypeShoeSize)
    {
        for (int i = 15  ; i<=50; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else if (type==PickerTypeOccupation) //职业
    {
        
        NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"occupationType"];
        for (int i=0; i<array1.count; i++) {
            NSDictionary *dic = array1[i];
            [array addObject:dic[@"attrname"]];
        }        
    }
    else if (type==PickerTypeSchool)
    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"School" ofType:@"plist"];
        NSArray *Arr= [[NSArray alloc] initWithContentsOfFile:plistPath];
        
        [array addObjectsFromArray:Arr];
    }
    else if (type==PickerTypeGrade)
    {
        NSInteger year = [self getYearWithDate:[NSDate date]];
        for (int i = 1949  ; i<=year; i++) {
            [array addObject:[NSString stringWithFormat:@"%d级",i]];
        }
        [array addObject:@"暂不填写"];
    }
    else if (type==PickerTypeMajor)
    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Major" ofType:@"plist"];
        NSArray *Arr= [[NSArray alloc] initWithContentsOfFile:plistPath];
        
        [array addObjectsFromArray:Arr];

    }
    else if (type==PickerTypeSex)
    {
        [array addObjectsFromArray:@[@"男",@"女"]];
    }
    else if (type==PickerTypeNationality)
    {
        [array addObjectsFromArray:@[@"中国",@"日本",@"韩国",@"美国",@"其他"]];

    }
    else if (type==PickerTypeLanguage)
    {
        [array addObjectsFromArray:@[@"中文",@"英语",@"日语",@"法语",@"德语",@"俄语",@"拉丁语",@"阿拉伯语",@"泰语",@"韩语",@"其他"]];
    }
    else if (type==PickerTypeRegion)
    {
        [array addObjectsFromArray:@[@"上海",@"北京",@"其他"]];
    }
    else if (type==PickerTypeTrade)
    {
        [array addObjectsFromArray:@[@"影视制作",@"平面摄影",@"广告代理",@"公关咨询",@"活动策划",@"品牌企业",@"其他"]];
    }
    else if (type==PickerTypePostion)
    {
        [array addObjectsFromArray:@[@"制作经理",@"制片",@"制作助理",@"导演",@"Free制片",@"采购人员",@"其他"]];
    }
    else if (type==PickerTypeMastery)
    {
        NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"masteryType"];
        for (int i=0; i<array1.count; i++) {
            NSDictionary *dic = array1[i];
            [array addObject:dic[@"attrname"]];
        }
    }
    return array;
}


+(NSArray*)getOrderCellType:(OrderCheckType)type;
{
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
    NSDictionary *dic=[UserInfoManager getPublicConfig];

    if (type==OrderCheckTypeShotType) {   //广告类别
            
        [array addObject:@{@"title":@"视频广告",@"data":dic[@"adVideoType"]}];
        [array addObject:@{@"title":@"平面广告",@"data":dic[@"adPrintType"]}];
        [array addObject:@{@"title":@"活动广告",@"data":dic[@"adActivityType"]}];

    }
    
    if (type==OrderCheckTypeDays) {   //拍摄天数
        [array addObjectsFromArray:@[@"1天",@"2天",@"3天",@"4天",@"5天"]];
    }
    else if (type==OrderCheckTypePortraitCycle || type==OrderCheckTypeMaterialCycle ||type==OrderCheckTypeRenewalCycle)  //肖像周期,素材使用周期，续约周期
    {
        [array addObjectsFromArray:@[@"1年",@"2年",@"3年",@"4年",@"5年"]];

    }
    else if (type==OrderCheckTypePortraitRange || type==OrderCheckTypeRenewalRange)   //肖像范围，续约范围
    {
        [array addObjectsFromArray:@[@"中国大陆",@"港澳台",@"海外其他"]];

    }
    else if (type==OrderCheckTypeMirrCycle)    //微出镜周期
    {
        [array addObjectsFromArray:@[@"周出镜",@"月出镜",@"季出镜",@"半年出镜"]];

    }
    else if (type==OrderCheckTypeMirrRegion||type==OrderCheckTypeMaterialRegion)   //微出镜区域，素材使用区域
    {
        [array addObjectsFromArray:@[@"中国大陆全区域",@"港澳台",@"海外其他",@"独家买断",@"选择省市"]];

    }
    else if (type==OrderCheckTypeMirrRange)   //微出镜范围
    {
        [array addObjectsFromArray:@[@"TVC电视",@"平面KV",@"杂志",@"海报",@"微博",@"微信公众号",@"报纸",@"DM",@"企业官网",@"门店展示",@"活动现场",@"电梯",@"地铁",@"公交车",@"车身广告",@"其他"]];

    }
    else if (type==OrderCheckTypeMaterialRange)   //素材使用范围
    {
        [array addObjectsFromArray:@[@"TVC电视",@"网络电视",@"微博",@"微信公众号",@"企业官网",@"门店展示",@"楼宇电梯",@"地铁",@"公交车"   ,@"其他"]];
    }
    
    return array;
}

+(UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

+(int)getVideoLength:(NSURL *)path
{
    AVURLAsset * asset = [AVURLAsset assetWithURL:path];
    CMTime   time = [asset duration];
    int seconds = ceil(time.value/time.timescale);
    return seconds;
}

+ (NSString *)convertTime:(CGFloat)second {
    // 相对格林时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (second / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    
    NSString *showTimeNew = [formatter stringFromDate:date];
    return showTimeNew;
}

//
+ (void)forceOrientation:(UIInterfaceOrientation)orientation {
    // setOrientation: 私有方法强制横屏
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

//
+ (BOOL)isOrientationLandscape {
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return YES;
    } else {
        return NO;
    }
}


//时间转化为实践戳
+(NSInteger)getDataTimeString:(NSString*)str
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:str]; //------------将字符串按formatter转成nsdate
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
    
    //时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return [date timeIntervalSince1970];
}

+ (NSString *)string1FromDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)string2FromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString*)getTimeWithNowDateWithDay:(NSInteger)day
{
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    if(day!=0)
    {
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*day ];
    }
    else
    {
        theDate = nowDate;
    }
    return [self string1FromDate:theDate];
}

//根据日期得到月份
+ (NSInteger)getMonthWithDate:(NSDate*)date
{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:date];
    
    return comp.month;
}

//比较两个日期
+ (int)compareOneDay:(NSString *)currentDay withAnotherDay:(NSString *)BaseDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateA = [dateFormatter dateFromString:currentDay];
    NSDate *dateB = [dateFormatter dateFromString:BaseDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

//根据日期得到年份
+ (NSInteger)getYearWithDate:(NSDate*)date
{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:date];
    
    return comp.year;
}

+ (NSDate *)dateFromString1:(NSString *)string
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[format dateFromString:string];
    return date;
}

+ (NSDate *)dateFromString2:(NSString *)string
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date=[format dateFromString:string];
    return date;
}

+ (NSString *)timeFormatted:(int)totalSeconds {
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
//    int hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

+ (SourceType)getSourceTypeWithUrl:(NSString *)url
{
    //获取文件后缀名
    NSString *suffix = [url pathExtension];
    
    SourceType type=-1;
    
    NSArray *array1=@[@"jpg",@"png",@"jpeg"];
    for (int i=0; i<array1.count; i++) {
        if ([suffix isEqualToString:array1[i]]) {
            type=SourceTypePhoto;
        }
    }
    
    NSArray *array2=@[@"avi",@"wmv",@"mpeg",@"mp4",@"mov",@"mkv",@"flv",@"f4v",@"m4v",@"rmvb",@"rm",@"3gp"];
    for (int i=0; i<array2.count; i++) {
        if ([suffix isEqualToString:array2[i]]) {
            type=SourceTypeVideo;
        }
    }
    
    return type;
}

//去掉小数后面无效的0
+ (NSString *)changeFloatWithFloat:(CGFloat)floatValue
{
    return [self changeFloatWithString:[NSString stringWithFormat:@"%f",floatValue]];
}

+ (NSString *)changeFloatWithString:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    
    if ([returnString floatValue]==0) {
        return @"";
    }
    return returnString;
}

+ (UIImage *)scaleImageWithSize:(NSInteger)maxLength image:(UIImage *)image{
  CGFloat compression = 1;
   // maxLength = 1000;
        NSData *data = UIImageJPEGRepresentation(image, compression);
        if (data.length/1000 < maxLength) return image;
        UIImage *resultImage = [UIImage imageWithData:data];
        // Compress by size
        NSUInteger lastDataLength = 0;
        while (data.length/1000 > maxLength && data.length/1000 != lastDataLength) {
            lastDataLength = data.length/1000;
            CGFloat ratio = (CGFloat)maxLength / (data.length/1000);
            //NSLog(@"Ratio = %.1f", ratio);
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                     (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
            UIGraphicsBeginImageContext(size);
            [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            data = UIImageJPEGRepresentation(resultImage, compression);
            //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
        }
        //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
        NSLog(@"最后压缩大小为:%ld",data.length/1000);
        return [UIImage imageWithData:data];
    }

+ (NSMutableDictionary *)deleteAllNullValueFrom:(NSMutableDictionary *)beforeDic
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in beforeDic.allKeys) {
        NSString *value = [beforeDic objectForKey:keyStr];
        if ([value isKindOfClass:[NSString class]] && value.length>0) {
           [mutableDic setObject:[beforeDic objectForKey:keyStr] forKey:keyStr];
        }
      }
   return mutableDic;
}
@end
