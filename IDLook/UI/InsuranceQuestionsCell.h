//
//  InsuranceQuestionsCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InsuranceQuestionsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,assign)NSInteger cellHeight;
@end

NS_ASSUME_NONNULL_END
