//
//  MyworksBottomV.m
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyworksBottomV.h"

@implementation MyworksBottomV

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delectBtn.backgroundColor=Public_Red_Color;
    [delectBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    delectBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:delectBtn];
    [delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(110);
    }];
    [delectBtn addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
    allBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    allBtn.imageEdgeInsets=UIEdgeInsetsMake(0,-5, 0, 5);
    [self addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [allBtn addTarget:self action:@selector(allChoose) forControlEvents:UIControlEventTouchUpInside];
    self.allBtn=allBtn;
}


-(void)delectAction
{
    self.delectBlock();
}

-(void)allChoose
{
    self.allBtn.selected=!self.allBtn.selected;
    self.chooseAllBlock(self.allBtn.selected);
}

@end
