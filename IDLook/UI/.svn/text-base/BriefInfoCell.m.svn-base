//
//  BriefInfoCell.m
//  IDLook
//
//  Created by HYH on 2018/5/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "BriefInfoCell.h"

@interface BriefInfoCell ()
@property(nonatomic,strong)MLLabel *briefLab;
@end

@implementation BriefInfoCell

-(MLLabel*)briefLab
{
    if (!_briefLab) {
        _briefLab=[[MLLabel alloc]init];
        _briefLab.font=[UIFont systemFontOfSize:13.0];
        _briefLab.numberOfLines=0;
        _briefLab.textAlignment=NSTextAlignmentLeft;
        _briefLab.lineSpacing = 10;
        _briefLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_briefLab];
        [_briefLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(10);
        }];
    }
    return _briefLab;
}

-(void)reloadUiWithContent:(NSString *)content
{
    self.briefLab.text=content;
}

@end
