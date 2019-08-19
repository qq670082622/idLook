//
//  IdentitySubCell.m
//  IDLook
//
//  Created by HYH on 2018/5/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "IdentitySubCell.h"

@interface IdentitySubCell ()
@property(nonatomic,strong)UIButton *identyBtn;
@property(nonatomic,strong)NSArray *dataS;
@end

@implementation IdentitySubCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

-(void)reloadUIWithArray:(NSArray *)array
{
    self.dataS=array;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }

    UIImage *image = [UIImage imageNamed:@"chose_type_n"];
    CGFloat height =image.size.height;
    CGFloat width =image.size.width;
    for (int i =0 ; i<array.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        
        [self.contentView addSubview:button];
        
        button.layer.cornerRadius=5.0;
        button.layer.masksToBounds=YES;
        button.layer.borderColor=[UIColor colorWithHexString:@"#E2E2E2"].CGColor;
        button.layer.borderWidth=0.5;
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#FBFBFB"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"chose_type_n"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"chose_type_h"] forState:UIControlStateHighlighted];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(40+(height+25)*i);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)clickType:(UIButton*)sender
{
//    for (int i =0 ; i<self.dataS.count; i++)
//    {
//        UIButton * button = (UIButton*)[self viewWithTag:100+i];
//        if (i==(sender.tag-100)) {
//            button.selected=YES;
//        }
//        else
//        {
//            button.selected=NO;
//        }
//    }
    
    self.IdentitySubCellBlock(sender.tag-100);
}

@end
