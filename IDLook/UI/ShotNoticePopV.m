/*
 @header  ShotNoticePopV.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/23
 @description
 
 */

#import "ShotNoticePopV.h"

@interface ShotNoticePopV ()
@property(strong,nonatomic) NSTimer *timer;
@property(assign,nonatomic) NSInteger count;
@property(nonatomic,strong)UIButton *confrimBtn;
@end

@implementation ShotNoticePopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
    }
    return self;
}

- (void)showWithCountDown:(NSInteger)count
{
    self.count=count;
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    [self initUI];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}


- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
}

-(void)initUI
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(284,320));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(15);
    }];
    titleLab.text=@"拍摄下单须知";
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(45);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *descLab = [[UILabel alloc] init];
    descLab.numberOfLines=0;
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(25);
        make.top.mas_equalTo(bg).offset(70);
    }];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = 5.0;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = 2 * 14;
    //富文本样式
    NSDictionary *attributeDic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"]};

    descLab.attributedText = [[NSAttributedString alloc] initWithString:@"感谢您信任并使用脸探肖像！请您务必在拍摄日结束后10个工作日内完成该拍摄订单总金额的支付。若逾期支付，该演员或/及脸探有权单方撤回演员肖像授权。\n点击“同意并提交”即代表您已知晓该须知内容，并接受同意上述款项支付要求。" attributes:attributeDic];

    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confrimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confrimBtn setTitle:@"同意并提交" forState:UIControlStateNormal];
    confrimBtn.layer.masksToBounds=YES;
    confrimBtn.layer.cornerRadius=22.0;
    confrimBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [confrimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confrimBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateDisabled];
    [confrimBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confrimBtn];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(30);
        make.bottom.mas_equalTo(bg).offset(-25);
        make.height.mas_equalTo(44);
    }];
    self.confrimBtn=confrimBtn;
    
    if (self.count>0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
        self.confrimBtn.backgroundColor=[UIColor colorWithHexString:@"#E5E5E5"];
        self.confrimBtn.enabled=NO;
        [self.confrimBtn setTitle:[NSString stringWithFormat:@"同意并提交(%lds)",self.count] forState:UIControlStateNormal];
    }
    else
    {
        self.confrimBtn.backgroundColor=Public_Red_Color;
        self.confrimBtn.enabled=YES;
        [self.confrimBtn setTitle:@"同意并提交" forState:UIControlStateNormal];
    }
}

-(void)agreeAction
{
    [self hide];
    if (self.agreeAndPayBlock) {
        self.agreeAndPayBlock();
    }
}

- (void)timeDown
{
    if (self.count != 1){
        self.count -=1;
        self.confrimBtn.backgroundColor=[UIColor colorWithHexString:@"#E5E5E5"];
        self.confrimBtn.enabled=NO;
        [self.confrimBtn setTitle:[NSString stringWithFormat:@"同意并提交(%lds)",self.count] forState:UIControlStateNormal];

    }
    else {
        [self.timer invalidate];
        self.confrimBtn.backgroundColor=Public_Red_Color;
        self.confrimBtn.enabled=YES;
        [self.confrimBtn setTitle:@"同意并提交" forState:UIControlStateNormal];
    }
    
    if (self.TimercountDownBlock) {
        self.TimercountDownBlock(self.count);
    }
}


@end
