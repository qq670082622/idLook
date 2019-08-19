//
//  HotelCalendarCell.m
//  HotelCalendar
//
//  Created by Wynter on 2017/10/17.
//  Copyright © 2017年 Wynter. All rights reserved.
//

#import "HotelCalendarCell.h"

@implementation HotelCalendarCell

#pragma mark - life cycle
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    }
    return self;
}

- (void)setIsFromDate:(BOOL)isFromDate {
    _isFromDate = isFromDate;
    
    if (isFromDate) {
        self.inOutLb.hidden = NO;
        self.inOutLb.text = @"开始";
    } else {
        self.inOutLb.hidden = YES;
    }
}

- (void)setIsToDate:(BOOL)isToDate {
    _isToDate = isToDate;
    
    if (isToDate) {
        self.inOutLb.hidden = NO;
        self.inOutLb.text = @"结束";
    } else {
        self.inOutLb.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
