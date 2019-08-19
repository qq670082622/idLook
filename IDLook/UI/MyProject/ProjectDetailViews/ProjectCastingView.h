//
//  ProjectCastingView.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//单个角色在cell里的UI

#import <UIKit/UIKit.h>
#import "CastingModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ProjectCastingViewDelegate <NSObject>
@optional
-(void)castingActionWithInfo:(CastingModel *)model;

@end
@interface ProjectCastingView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;//父亲
@property (weak, nonatomic) IBOutlet UILabel *desc;//角色信息
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *line;
//@property(nonatomic,strong)NSDictionary *castingInfo;
@property(nonatomic,strong)CastingModel *model;
@property(nonatomic,weak)id<ProjectCastingViewDelegate>delegate;
-(void)hideLine;
@property(nonatomic,assign)CGFloat topY;
@end

NS_ASSUME_NONNULL_END
