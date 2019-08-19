//
//  CalenderWeekView.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CalenderWeekView.h"

@interface CalenderWeekView ()


@end

@implementation CalenderWeekView

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    for (UIView *view in self.subviews) {
        if ([view.class isKindOfClass:UILabel.class]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat count  = dataSource.count;
    CGFloat labelW = self.frame.size.width / count;
    CGFloat labelY = 0;
    CGFloat labelH = self.frame.size.height;
    for (int i = 0; i < count; i++) {
        CGFloat labelX = i * labelW;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor     = [UIColor blackColor];
        label.font          = [UIFont systemFontOfSize:12];
        label.text          = dataSource[i];
        [self addSubview:label];
    }
}



@end
