//
//  CalendarView.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CalenderViewDelete <NSObject>

@optional
- (void)calenderViewStartDateString:(NSString *)startDate withEndDateString:(NSString*)endDate;

@end

@interface CalendarView : UIView

@property(nonatomic, weak) id<CalenderViewDelete> delegate;

/**
 选中的开始日期
 */
@property (nonatomic, copy) NSString *selectedStartDate;

/**
 选中的结束日期
 */
@property (nonatomic, copy) NSString *selectedEndDate;

/**
 开始日期
 */
@property (nonatomic, copy) NSString *startDay;

/**
 结束日期
 */
@property (nonatomic, copy) NSString *endDay;

/**
 类型。0:一个日期（只传一个开始日期）。  1:两个日期，传开始和结束日期
 */
@property (nonatomic,assign)NSInteger type;

@end


