//
//  AskOtherCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AskOtherCellDelegate <NSObject>

-(void)askDate;

@end
@interface AskOtherCell : UITableViewCell
@property(nonatomic,weak)id<AskOtherCellDelegate>delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,copy)NSString *testTime;
@property(nonatomic,copy)NSString *adornTime;
@property(nonatomic,assign)BOOL needNewPhoto;

-(void)loadUIWithPrice:(NSInteger)price andReason:(NSString *)reason;
@property(nonatomic,copy)void(^testTimeBlock)(NSString *time);
@property(nonatomic,copy)void(^adornTimeBlock)(NSString *time);
@property(nonatomic,copy)void(^priceAction)(void);
@property(nonatomic,copy)void(^switchAction)(BOOL needNewPhoto);

@property(nonatomic,assign)NSInteger otherCellHeight;
@end

NS_ASSUME_NONNULL_END
