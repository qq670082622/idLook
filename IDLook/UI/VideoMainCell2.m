//
//  VideoMainCell2.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "VideoMainCell2.h"
@interface VideoMainCell2()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end
@implementation VideoMainCell2

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[[NSBundle mainBundle]loadNibNamed:@"VideoMainCell2" owner:self options:nil] lastObject];
     
    }
    
    return self;
}
- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    //此处wuming是为了让webimage得到网络图片后进行切图，原图250x300加载出来的演员头发都削了。传此值是为了避免过多的修改,其余地方不需要传此值，照常
   [_icon sd_setImageWithUrlStr:[NSString stringWithFormat:@"%@wuming",dataDic[@"url"]] placeholderImage:[UIImage imageNamed:@"default_home"]];
  self.title.text = dataDic[@"attrname"];
   // long random = 150+(arc4random()%500);
    NSInteger attrnum = [dataDic[@"attrnum"] integerValue];
    self.countLab.text = [NSString stringWithFormat:@"%ld",attrnum];
    
  
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)layoutSubviews
{
    [super layoutSubviews];

    _icon.userInteractionEnabled=YES;
    _icon.contentMode=UIViewContentModeScaleAspectFill;
//    _icon.frame = CGRectMake(5, 5, self.contentView.width-10, self.contentView.width-10);
     _icon.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.width);
    _icon.layer.cornerRadius = (self.contentView.width)/2;
    _icon.clipsToBounds = YES;
    self.title.y = _icon.bottom+5;
    self.countLab.y = _title.bottom;
}

@end
