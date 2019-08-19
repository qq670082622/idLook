//
//  GraduatedSchoolCell.m
//  IDLook
//
//  Created by HYH on 2018/5/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "GraduatedSchoolCell.h"

@interface GraduatedSchoolCell ()
@property(nonatomic,strong)UILabel *detialLab;
@end

@implementation GraduatedSchoolCell

-(UILabel*)detialLab
{
    if (!_detialLab) {
        _detialLab=[[UILabel alloc]init];
        _detialLab.font=[UIFont systemFontOfSize:13.0];
        _detialLab.numberOfLines=1;
        _detialLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_detialLab];
        [_detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _detialLab;
}

-(void)reloadUiWithContent:(NSString*)content
{
    self.detialLab.text=content;
}


@end
