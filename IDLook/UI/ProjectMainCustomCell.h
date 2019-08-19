//
//  ProjectMainCustomCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectMainCustomCell : UITableViewCell

/**
 背景view
 */
@property(nonatomic,strong)UIView *bgV;

/**
 头像
 */
@property(nonatomic,strong)UIImageView *icon;

/**
 昵称
 */
@property(nonatomic,strong)UILabel *nameLabel;

/**
 性别icon
 */
@property(nonatomic,strong)UIImageView *sexIcon;

/**
 所在地
 */
@property(nonatomic,strong)UILabel *regionLabel;

/**
 订单状态
 */
@property(nonatomic,strong)UILabel *stateLabel;

/**
 饰演角色
 */
@property(nonatomic,strong)UILabel *roleLabel;

@end

NS_ASSUME_NONNULL_END
