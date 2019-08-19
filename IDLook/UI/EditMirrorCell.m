//
//  EditMirrorCell.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditMirrorCell.h"

@interface EditMirrorCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)NSArray *dataS;
@property(nonatomic,assign)NSInteger type;
@end

@implementation EditMirrorCell

-(NSMutableArray*)selectArray
{
    if (!_selectArray) {
        _selectArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _selectArray;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
        
        [self selectArray];
        self.dataS=@[@"周出镜",@"月出镜",@"季出镜",@"半年出境"];
        [self titleLab];
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(30);
        }];
    }
    return _titleLab;
}

-(void)initUI
{
    CGFloat width = (UI_SCREEN_WIDTH-30-12*3)/4;
    
    for (int i =0; i<self.dataS.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self addSubview:button];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=3.0;
        button.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
        button.layer.borderWidth=0.5;
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:self.dataS[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15+(width+12)*(i%4));
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(20);
            make.size.mas_equalTo(CGSizeMake(width, 32));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
        
        NSArray* array1 = [[UserInfoManager getExploitableMirrPhotos] componentsSeparatedByString:@"|"];
        if (self.type==0 &&[array1 containsObject:self.dataS[i]]) {
            button.selected=YES;
            button.layer.borderColor=Public_Red_Color.CGColor;
            [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
            [self.selectArray addObject:self.dataS[i]];

        }
        
        NSArray* array2 = [[UserInfoManager getExploitableMirrVideos] componentsSeparatedByString:@"|"];

        if (self.type==1 && [array2 containsObject:self.dataS[i]]) {
            button.selected=YES;
            button.layer.borderColor=Public_Red_Color.CGColor;
            [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
            [self.selectArray addObject:self.dataS[i]];
        }
    }
}

-(void)clickType:(UIButton*)sender
{

    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        sender.layer.borderColor=Public_Red_Color.CGColor;
        [sender setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
        [self.selectArray addObject:self.dataS[sender.tag-100]];
    }
    else
    {
        sender.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
        [sender setBackgroundColor:[UIColor whiteColor]];
        
        if ([self.selectArray containsObject:self.dataS[sender.tag-100]]) {
            [self.selectArray removeObject:self.dataS[sender.tag-100]];
        }
    }
    
}

-(void)reloadUIWithType:(NSInteger)type
{
    if (type==0) {
        self.titleLab.text=@"独家授权照片";
    }
    else if (type==1)
    {
        self.titleLab.text=@"独家授权视频";
    }
    
    self.type=type;
    
    [self initUI];
}

@end
