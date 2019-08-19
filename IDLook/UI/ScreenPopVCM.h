//
//  ScreenPopVCM.h
//  IDLook
//
//  Created by HYH on 2018/6/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kScreenPopVCMCellHeight;   //cell高度_键
extern NSString * const kScreenPopVCMCellType;     //cell类型_键
extern NSString * const kScreenPopVCMCellData;     //cell数据_键
extern NSString * const kScreenPopVCMCellTitle;     //cell标题_键


@interface ScreenPopVCM : NSObject

@property (nonatomic,strong)NSMutableArray *ds;


/**
 演员类型。1:广告演员 2:影视演员 3:外籍模特
 */
@property(nonatomic,assign)NSInteger masteryType;

-(void)refreshData;

@end
