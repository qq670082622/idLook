//
//  CalenderPopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalenderPopV : UIView
@property(nonatomic,copy)void(^CalenderPopVBlock)(NSString *startDay,NSString *endDay);


/**
 展示视图
 @param type 类型 0:一个日期（只传一个开始日期）。  1:两个日期，传开始和结束日期
 @param start 开始日期
 @param end 结束日期
 @param selectStart 选中的开始日期
 @param selectEnd 选中的结束日期
 */
-(void)showWithType:(NSInteger)type
          withStart:(NSString*)start
            withEnd:(NSString*)end
    withSelectStart:(NSString*)selectStart
      withSelectEnd:(NSString*)selectEnd;

@end

NS_ASSUME_NONNULL_END
