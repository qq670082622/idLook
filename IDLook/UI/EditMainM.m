//
//  EditMainM.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditMainM.h"

NSString * const kEditInfoVCMCellClass =  @"kEditInfoVCMCellClass";
NSString * const kEditInfoVCMCellHeight = @"kEditInfoVCMCellHeight";
NSString * const kEditInfoVCMCellType =   @"kEditInfoVCMCellType";
NSString * const kEditInfoVCMCellName = @"kEditInfoVCMCellName";
NSString * const kEditInfoVCMCellData =   @"kEditInfoVCMCellData";

@implementation EditMainM

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}

-(NSMutableArray*)dataS
{
    if (!_dataS) {
        _dataS=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataS;
}

-(NSMutableArray*)titleArray
{
    if (!_titleArray) {
        _titleArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _titleArray;
}

-(void)refreshEditInfo
{
    [self.dataS removeAllObjects];
    [self.titleArray removeAllObjects];
    
    [self.titleArray addObjectsFromArray:@[@"基本信息",@"基本资料",@"专业信息",@"联系地址",@"可合作内容",@"简介",@"代表作品"]];
    
    
    NSMutableArray *sec0 = [NSMutableArray new];
    NSMutableArray *sec1 = [NSMutableArray new];
    NSMutableArray *sec2 = [NSMutableArray new];
    NSMutableArray *sec3 = [NSMutableArray new];
    NSMutableArray *sec4 = [NSMutableArray new];
    NSMutableArray *sec5 = [NSMutableArray new];
    NSMutableArray *sec6 = [NSMutableArray new];

    { //基本信息
        NSString *occouption=@"";
        NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"occupationType"];
        for (int i=0; i<array1.count; i++) {
            NSDictionary *dic = array1[i];
            if ([UserInfoManager getUserOccupation] == [dic[@"attrid"] integerValue]) {
                occouption=dic[@"attrname"];
            }
        }
        
        NSString *mastery=@"";
        NSArray *array2 = [[UserInfoManager getPublicConfig] objectForKey:@"masteryType"];
        for (int i=0; i<array2.count; i++) {
            NSDictionary *dic = array2[i];
            if ([UserInfoManager getUserMastery] == [dic[@"attrid"] integerValue]) {
                mastery=dic[@"attrname"];
            }
        }
        
        NSArray *array = @[@{@"title":@"真实姓名",@"content":[UserInfoManager getUserRealName],@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
                           @{@"title":@"出生日期",@"content":[UserInfoManager getUserBirth],@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
                           @{@"title":@"性别",@"content":[UserInfoManager getUserSex]==1?@"男":@"女",@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
                           @{@"title":@"国籍",@"content":[UserInfoManager getUserNationality],@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
                           @{@"title":@"职业",@"content":occouption,@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
                           @{@"title":@"专精",@"content":mastery,@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},

                           ];
        
        for (int i=0; i<array.count; i++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:array[i]];
            [sec0 addObject:@{kEditInfoVCMCellData:model,
                              kEditInfoVCMCellClass:@"CenterCustomCell",
                              kEditInfoVCMCellHeight:[NSNumber numberWithFloat:48]}];
        }
        
    }
    
    { //基本资料
        BOOL isMust = YES;
        if ([UserInfoManager getUserAgeType]>=5) {
            isMust = NO;
        }
        
        NSArray *array = @[@{@"title":@"展示名",@"content":[UserInfoManager getUserNick],@"placeholder":@"请填写展示名",@"isShowArrow":@(NO),@"IsMustInput":@(YES),@"type":@(UserInfoTypeNick)},
                           @{@"title":@"语言",@"content":[[UserInfoManager getUserLanguage] stringByReplacingOccurrencesOfString:@"|" withString:@"、"],@"placeholder":@"请选择语言",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeLanguage)},
                           @{@"title":@"方言",@"content":[UserInfoManager getUserLocalism],@"placeholder":@"请填写方言",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeLocalism)},
                           @{@"title":@"身高",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeHeight]),@"placeholder":@"请选择身高",@"isShowArrow":@(YES),@"IsMustInput":@(YES),@"type":@(UserInfoTypeHeight)},
                           @{@"title":@"体重",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeWeight]),@"placeholder":@"请选择体重",@"isShowArrow":@(YES),@"IsMustInput":@(YES),@"type":@(UserInfoTypeWeight)},
                           @{@"title":@"胸围",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeBust]),@"placeholder":@"请选择胸围",@"isShowArrow":@(YES),@"IsMustInput":@(isMust),@"type":@(UserInfoTypeBust)},
                           @{@"title":@"腰围",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeWaist]),@"placeholder":@"请选择腰围",@"isShowArrow":@(YES),@"IsMustInput":@(isMust),@"type":@(UserInfoTypeWaist)},
                           @{@"title":@"臀围",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeHipline]),@"placeholder":@"请选择臀围",@"isShowArrow":@(YES),@"IsMustInput":@(isMust),@"type":@(UserInfoTypeHipline)},
                           @{@"title":@"鞋码",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeShoeSize]),@"placeholder":@"请选择鞋码",@"isShowArrow":@(YES),@"IsMustInput":@(YES),@"type":@(UserInfoTypeShoeSize)},
                            ];
        
        for (int i=0; i<array.count; i++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:array[i]];
            [sec1 addObject:@{kEditInfoVCMCellData:model,
                                  kEditInfoVCMCellClass:@"CenterCustomCell",
                              kEditInfoVCMCellHeight:[NSNumber numberWithFloat:48]}];
        }
        
    }
    
    //专业信息
    {
        NSArray *array =@[@{@"title":@"毕业院校",@"content":[UserInfoManager getUserSchoolInfo],@"placeholder":@"请填写毕业院校",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeSchool)},
                          @{@"title":@"入学年份",@"content":[UserInfoManager getUserGrade],@"placeholder":@"请选择入学年份",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeGrade)},
                          @{@"title":@"专业",@"content":[UserInfoManager getUserSpecialty],@"placeholder":@"请填写专业",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeMajor)},
                          ];
        
        for (int i =0; i<array.count; i++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:array[i]];
            [sec2 addObject:@{kEditInfoVCMCellData:model,
                                  kEditInfoVCMCellClass:@"CenterCustomCell",
                              kEditInfoVCMCellHeight:[NSNumber numberWithFloat:48]}];
        }
    }
    
    //联系地址
    {
        NSArray *array = @[@{@"title":@"所在地",@"content":[UserInfoManager getUserRegion],@"placeholder":@"请选择所在地",@"isShowArrow":@(YES),@"IsMustInput":@(YES),@"type":@(UserInfoTypeRegion)},
                           @{@"title":@"详细通讯地址",@"content":[UserInfoManager getUserAddress],@"placeholder":@"请填写详细通讯地址",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAddress)},
                           @{@"title":@"邮政编码",@"content":[UserInfoManager getUserPostalCode],@"placeholder":@"请填写邮政编码",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypePostcode)},
                           @{@"title":@"电子邮箱",@"content":[UserInfoManager getUserEmail],@"placeholder":@"请填写电子邮箱",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeEmail)},
                           @{@"title":@"紧急联系人",@"content":[UserInfoManager getUserContactnumber1],@"placeholder":@"请填写紧急联系人",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeContactName)},
                           @{@"title":@"紧急联系人电话",@"content":[UserInfoManager getUserContactnumber2],@"placeholder":@"请填写紧急联系人电话",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeContactPhone)},
                           ];
        
        for (int i =0; i<array.count; i++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:array[i]];
            [sec3 addObject:@{kEditInfoVCMCellData:model,
                              kEditInfoVCMCellClass:@"CenterCustomCell",
                              kEditInfoVCMCellHeight:[NSNumber numberWithFloat:48]}];
        }

    }
    
    //可合作内容
    {
        NSString *content = @"";
        NSDictionary *dic =[UserInfoManager getPublicConfig];
        NSArray *array1 = dic[@"categoryType"];
        for (int i=0; i<array1.count; i++) {
            NSDictionary *dicA = array1[i];
            NSInteger cateid =[[dicA objectForKey:@"cateid"] integerValue];
            if (cateid==[UserInfoManager getUserAgeType]) {
                NSString *age= dicA[@"attribute"][@"ageGroupType"][@"attrname"];
                content=[NSString stringWithFormat:@"%@(%@岁)",dicA[@"catename"],age];
            }
        }

        
        NSArray *array = @[@{@"title":@"身份/年龄段",@"content":content,@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
//                           @{@"title":@"擅长表演类型",@"content":[[UserInfoManager getPerformingTypes] stringByReplacingOccurrencesOfString:@"|" withString:@"、"],@"placeholder":@"请选择",@"isShowArrow":@(YES),@"IsMustInput":@(YES),@"type":@(UserInfoTypeGoodatType)},
                           ];
        
        for (int i =0; i<array.count; i++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:array[i]];
            [sec4 addObject:@{kEditInfoVCMCellData:model,
                              kEditInfoVCMCellClass:@"CenterCustomCell",
                              kEditInfoVCMCellHeight:[NSNumber numberWithFloat:48]}];
        }
    
    }
    
    //简介
    {
        NSArray *array = @[@{@"title":@"简介",@"content":[UserInfoManager getUserBrief],@"placeholder":@"请填写简介",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeBrief)}];
        
        for (int i =0; i<array.count; i++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:array[i]];
            [sec5 addObject:@{kEditInfoVCMCellData:model,
                              kEditInfoVCMCellClass:@"CenterTextViewCell",
                              kEditInfoVCMCellHeight:[NSNumber numberWithFloat:120]}];
        }

    }
    
    //代表作品
    {
        NSArray *array = @[@{@"title":@"代表作品",@"content":[UserInfoManager getUserTypicalworks],@"placeholder":@"请填写代表作品",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeRepresentative)}];
        
        for (int i =0; i<array.count; i++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:array[i]];
            [sec6 addObject:@{kEditInfoVCMCellData:model,
                              kEditInfoVCMCellClass:@"CenterTextViewCell",
                              kEditInfoVCMCellHeight:[NSNumber numberWithFloat:120]}];
        }
    }
    
    [self.dataS addObject:sec0];
    [self.dataS addObject:sec1];
    [self.dataS addObject:sec2];
    [self.dataS addObject:sec3];
    [self.dataS addObject:sec4];
    [self.dataS addObject:sec5];
    [self.dataS addObject:sec6];


    if (self.reloadTableData) {
        self.reloadTableData();
    }
}

-(void)reloadDataWithIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
//    NSMutableArray *dataSource = self.dataS[sec];
//
//    NSDictionary *dic1 = dataSource[row];
    
    EditStructM *model = (EditStructM *)[self.dataS[sec][row] objectForKey:kEditInfoVCMCellData];
    model.content=content;
    
}


//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 10;
//    contentLab.textInsets = UIEdgeInsetsMake(10, 13, 10, 13);
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<20.0?20.0:ceilf(size.height);
}



@end
