//
//  CalenderCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CalenderCell.h"

@interface CalenderCell()

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation CalenderCell

- (UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel                 = [[UILabel alloc] init];
        _numberLabel.textAlignment   = NSTextAlignmentCenter;
        _numberLabel.font            = [UIFont systemFontOfSize:16];
        _numberLabel.textColor =Public_Text_Color;
        [self.contentView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(1, 1, 1, 1));
        }];
    }
    return _numberLabel;
}

- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel                 = [[UILabel alloc] init];
        _descLabel.textAlignment   = NSTextAlignmentCenter;
        _descLabel.font            = [UIFont systemFontOfSize:12];
        _descLabel.textColor =[UIColor whiteColor];
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-3);
        }];
    }
    return _descLabel;
}

- (UILabel *)lineLabel {
    if (_lineLabel == nil) {
        _lineLabel                 = [[UILabel alloc] init];
        _lineLabel.textAlignment   = NSTextAlignmentCenter;
        _lineLabel.font            = [UIFont systemFontOfSize:20];
        _lineLabel.textColor =[UIColor colorWithHexString:@"#BCBCBC"];
        _lineLabel.text=@"/";
        [self.contentView addSubview:_lineLabel];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(1, 1, 1, 1));
        }];
    }
    return _lineLabel;
}


-(void)setModel:(CalenderModel *)model {
    _model = model;
    self.numberLabel.text = [NSString stringWithFormat:@"%zd",model.day];
    if (model.day>0) {
        if (model.isActivity) {
            if (model.isSelected)
            {
                self.numberLabel.layer.cornerRadius = 2;
                self.numberLabel.layer.masksToBounds = YES;
                self.numberLabel.textColor = [UIColor whiteColor];
                if (model.type==0) {
                    self.numberLabel.backgroundColor =  Public_Red_Color;
                }
                else
                {
                    if (model.isStart==YES || model.isEnd==YES) {
                        self.numberLabel.backgroundColor =  Public_Red_Color;
                    }
                    else
                    {
                        self.numberLabel.backgroundColor =  [Public_Red_Color colorWithAlphaComponent:0.1];
                    }
                }
            }
            else{
                self.numberLabel.layer.cornerRadius = 0;
                self.numberLabel.layer.masksToBounds = YES;
                self.numberLabel.backgroundColor = [UIColor clearColor];
                self.numberLabel.textColor = Public_Text_Color;
            }
        }
        else
        {
            self.numberLabel.textColor = [UIColor colorWithHexString:@"#BCBCBC"];
            self.numberLabel.backgroundColor = [UIColor clearColor];
        }
        self.numberLabel.hidden=NO;
    }
    else
    {
        self.numberLabel.backgroundColor=[UIColor clearColor];
//        self.lineLabel.hidden=YES;
        self.numberLabel.hidden=YES;
    }
}

@end
