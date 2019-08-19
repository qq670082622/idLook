//
//  ScheduleLockVCM.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockVCM.h"

NSString * const kScheduleLockVCMCellClass =  @"kScheduleLockVCMCellClass";
NSString * const kScheduleLockVCMCellHeight = @"kScheduleLockVCMCellHeight";
NSString * const kScheduleLockVCMCellType =   @"kScheduleLockVCMCellType";
NSString * const kScheduleLockVCMCellData =   @"kScheduleLockVCMCellData";

@interface ScheduleLockVCM ()
@end

@implementation ScheduleLockVCM

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(void)refreshDataWithIsService:(BOOL)isService
{
    [self.ds removeAllObjects];
    
    [self.ds addObject:@{kScheduleLockVCMCellClass:@"ScheduleLockCellA",
                         kScheduleLockVCMCellType:[NSNumber numberWithInteger:ScheduleLockCellTypeProject],
                         kScheduleLockVCMCellHeight:[NSNumber numberWithFloat:143]}];
    if (isService==NO) {  //未付服务费
        [self.ds addObject:@{kScheduleLockVCMCellClass:@"ScheduleLockCellB",
                             kScheduleLockVCMCellType:[NSNumber numberWithInteger:ScheduleLockCellTypeService],
                             kScheduleLockVCMCellHeight:[NSNumber numberWithFloat:48]}];
    }

    
    [self.ds addObject:@{kScheduleLockVCMCellClass:@"ScheduleLockCellC",
                         kScheduleLockVCMCellType:[NSNumber numberWithInteger:ScheduleLockCellTypeArtistInfo],
                         kScheduleLockVCMCellHeight:[NSNumber numberWithFloat:140]}];
    
    [self.ds addObject:@{kScheduleLockVCMCellClass:@"ScheduleLockCellD",
                         kScheduleLockVCMCellType:[NSNumber numberWithInteger:ScheduleLockCellTypeGold],
                         kScheduleLockVCMCellHeight:[NSNumber numberWithFloat:155]}];
    
    [self.ds addObject:@{kScheduleLockVCMCellClass:@"ScheduleLockCellE",
                         kScheduleLockVCMCellType:[NSNumber numberWithInteger:ScheduleLockCellTypeInsurance],
                         kScheduleLockVCMCellHeight:[NSNumber numberWithFloat:48]}];
    
    
    if (self.newDataNeedRefreshed) {
        self.newDataNeedRefreshed();
    }
}

@end
