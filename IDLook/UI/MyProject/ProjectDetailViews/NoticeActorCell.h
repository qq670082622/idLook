//
//  NoticeActorCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeActorModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol NoticeActorCellDelegate <NSObject>

-(void)cellSelectStartDate:(NSString *)startDate withRow:(NSInteger)row;

-(void)cellSelectEndDate:(NSString *)endDate withRow:(NSInteger)row;
@end
@interface NoticeActorCell : UITableViewCell
@property(nonatomic,strong)NoticeActorModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,copy)void(^dateSelect)(NSString *start,NSString *end);
@property(nonatomic,weak)id<NoticeActorCellDelegate>delegate;
@property(nonatomic,assign)NSInteger row;
@end

NS_ASSUME_NONNULL_END
