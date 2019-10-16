//
//  SearchHeaderView.h
//  IDLook
//
//  Created by 吴铭 on 2019/10/15.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorSearchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchHeaderView : UIView
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,strong)ActorSearchModel *model;
@property(nonatomic,copy)void(^selectCell)(ActorSearchModel *model);
@property(nonatomic,assign)CGFloat headerHei;
@end

NS_ASSUME_NONNULL_END
