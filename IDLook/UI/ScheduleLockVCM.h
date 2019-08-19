//
//  ScheduleLockVCM.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kScheduleLockVCMCellClass;    //cell类名_键
extern NSString * const kScheduleLockVCMCellHeight;   //cell高度_键
extern NSString * const kScheduleLockVCMCellType;     //cell类型_键
extern NSString * const kScheduleLockVCMCellData;     //cell数据_键

typedef NS_ENUM(NSInteger,ScheduleLockCellType)
{
    ScheduleLockCellTypeProject,    //项目
    ScheduleLockCellTypeService,   //服务费
    ScheduleLockCellTypeArtistInfo,   //艺人信息
    ScheduleLockCellTypeGold,         //档期保证金
    ScheduleLockCellTypeInsurance     //保险
};

@interface ScheduleLockVCM : NSObject
@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);
@property(nonatomic,strong)NSMutableArray *ds;
-(void)refreshDataWithIsService:(BOOL)isService;
@end


