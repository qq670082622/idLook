//
//  VideoListHeadView.m
//  IDLook
//
//  Created by Mr Hu on 2018/12/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoListHeadView.h"

@interface VideoListHeadView ()
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UIView *selectV;  //选中时的框

@property (nonatomic,strong)UIView *lineV1;  //框线1
@property (nonatomic,strong)UIView *lineV2;  //框线2

@end

@implementation VideoListHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.contentView.clipsToBounds=YES;
    }
    return self;
}

-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}

-(void)reloadUIWithType:(NSInteger)type
{
    [self getDataWithType:type];
    CGFloat width = (UI_SCREEN_WIDTH-30-20)/3;
    for (UIView *obj in self.contentView.subviews) {
        [obj removeFromSuperview];
    }
    
    UIView *selectV = [[UIView alloc]init];
    [self.contentView addSubview:selectV];
    selectV.layer.cornerRadius=4;
    selectV.layer.masksToBounds=YES;
    selectV.layer.borderWidth=1.0;
    selectV.layer.borderColor=Public_Background_Color.CGColor;
    self.selectV=selectV;
    
    UIView *lineV1 = [[UIView alloc]init];
    [self.contentView addSubview:lineV1];
    lineV1.backgroundColor=Public_Background_Color;
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView.mas_centerX);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    self.lineV1=lineV1;
    
    UIView *lineV2 = [[UIView alloc]init];
    [self.contentView addSubview:lineV2];
    lineV2.backgroundColor=Public_Background_Color;
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    self.lineV2=lineV2;
    
    
    for (int i=0; i<self.dataSource.count; i++) {
        NSDictionary *dic = self.dataSource[i];
        NSInteger type = [dic[@"type"] integerValue];
        UIButton *button = [[UIButton alloc]init];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=4;
        button.layer.borderColor=Public_Background_Color.CGColor;
        button.layer.borderWidth=0;
        button.tag=1000+type;
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:14.0];
        button.backgroundColor=Public_Background_Color;
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15+(width+10)*i);
            make.top.mas_equalTo(self.contentView).offset(12);
            make.size.mas_equalTo(CGSizeMake(width, 28));
        }];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)buttonClick:(UIButton*)sender
{
    for (id obj in self.contentView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)obj;
            if (button.tag==sender.tag) {
                sender.selected=!sender.selected;
            }
            else
            {
                button.selected=NO;
            }
        }
    }
    [self reloadButtonWithType:sender.tag-1000];
    
    if (self.screenConditionBlock) {
        self.screenConditionBlock(sender.tag-1000, sender.selected);
    }
}

//刷新按钮UI
-(void)reloadButtonWithType:(ScreenCellType)type
{
    UIButton *sender = [self.contentView viewWithTag:type+1000];
    
    for (int i=0; i<self.dataSource.count; i++) {
        NSDictionary *dic = self.dataSource[i];
        ScreenCellType cellType = [dic[@"type"] integerValue];
        BOOL isRed = [dic[@"isRed"]boolValue];
        UIButton *button = [self.contentView viewWithTag:cellType+1000];
        if (cellType==type) {
            if (sender.selected) {
                sender.backgroundColor=[UIColor clearColor];
                sender.layer.borderColor=Public_Background_Color.CGColor;
                sender.layer.borderWidth=0;
                [sender setTitleColor:Public_Text_Color forState:UIControlStateNormal];
                self.selectV.hidden=NO;
            }
            else
            {
                self.selectV.hidden=YES;
                if (isRed==YES) {
                    button.backgroundColor=[Public_Red_Color colorWithAlphaComponent:0.15];
                    button.layer.borderColor=Public_Red_Color.CGColor;
                    button.layer.borderWidth=1.0;
                    [button setTitleColor:Public_Red_Color forState:UIControlStateNormal];
                }
                else
                {
                    button.backgroundColor=Public_Background_Color;
                    button.layer.borderColor=Public_Background_Color.CGColor;
                    button.layer.borderWidth=0;
                    [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
                }
            }
        }
        else
        {
            if (isRed==YES) {
                button.backgroundColor=[Public_Red_Color colorWithAlphaComponent:0.15];
                button.layer.borderColor=Public_Red_Color.CGColor;
                button.layer.borderWidth=1.0;
                [button setTitleColor:Public_Red_Color forState:UIControlStateNormal];
            }
            else
            {
                button.backgroundColor=Public_Background_Color;
                button.layer.borderColor=Public_Background_Color.CGColor;
                button.layer.borderWidth=0;
                [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
            }
        }
    }
    
    [self.selectV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sender.mas_left);
        make.right.mas_equalTo(sender.mas_right);
        make.top.mas_equalTo(sender.mas_top);
        make.bottom.mas_equalTo(self.contentView).offset(4);
    }];
    
     if (sender.selected) {
         [self.lineV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(self.contentView);
             make.right.mas_equalTo(sender.mas_left);
             make.bottom.mas_equalTo(self.contentView);
             make.height.mas_equalTo(1);
         }];
         
         [self.lineV2 mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(sender.mas_right);
             make.right.mas_equalTo(self.contentView);
             make.bottom.mas_equalTo(self.contentView);
             make.height.mas_equalTo(1);
         }];
     }
    else
    {
        [self.lineV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView.mas_centerX);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
        
        [self.lineV2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
    }
}

//刷新标题
-(void)reloadButtonWithType:(ScreenCellType)type withTitle:(NSString*)title 
{
    UIButton *sender = [self.contentView viewWithTag:type+1000];
    sender.selected=NO;
    
    for (int i=0; i<self.dataSource.count; i++)
    {
        NSDictionary *dic = self.dataSource[i];
        if (type == [dic[@"type"]integerValue])
        {
            BOOL isRed = NO;
            if (title.length>0) {
                [sender setTitle:title forState:UIControlStateNormal];
                isRed = YES;
            }
            else
            {
                [sender setTitle:dic[@"title"] forState:UIControlStateNormal];
                isRed=NO;
            }
            NSDictionary *newDic = @{@"title":dic[@"title"],@"type":dic[@"type"],@"isRed":@(isRed)};
            [self.dataSource replaceObjectAtIndex:i withObject:newDic];
        }
    }
    
    [self reloadButtonWithType:type];
}

-(void)hideReloadUI
{
//    UIButton *sender = [self.contentView viewWithTag:type+1000];
//    sender.selected=NO;
//    [self reloadButtonWithType:type];
    
    for (int i=0; i<self.dataSource.count; i++) {
        NSDictionary *dic = self.dataSource[i];
        ScreenCellType cellType = [dic[@"type"] integerValue];
        UIButton *sender = [self.contentView viewWithTag:cellType+1000];
        sender.selected=NO;
        [self reloadButtonWithType:cellType];
    }
}

-(void)getDataWithType:(NSInteger)type
{
    if (type==1) {
        [self.dataSource setArray: @[@{@"title":@"价格",@"type":@(ScreenCellTypePrice),@"isRed":@(NO)},
                                     @{@"title":@"年龄",@"type":@(ScreenCellTypeAge),@"isRed":@(NO)},
                                     @{@"title":@"身高",@"type":@(ScreenCellTypeHeight),@"isRed":@(NO)}]];
    }
    else if (type==2)
    {
        [self.dataSource setArray: @[@{@"title":@"价格",@"type":@(ScreenCellTypePrice),@"isRed":@(NO)},
                                     @{@"title":@"性别",@"type":@(ScreenCellTypeSex),@"isRed":@(NO)},
                                     @{@"title":@"年龄",@"type":@(ScreenCellTypeAge),@"isRed":@(NO)}]];
    }
    else if (type==3)
    {
        [self.dataSource setArray: @[@{@"title":@"价格",@"type":@(ScreenCellTypePrice),@"isRed":@(NO)},
                                     @{@"title":@"性别",@"type":@(ScreenCellTypeSex),@"isRed":@(NO)},
                                     @{@"title":@"国籍",@"type":@(ScreenCellTypeNationality),@"isRed":@(NO)}]];
    } else if (type==4)
    {
        [self.dataSource setArray: @[@{@"title":@"价格",@"type":@(ScreenCellTypePrice),@"isRed":@(NO)},
                                     @{@"title":@"性别",@"type":@(ScreenCellTypeSex),@"isRed":@(NO)},
                                     @{@"title":@"年龄",@"type":@(ScreenCellTypeAge),@"isRed":@(NO)}]];
    }
}

@end
