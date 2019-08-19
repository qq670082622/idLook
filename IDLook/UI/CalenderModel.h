//
//  CalenderModel.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalenderModel : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isStart;  //是否开始日期
@property (nonatomic, assign) BOOL isEnd;    //是否结束日期

@property (nonatomic, assign) BOOL isToday;

@property (nonatomic,assign)NSInteger type;  //type=0两个日期 type=1 一个日期

/**
 是否可编辑选择
 */
@property (nonatomic, assign) BOOL isActivity;

@end

