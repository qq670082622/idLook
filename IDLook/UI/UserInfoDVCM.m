//
//  UserInfoDVCM.m
//  IDLook
//
//  Created by HYH on 2018/5/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserInfoDVCM.h"

NSString * const kUserInfoDVCMCellClass =  @"kUserInfoDVCMCellClass";
NSString * const kUserInfoDVCMCellHeight = @"kUserInfoDVCMCellHeight";
NSString * const kUserInfoDVCMCellType  = @"kUserInfoDVCMCellType";
NSString * const kUserInfoDVCMCellData  = @"kUserInfoDVCMCellData";


@implementation UserInfoDVCM

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(void)refreshUserInfo
{
    [self.ds removeAllObjects];
    
    NSMutableArray *sec0 = [NSMutableArray new];
    NSMutableArray *sec1 = [NSMutableArray new];
    NSMutableArray *sec2 = [NSMutableArray new];
    NSMutableArray *sec3 = [NSMutableArray new];
    NSMutableArray *sec4 = [NSMutableArray new];


    {
        [sec1 addObject:@{kUserInfoDVCMCellData:@[[NSString stringWithFormat:@"姓名：%@",[self dealNULLString:_info.actorName]],[NSString stringWithFormat:@"性别：%@",(_info.sex==1)?@"男":@"女"]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBasicinfo],
                             kUserInfoDVCMCellClass:@"BasicInfoCell",
                             kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        [sec1 addObject:@{kUserInfoDVCMCellData:@[[NSString stringWithFormat:@"国籍：%@",[self dealNULLString:_info.nationality]],[NSString stringWithFormat:@"语言：%@",[self dealNULLString:[_info.language stringByReplacingOccurrencesOfString:@"|" withString:@"、"]]]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBasicinfo],
                          kUserInfoDVCMCellClass:@"BasicInfoCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        
        NSString *birth = @"  -- ";
        if ([UserInfoManager getUserType]==UserTypePurchaser) {
            birth = [self dealNULLString:_info.birthday];
        }
        
        [sec1 addObject:@{kUserInfoDVCMCellData:@[[NSString stringWithFormat:@"所在地：%@",[self dealNULLString:_info.region]],[NSString stringWithFormat:@"生日：%@",birth]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBasicinfo],
                          kUserInfoDVCMCellClass:@"BasicInfoCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        [sec1 addObject:@{kUserInfoDVCMCellData:@[_info.height==0?@"身高：  --":[NSString stringWithFormat:@"身高：%ldcm",_info.height],_info.weight==0?@"体重：  --":[NSString stringWithFormat:@"体重：%ldkg",_info.weight]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBasicinfo],
                          kUserInfoDVCMCellClass:@"BasicInfoCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        [sec1 addObject:@{kUserInfoDVCMCellData:@[_info.chest==0?@"胸围：  --":[NSString stringWithFormat:@"胸围：%ldcm",_info.chest],_info.waist==0?@"腰围：  --":[NSString stringWithFormat:@"腰围：%ldcm",_info.waist]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBasicinfo],
                          kUserInfoDVCMCellClass:@"BasicInfoCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        [sec1 addObject:@{kUserInfoDVCMCellData:@[_info.hips==0?@"臀围：  --":[NSString stringWithFormat:@"臀围：%ldcm",_info.hips],_info.shoes==0?@"鞋码：  --":[NSString stringWithFormat:@"鞋码：%ld码",_info.shoes]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBasicinfo],
                          kUserInfoDVCMCellClass:@"BasicInfoCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
//        [sec1 addObject:@{kUserInfoDVCMCellData:@[[NSString stringWithFormat:@"微博名：%@",[self dealNULLString:_info.weiboName]]],
//                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBasicinfo],
//                          kUserInfoDVCMCellClass:@"BasicInfoCell",
//                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        [sec1 addObject:@{kUserInfoDVCMCellData:@[_info.weiboFans==0?@"微博粉丝数：  --": [NSString stringWithFormat:@"微博粉丝数：%@万",[PublicManager changeFloatWithFloat:_info.weiboFans]]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBasicinfo],
                          kUserInfoDVCMCellClass:@"BasicInfoCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
    }
    
    {
        NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"occupationType"];
        NSString *occoupation =@"";
        for (int i=0; i<array1.count; i++) {
            NSDictionary *dic = array1[i];
            if (_info.occupation == [dic[@"attrid"] integerValue]) {
                occoupation=dic[@"attrname"];
            }
        }
        
        [sec2 addObject:@{kUserInfoDVCMCellData:[NSString stringWithFormat:@"职        业：%@",[self dealNULLString:occoupation]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeSchool],
                          kUserInfoDVCMCellClass:@"GraduatedSchoolCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        [sec2 addObject:@{kUserInfoDVCMCellData:[NSString stringWithFormat:@"毕业院校：%@",[self dealNULLString:_info.academy]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeSchool],
                          kUserInfoDVCMCellClass:@"GraduatedSchoolCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        [sec2 addObject:@{kUserInfoDVCMCellData:[NSString stringWithFormat:@"入学年份：%@",[self dealNULLString:_info.grade]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeSchool],
                             kUserInfoDVCMCellClass:@"GraduatedSchoolCell",
                             kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];


        [sec2 addObject:@{kUserInfoDVCMCellData:[NSString stringWithFormat:@"专        业：%@", [self dealNULLString:_info.major]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeSchool],
                          kUserInfoDVCMCellClass:@"GraduatedSchoolCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
        
        NSString *str = [_info.performType stringByReplacingOccurrencesOfString:@"|" withString:@"、"];
        [sec2 addObject:@{kUserInfoDVCMCellData:[NSString stringWithFormat:@"擅长类型：%@",[self dealNULLString:str]],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeSchool],
                          kUserInfoDVCMCellClass:@"GraduatedSchoolCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:37]}];
        
    }
    
    {

        
        CGFloat height = [self heighOfString:_info.brief font:[UIFont systemFontOfSize:13.0] width:UI_SCREEN_WIDTH-30];
        
        [sec3 addObject:@{kUserInfoDVCMCellData:[NSString stringWithFormat:@"%@",_info.brief],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeBrief],
                             kUserInfoDVCMCellClass:@"BriefInfoCell",
                             kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:height+20]}];
    }
    
    {
        
        
        CGFloat height = [self heighOfString:_info.representativeWork font:[UIFont systemFontOfSize:13.0] width:UI_SCREEN_WIDTH-30];
        
        [sec4 addObject:@{kUserInfoDVCMCellData:[NSString stringWithFormat:@"%@",_info.representativeWork],
                          kUserInfoDVCMCellType:[NSNumber numberWithInteger:UserInfoCellDTypeWorks],
                          kUserInfoDVCMCellClass:@"BriefInfoCell",
                          kUserInfoDVCMCellHeight:[NSNumber numberWithFloat:height+20]}];
    }
    
    if (sec0.count) {
        [self.ds addObject:sec0];
    }
    
    [self.ds addObject:sec1];
    [self.ds addObject:sec2];
    [self.ds addObject:sec3];
    [self.ds addObject:sec4];

}

//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 10;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<20.0?20.0:ceilf(size.height);
}

//空字符串进行处理
-(NSString*)dealNULLString:(NSString*)str
{
    return str.length>0?str:@"  -- ";
}


@end
