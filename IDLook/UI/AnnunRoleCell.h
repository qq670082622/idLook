//
//  AnnunRoleCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnunRoleCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,copy)void(^checkImg)(NSString *imgUrl);
@property(nonatomic,copy)void(^apply)(NSDictionary *roleDic);
@end

NS_ASSUME_NONNULL_END
