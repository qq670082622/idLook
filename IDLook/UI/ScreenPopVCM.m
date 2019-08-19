//
//  ScreenPopVCM.m
//  IDLook
//
//  Created by HYH on 2018/6/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ScreenPopVCM.h"

NSString * const kScreenPopVCMCellHeight = @"kScreenPopVCMCellHeight";
NSString * const kScreenPopVCMCellType =   @"kScreenPopVCMCellType";
NSString * const kScreenPopVCMCellData =   @"kScreenPopVCMCellData";
NSString * const kScreenPopVCMCellTitle =   @"kScreenPopVCMCellTitle";

@interface ScreenPopVCM ()

@end

@implementation ScreenPopVCM

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}


-(void)refreshData
{
    [self.ds removeAllObjects];
    
    NSDictionary *dic=[UserInfoManager getPublicConfig];

    if (self.masteryType==1) {
        
        NSArray *weightArr =dic [@"weightType"];
        CGFloat height = 50  + ((weightArr.count-1)/2 + 1)*42 + 44;
        [self.ds addObject:@{kScreenPopVCMCellData:weightArr,
                             kScreenPopVCMCellHeight:[NSNumber numberWithFloat:height],
                             kScreenPopVCMCellType:[NSNumber numberWithInteger:ScreenCellTypeWeight],
                             kScreenPopVCMCellTitle:@"体重"}];
    }
    else if (self.masteryType==2 || self.masteryType==4)
    {
        NSArray *heightArr =dic [@"heightType"];
        CGFloat height1 = 50  + ((heightArr.count-1)/2 + 1)*42+44;
        [self.ds addObject:@{kScreenPopVCMCellData:heightArr,
                             kScreenPopVCMCellHeight:[NSNumber numberWithFloat:height1],
                             kScreenPopVCMCellType:[NSNumber numberWithInteger:ScreenCellTypeHeight],
                             kScreenPopVCMCellTitle:@"身高"}];
        
        NSArray *weightArr =dic [@"weightType"];
        CGFloat height2 = 50  + ((weightArr.count-1)/2 + 1)*42+44;
        [self.ds addObject:@{kScreenPopVCMCellData:weightArr,
                             kScreenPopVCMCellHeight:[NSNumber numberWithFloat:height2],
                             kScreenPopVCMCellType:[NSNumber numberWithInteger:ScreenCellTypeWeight],
                             kScreenPopVCMCellTitle:@"体重"}];
        
#if 0
        NSArray *roleArr =dic [@"filmActorRole"];
        CGFloat height3 = 50  + ((roleArr.count-1)/2 + 1)*42;
        [self.ds addObject:@{kScreenPopVCMCellData:roleArr,
                             kScreenPopVCMCellHeight:[NSNumber numberWithFloat:height3],
                             kScreenPopVCMCellType:[NSNumber numberWithInteger:ScreenCellTypeRole],
                             kScreenPopVCMCellTitle:@"角色"}];
#endif
        
    }
    else if (self.masteryType==3)
    {
        NSArray *ageArr =dic [@"filmActorAgeGroup"];
        CGFloat height1 = 50  + ((ageArr.count-1)/2 + 1)*42+44;
        [self.ds addObject:@{kScreenPopVCMCellData:ageArr,
                             kScreenPopVCMCellHeight:[NSNumber numberWithFloat:height1],
                             kScreenPopVCMCellType:[NSNumber numberWithInteger:ScreenCellTypeAge],
                             kScreenPopVCMCellTitle:@"年龄"}];
        
        NSArray *heightArr =dic [@"heightType"];
        CGFloat height2 = 50  + ((heightArr.count-1)/2 + 1)*42+44;
        [self.ds addObject:@{kScreenPopVCMCellData:heightArr,
                             kScreenPopVCMCellHeight:[NSNumber numberWithFloat:height2],
                             kScreenPopVCMCellType:[NSNumber numberWithInteger:ScreenCellTypeHeight],
                             kScreenPopVCMCellTitle:@"身高"}];
    }
 
    NSArray *typeList=[PublicManager getOrderCellType:OrderCheckTypeShotType];
    NSArray *videoList= [NSArray arrayWithObjects:typeList[0],typeList[1], nil];
    [self.ds addObject:@{kScreenPopVCMCellData:videoList,
                      kScreenPopVCMCellHeight:[NSNumber numberWithFloat:270],
                      kScreenPopVCMCellType:[NSNumber numberWithInteger:ScreenCellTypeAdv],
                      kScreenPopVCMCellTitle:@""}];
    

    
}

@end
