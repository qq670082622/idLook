//
//  ProjectCell2.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel2.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProjectCell2 : UITableViewCell
@property(nonatomic,strong) ProjectModel2 *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,copy)void(^btnClicked)(NSString *clickType);
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@end

NS_ASSUME_NONNULL_END
