/*
 @header  PublicTopV.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/16
 @description
 
 */

#import "PublicTopV.h"

@interface PublicTopV ()
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@end

@implementation PublicTopV

-(id)initWithDataSource:(NSArray*)dataSource
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        self.curePage = 0;
        self.dataSource=dataSource;
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    
    CGFloat width = (UI_SCREEN_WIDTH - 80)/self.dataSource.count;
    
    for (int i = 0; i<self.dataSource.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitle:self.dataSource[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#191919"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(40+width*i);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(width);
        }];
        
        if (i==0) {
            [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        }
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIButton *btn = (UIButton*)[self viewWithTag:100];
    
    //slider
    UIView *slider = [[UIView alloc] init];
    slider.backgroundColor = Public_Red_Color;
    [self addSubview:slider];
    slider.layer.cornerRadius=2.0;
    slider.layer.masksToBounds=YES;
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(@4);
        make.centerX.mas_equalTo(btn);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    self.slider=slider;
}


-(void)btnClicked:(UIButton*)sender
{
    self.ClickTypeBlock(sender.tag-100);
}


-(void)slideWithTag:(NSInteger)tag
{
    for (int i =0; i<self.dataSource.count; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:100+i];
        if (i==tag) {
            [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        }
        else
        {
            [button setTitleColor:[UIColor colorWithHexString:@"#191919"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        }
    }
    UIButton *sender = (UIButton*)[self viewWithTag:100+tag];
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(@4);
        make.centerX.mas_equalTo(sender);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}


@end
