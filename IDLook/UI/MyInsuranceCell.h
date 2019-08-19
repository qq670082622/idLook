//
//  MyInsuranceCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/17.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MyInsuranceCellDelegate <NSObject>

-(void)compensateWithModel:(InsuranceModel *)model;
-(void)checkWithModel:(InsuranceModel *)model;
-(void)ticketWithModel:(InsuranceModel *)model;
@end
@interface MyInsuranceCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)InsuranceModel *model;
@property(nonatomic,weak)id<MyInsuranceCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
