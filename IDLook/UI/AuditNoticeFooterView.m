//
//  AuditNoticeFooterView.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditNoticeFooterView.h"

@implementation AuditNoticeFooterView

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor=Public_Red_Color;
    commitBtn.layer.cornerRadius=5.0;
    commitBtn.layer.masksToBounds=YES;
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.contentView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.top.mas_equalTo(self.contentView).offset(110);
        make.height.mas_equalTo(48);
    }];
    [commitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLab=[[UILabel alloc]init];
    titleLab.font=[UIFont systemFontOfSize:13.0];
    titleLab.textColor=Public_Text_Color;
    titleLab.text=@"• 温馨提示";
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.top.mas_equalTo(self.contentView).offset(12);
    }];
    
    MLLabel *descLab=[[MLLabel alloc]init];
    descLab.numberOfLines=0;
    descLab.lineSpacing=5.0;
    descLab.textAlignment=NSTextAlignmentLeft;
    descLab.font=[UIFont systemFontOfSize:12.0];
    descLab.textColor=Public_DetailTextLabelColor;
    [self.contentView addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(30);
    }];
    descLab.text=@"脸探平台会在24小时内通知演员回复您的定妆通知，演员如若不接受或没有回复您的定妆通知，请及时联系脸探平台，客服电话：400-8336969。";
}



//确定
-(void)submitAction
{
    if (self.confrimBlock) {
        self.confrimBlock();
    }
}

@end
