//
//  SearchHeaderView.m
//  IDLook
//
//  Created by 吴铭 on 2019/10/15.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "SearchHeaderView.h"
#import "HeaderSubCell.h"
@interface SearchHeaderView()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation SearchHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SearchHeaderView" owner:nil options:nil] lastObject];
    }
  
 return self;
}
-(void)setList:(NSArray *)list
{
    WeakSelf(self);
    _list = list;
    self.bgView.layer.cornerRadius = 12;
    self.bgView.layer.masksToBounds = YES;
   
    for (int i = 0;i<list.count;i++) {
        
        ActorSearchModel *model = list[i];
        HeaderSubCell *cell = [[HeaderSubCell alloc] init];
        cell.model = model;
        cell.frame = CGRectMake(0, 50+93*i, self.width, 93);
        if (i>0) {
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
            line.frame = CGRectMake(10,0,cell.width-20, 0.5);
            [cell addSubview:line];
               NSLog(@"line'S frame is %@",NSStringFromCGRect(line.frame));
        }
         [self.bgView addSubview:cell];
       
        self.bgView.height = cell.bottom + 30;
       
        cell.slelectCell = ^(ActorSearchModel * _Nonnull model) {
            weakself.selectCell(model);
        };
     }
    self.headerHei = _bgView.bottom + 15;
  }

@end
