//
//  ProjectCastingCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectCastingCell.h"
#import "ProjectCastingView.h"
#import "CastingModel.h"
@interface ProjectCastingCell()<ProjectCastingViewDelegate>
- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
@implementation ProjectCastingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectCastingCell";
    ProjectCastingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectCastingCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.addBtn.layer.cornerRadius = 8;
    cell.addBtn.layer.masksToBounds = YES;
    return cell;
}
- (void)setData:(NSArray *)data
{
    _data = data;
    CGFloat y = 63;
  for(int i = 0 ;i<data.count;i++){
//        NSDictionary *info = data[i];
      CastingModel *model = data[i];
        //ell固定高度130 每个角色固定高度144
     
        ProjectCastingView *infoView = [[ProjectCastingView alloc] initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 136)];
      infoView.topY = y;
      // xib创建的frame坑多，此处在infoview里用了layoutSubViews
      
      infoView.model = model;
     [self.contentView addSubview:infoView];
      NSLog(@"infow's frame is %@",NSStringFromCGRect(infoView.frame));
        infoView.delegate = self;
      if (data.count==1 || i==data.count-1) {
          [infoView hideLine];
      }
       y = y+136;
      }
    self.addBtn.y = y;
    NSArray *subs = self.contentView.subviews;
    NSLog(@"subViews is %@",subs);
}
//添加角色
- (IBAction)add:(id)sender {
    if (_checkStyle) {
        return;
    }
    [self.delegate castingAdd];
}
-(void)setCheckStyle:(BOOL)checkStyle
{
    _checkStyle = checkStyle;
    if (checkStyle) {
//        [self.addBtn setImage:nil forState:0];
//        [self.addBtn setTitle:@"该项目暂未添加角色" forState:0];
        self.addBtn.hidden =  YES;
    }
}
+(CGFloat)castingCellHeightWithCastingsCount:(NSInteger)count
{
    NSLog(@"%ld",130+count*136);
    return 130+count*136;
}
//点击角色进行编辑的代理
-(void)castingActionWithInfo:(CastingModel *)model
{
    [self.delegate castingActionWithInfo:model];
}

@end
