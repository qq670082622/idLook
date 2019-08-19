//
//  ProjectBottomV.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectBottomV.h"

@interface ProjectBottomV ()
@property(nonatomic,strong)UILabel *contentLab;
@end

@implementation ProjectBottomV

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    //
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"project_close_01"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(self);
    }];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *contentLab=[[UILabel alloc]init];
    contentLab.textColor=[UIColor colorWithHexString:@"#FF6600"];
    contentLab.font=[UIFont systemFontOfSize:12];
    [self addSubview:contentLab];
    contentLab.numberOfLines=0;
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-40);
        make.top.mas_equalTo(self).offset(11);
    }];
    
    contentLab.text= [NSString stringWithFormat:@"只有向演员询问了档期的项目才在本页面显示具体进度，无询档的项目可在我的>我的项目里查看或编辑。"];
    self.contentLab=contentLab;
    
}

-(void)refreshUIWithType:(NSInteger)type
{
    
}

-(void)closeAction
{
    if (self.closeViewBlock) {
        self.closeViewBlock();
    }
}

@end
