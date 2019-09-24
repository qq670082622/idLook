//
//  ActorTopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorTopV.h"
@interface ActorTopV()
@property (weak, nonatomic) IBOutlet UIView *labelView;
//@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,assign)NSInteger selectIndex;
@end
@implementation ActorTopV
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ActorTopV" owner:nil options:nil] lastObject];
    }
    self.height = 200;
    self.labelView.layer.cornerRadius = 10;
    self.labelView.layer.masksToBounds = YES;
   return self;
}
-(void)setData:(NSArray *)data
{
    _data = data;
   
    for(int i = 0;i<data.count;i++){
         UIButton *platbtn = [UIButton buttonWithType:0];
        NSDictionary *paltDic = data[i];
        NSString *title = paltDic[@"name"];
        [platbtn setTitle:title forState:0];
        [platbtn setTitleColor:Public_Text_Color forState:0];
        platbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        if (_selectIndex==0&&i==0) {
            platbtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        }
        CGFloat x = 15+i*(60+20);
        platbtn.frame = CGRectMake(x, 20, 60, 24);
        [platbtn setTag:i+100];
        [platbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.labelView addSubview:platbtn];
    }
}
-(void)btnClick:(id)sender
{
    UIButton *btn = (id)sender;
    if (btn.tag-100 != _selectIndex) {//选中了没选中的
        for (UIButton *subBtn in _labelView.subviews) {
             subBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        }
          btn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        _selectIndex = btn.tag-100;
        self.selectPlat([_data[_selectIndex][@"id"]integerValue]);
    }
  
}
@end
