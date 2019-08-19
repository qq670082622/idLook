//
//  SearchStrucM.m
//  IDLook
//
//  Created by HYH on 2018/5/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SearchStrucM.h"

@implementation SearchStrucM

-(NSArray*)getArtistArrayWithType:(ArtistType)type
{
    NSArray *array= [NSArray array];
    
    if (type==ArtistTypeMale)
    {
        array=@[@"阳光",@"成熟",@"暖男",@"型拽",@"文艺",@"活力",@"平凡屌",@"喜萌"];
    }
    else if (type==ArtistTypeFemale)
    {
        array=@[@"清甜",@"性感",@"知性",@"温暖",@"呆萌",@"型拽",@"平凡屌",@"活力"];

    }
    else if (type==ArtistTypeOld)
    {
        array=@[@"慈祥型",@"威严型",@"文化型",@"型拽型",@"呆萌型",@"帅气型",@"福气型",@"活力型"];

    }
    else if (type==ArtistTypeYoung)
    {
        array=@[@"甜甜的",@"帅帅的",@"萌萌的",@"王子公主的",@"清新的",@"活泼的",@"喜感的",@"型拽的"];

    }
    else if (type==ArtistTypeStar)
    {
        array=@[@"男明星",@"女明星",@"小鲜女",@"小鲜肉"];

    }
    else if (type==ArtistTypeInternetcelebrity)
    {
        array=@[@"美妆服饰",@"美食快消",@"健身运动",@"家居母婴",@"摄影旅行",@"金融财经",@"文学教育",@"情感咨询",@"动漫游戏",@"时尚娱乐"];

    }
    else if (type==ArtistTypeWrists)
    {
        array=@[@"体操",@"游泳",@"田径",@"乒乓",@"排球",@"羽毛球",@"网球",@"篮球",@"足球",@"举重",@"击剑",@"滑冰",@"滑雪",@"健美操",@"高尔夫"];
    }
    return array;
}

+(NSString *)getArtistTypeWithType:(ArtistType)type
{
    switch (type) {
        case ArtistTypeMale:
            return @"视频演员";
            break;
        case ArtistTypeFemale:
            return @"平面演员";
            break;
        case ArtistTypeOld:
            return @"活动模特";
            break;
        case ArtistTypeYoung:
            return @"舞蹈特技";
            break;
        case ArtistTypeStar:
            return @"明星";
            break;
        case ArtistTypeInternetcelebrity:
            return @"网红";
            break;
        case ArtistTypeWrists:
            return @"运动腕";
            break;
            
        default:
            return @"";
            break;
    }
}

-(NSArray*)getConditionArrayWithType:(ArtistType)type
{
    NSArray * array1 = @[@{@"title":@"年龄",@"type":@(SearchConditionTypeAge)},
                        @{@"title":@"价格",@"type":@(SearchConditionTypePrice)},
                        @{@"title":@"城市",@"type":@(SearchConditionTypeCity)},
                        @{@"title":@"类型",@"type":@(SearchConditionTypeType)},];
    
    NSArray * array2 = @[@{@"title":@"价格",@"type":@(SearchConditionTypePrice)},
                         @{@"title":@"城市",@"type":@(SearchConditionTypeCity)},
                         @{@"title":@"类型",@"type":@(SearchConditionTypeType)},];
    
    if (type==ArtistTypeMale)
    {
       return array1;
    }
    else if (type==ArtistTypeFemale)
    {
        return array1;
    }
    else if (type==ArtistTypeOld)
    {
       return array2;
    }
    else if (type==ArtistTypeYoung)
    {
        return array2;
    }
    else if (type==ArtistTypeStar)
    {
        return array2;
    }
    else if (type==ArtistTypeInternetcelebrity)
    {
         return array2;
    }
    else if (type==ArtistTypeWrists)
    {
         return array2;
    }
    
    return nil;
}

-(CGFloat)heightOfHeadViewWithType:(ArtistType)type
{
    NSArray *array = [self getArtistArrayWithType:type];
    
    CGFloat height ;
    
    NSInteger count = array.count;
    if (count%4==0) {
        height = (count/4)*44;
    }
    else
    {
        height = (count/4+1)*44;
    }
    
    return height+45+12;
}

-(NSArray*)getConditionArrayWithType:(ArtistType)type withSearchConditionType:(SearchConditionType)subType
{
    NSArray *array;
    
    //年龄
    if (subType == SearchConditionTypeAge) {
        array=@[@"12～16岁",@"17～20岁",@"21～25岁",@"26～30岁",@"31～40岁",@"41～45岁",@"46～55岁"];
    }
    //价格
    else if (subType == SearchConditionTypePrice)
    {
        array=@[@"2000元以内",@"2000～5000元",@"5000～10000元",@"10000～20000元",@"20000～50000元",@"50000元以上"];

    }
    //城市
    else if (subType == SearchConditionTypeCity)
    {
        array=@[@"北京",@"上海",@"天津",@"重庆",@"苏州",@"杭州",@"南京"];

    }
    //类型
    else if (subType == SearchConditionTypeType)
    {
        array=@[@{@"title":@"视频类型",@"type":@[@"TVC影视广告",@"Video宣传片",@"微电影广告"]},
                @{@"title":@"平面类型",@"type":@[@"平面设计",@"内部宣传",@"产品包装"]},
                @{@"title":@"活动类型",@"type":@[@"年会",@"车展",@"走秀",@"路演",@"庆典"]}];
    }
    
    return array;
}

@end
