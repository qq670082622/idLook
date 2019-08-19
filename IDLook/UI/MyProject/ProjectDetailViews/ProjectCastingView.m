//
//  ProjectCastingView.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectCastingView.h"

@implementation ProjectCastingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ProjectCastingView" owner:nil options:nil] lastObject];
        
    }
    return self;
}

- (IBAction)action:(id)sender {
    [self.delegate castingActionWithInfo:_model];//修改完成后将值传给cell 然后cell传给外面的vc的model
}

- (void)setModel:(CastingModel *)model
{
    _model = model;
        NSMutableString *str = [NSMutableString new];
        self.title.text = model.roleName;
    if (model.sex>0) {
        [str appendString:[NSString stringWithFormat:@"性别：%@\n",model.sex==1?@"男":@"女"]];
    }else{
    [str appendString:@"性别:暂无/n"];
    }
    if (model.heightMin>0) {
         [str appendString:[NSString stringWithFormat:@"身高：%ld至%ldcm\n",model.heightMin,model.heightMax]];
    }else{
         [str appendString:[NSString stringWithFormat:@"身高：暂无\n"]];
    }
    if (model.ageMin>0) {
         [str appendString:[NSString stringWithFormat:@"年龄：%ld至%ld岁\n",model.ageMin,model.ageMax]];
    }else{
         [str appendString:[NSString stringWithFormat:@"年龄：暂无\n"]];
    }
    if (model.typeName.length>0) {
           [str appendString:[NSString stringWithFormat:@"类型：%@\n",model.typeName]];
    }else{
           [str appendString:[NSString stringWithFormat:@"类型：暂无\n"]];
    }
    if (model.remark.length>0) {
          [str appendString:[NSString stringWithFormat:@"备注：%@",model.remark]];
    }else{
          [str appendString:[NSString stringWithFormat:@"备注：暂无"]];
    }
    self.desc.text = str;
   
}

-(void)hideLine
{
    self.line.hidden = YES;
}
-(void)setTopY:(CGFloat)topY
{
    _topY = topY;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = CGRectMake(0, _topY, UI_SCREEN_WIDTH, 136);
}
@end
