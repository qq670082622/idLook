//
//  UserLookPricePopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/3/25.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "UserLookPricePopV.h"


@interface UserLookPricePopV ()
@property (nonatomic,assign)CGFloat vHeight;
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,strong)NSArray *dataS;
@property (nonatomic,assign)NSInteger mastery; //专精。3:外模
@property (nonatomic,strong)NSDictionary *selectDic;  //选中的dic
@property (nonatomic,strong)UIView *typeView;
@property (nonatomic,assign)NSInteger day; //天数
@property (nonatomic,strong)UILabel *dayLab;  //天数label
@property (nonatomic,strong)UILabel *foreignDescLab;  //外模说明label
@property (nonatomic,strong)UIButton *addBtn;  //加按钮
@property (nonatomic,strong)UIButton *subtractBtn;  //加按钮
@property (nonatomic,strong)UILabel *totalPriceLab;  //总价label
@property (nonatomic,strong)UILabel *vipDescLab;  //vip优惠说明label

@end

@implementation UserLookPricePopV


- (id)init
{
    self = [super initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, self.vHeight)];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showOfferTypeWithPriceList:(NSArray *)list withSelectDic:(nonnull NSDictionary *)dic withDay:(NSInteger)day withMastery:(NSInteger)mastery withType:(NSInteger)type
{
    self.vHeight=SafeAreaTabBarHeight_IphoneX+280;
    if (mastery==3) { //外模高度增加50
        self.vHeight+=50;
    }
    //vip高度增加50
    if ([UserInfoManager getUserStatus]==201 ||[UserInfoManager getUserStatus]==202) {
        self.vHeight+=30;
    }
    
    self.mastery=mastery;
    self.day=day;
    self.dataS=list;
    self.selectDic=dic;
    UIWindow *showWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    if(!showWindow)return;
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    self.maskV=maskV;
    
    [showWindow addSubview:self];
    
    [self initUIWithType:type];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-self.vHeight, UI_SCREEN_WIDTH, self.vHeight);
    [UIView commitAnimations];
}


- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, self.vHeight);
    [UIView commitAnimations];
}

- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}

- (void)confirmSelected
{
    if (self.selectDic==nil) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄类别"];
        return;
    }
    if (self.confrimActionBlock) {
        self.confrimActionBlock(self.selectDic, self.day);
    }
    [self hide];
}


- (void)initUIWithType:(NSInteger)type
{
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(13);
    }];
    title.text=@"选择拍摄类别";

    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title).offset(0);
        make.right.equalTo(self).offset(-15);
    }];
    
    
    //vip视图
    UIView *vipView = [[UIView alloc]init];
    vipView.backgroundColor=[[UIColor colorWithHexString:@"#FFD55A"] colorWithAlphaComponent:0.2];
    vipView.layer.masksToBounds=YES;
    vipView.layer.cornerRadius=4.0;
    [self addSubview:vipView];
    [vipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(self).offset(65);
        make.height.mas_equalTo(32);
    }];
    
    //vip图标
    UIImageView *vipIcon=[[UIImageView alloc]init];
    [vipView addSubview:vipIcon];
    vipIcon.image=[UIImage imageNamed:@"u_info_vip_01"];
    [vipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(vipView);
        make.left.mas_equalTo(vipView).offset(10);
    }];
    
    //vip说明
    UILabel *vipDescLab = [[UILabel alloc] init];
    vipDescLab.font = [UIFont systemFontOfSize:12];
    vipDescLab.textColor =Public_Text_Color;
    [vipView addSubview:vipDescLab];
    [vipDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(vipView);
        make.left.mas_equalTo(vipView).offset(45);
    }];
    vipDescLab.text=@"VIP尊享客户，立享85折优惠，本单可省￥1500。";
    NSString *vipName = @"";
    if ([UserInfoManager getUserStatus]==201) {
        vipName=@"VIP战略合作公司";
    }
    else if ([UserInfoManager getUserStatus]==202)
    {
        vipName=@"VIP制片";
    }
    
    NSInteger discount = (NSInteger)([UserInfoManager getUserDiscount]*100);
    if (discount%10==0) {
        discount=discount/10;
    }
    if (discount==100) {
        discount=0;
    }
    vipDescLab.text=[NSString stringWithFormat:@"%@，立享%ld折优惠",vipName,discount];
        
    CGFloat width = (UI_SCREEN_WIDTH -30 -20)/3;  //view宽度
    CGFloat vHeight = 44;  //view高度
    CGFloat offY = 70;  //view 离top高度
    //vip用户
    if ([UserInfoManager getUserStatus]==201 || [UserInfoManager getUserStatus]==202) {
        vHeight=54;
        vipView.hidden=NO;
        offY=110;
    }
    else
    {
        vHeight=44;
        vipView.hidden=YES;
        offY=70;
    }
    
    
    for (int i=0; i<self.dataS.count; i++) {
        NSDictionary *dic = self.dataS[i];
        PricePopSubV *subV = [[PricePopSubV alloc]init];
        [subV reloadUIWithDic:dic];
        subV.userInteractionEnabled=YES;
        subV.isSelect=NO;
        subV.tag=1000+i;
        [self addSubview:subV];
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(offY);
            make.left.mas_equalTo(self).offset(15+(width+10)*i);
            make.size.mas_equalTo(CGSizeMake(width, vHeight));
        }];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(typeSelect:)];
        [subV addGestureRecognizer:tap];

        if ([self.selectDic isEqualToDictionary:dic]) {
            subV.isSelect=YES;
        }
    }
    
    MLLabel *descLab = [[MLLabel alloc] init];
    descLab.font = [UIFont systemFontOfSize:11];
    descLab.numberOfLines=0;
    descLab.lineSpacing=4.0;
    descLab.textColor =[UIColor colorWithHexString:@"#BCBCBC"];
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self).offset(vHeight+offY+14);
    }];
    descLab.text=@"*当一天内同时安排视频拍摄和平面拍摄任务时，请选择套拍";
    
    UILabel *dayTitleLab = [[UILabel alloc] init];
    dayTitleLab.font = [UIFont boldSystemFontOfSize:15];
    dayTitleLab.textColor =Public_Text_Color;
    [self addSubview:dayTitleLab];
    [dayTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(descLab.mas_bottom).offset(22);
    }];
    dayTitleLab.text=@"拍摄天数";
    
    //加
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:UIControlStateDisabled];
    addBtn.layer.masksToBounds=YES;
    addBtn.layer.cornerRadius=4.0;
    addBtn.backgroundColor=Public_Background_Color;
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dayTitleLab).offset(0);
        make.right.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    [addBtn setImageEdgeInsets:UIEdgeInsetsMake(7,7,7,7)];//调整图片大小
    self.addBtn=addBtn;

    //天数
    UILabel *dayLab = [[UILabel alloc] init];
    dayLab.font = [UIFont systemFontOfSize:15];
    dayLab.textColor = Public_Text_Color;
    [self addSubview:dayLab];
    [dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(dayTitleLab);
        make.right.mas_equalTo(self).offset(-60);
    }];
    dayLab.text=[NSString stringWithFormat:@"%ld",self.day];
    self.dayLab=dayLab;
    
    //减
    UIButton *subtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subtractBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:UIControlStateNormal];
    [subtractBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:UIControlStateDisabled];
    subtractBtn.layer.masksToBounds=YES;
    subtractBtn.layer.cornerRadius=4.0;
    subtractBtn.backgroundColor=Public_Background_Color;
    [subtractBtn addTarget:self action:@selector(subtractAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:subtractBtn];
    [subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dayTitleLab).offset(0);
        make.right.equalTo(self).offset(-88);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [subtractBtn setImageEdgeInsets:UIEdgeInsetsMake(7,7,7,7)];//调整图片大小
    self.subtractBtn=subtractBtn;

    //外模view
    UIView *foreignView = [[UIView alloc]init];
    foreignView.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
    [self addSubview:foreignView];
    [foreignView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-48-SafeAreaTabBarHeight_IphoneX);
        make.height.mas_equalTo(48);
    }];
    
    MLLabel *foreignDescLab = [[MLLabel alloc] init];
    foreignDescLab.font = [UIFont systemFontOfSize:11];
    foreignDescLab.numberOfLines=0;
    foreignDescLab.lineSpacing=4.0;
    foreignDescLab.textColor =[UIColor colorWithHexString:@"#FF6600"];
    [foreignView addSubview:foreignDescLab];
    [foreignDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(foreignView).offset(9);
    }];
    foreignDescLab.text=@"该外籍演员1天工作时间为8小时，超过8小时需加收超时费，下单后会有客户专员电话通知超时费收费标准。";
    self.foreignDescLab=foreignDescLab;
    if (self.mastery!=3) {
        foreignView.hidden=YES;
    }
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"下拍摄订单" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    confirmBtn.backgroundColor=Public_Red_Color;
    [confirmBtn addTarget:self action:@selector(confirmSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-SafeAreaTabBarHeight_IphoneX);
        make.right.mas_equalTo(self).offset(0);
        make.width.mas_equalTo(145);
        make.height.mas_equalTo(48);
    }];
    if (type==0) {
        [confirmBtn setTitle:@"下拍摄订单" forState:UIControlStateNormal];
    }
    else
    {
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    

    UILabel *priceTitle = [[UILabel alloc] init];
    priceTitle.font = [UIFont systemFontOfSize:13];
    priceTitle.textColor = Public_Text_Color;
    [self addSubview:priceTitle];
    [priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(confirmBtn);
        make.left.mas_equalTo(self).offset(15);
    }];
    priceTitle.text=@"总价";
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.font = [UIFont boldSystemFontOfSize:18];
    priceLab.textColor = Public_Red_Color;
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(confirmBtn);
        make.left.mas_equalTo(self).offset(45);
    }];
    priceLab.text=@"¥0";
    self.totalPriceLab=priceLab;
    
    [self fitDay];
    [self calculateTotalPrice];
}

//加
-(void)addAction:(UIButton*)sender
{
    self.day++;
    [self fitDay];
    [self calculateTotalPrice];
}

//减
-(void)subtractAction:(UIButton*)sender
{
    self.day--;
    [self fitDay];
    [self calculateTotalPrice];
}

//根据天数，按钮的显示状态改变
-(void)fitDay
{
    if (self.day<=1) {
        self.addBtn.enabled=YES;
        self.subtractBtn.enabled=NO;
    }
    else if (self.day>=5)
    {
        self.addBtn.enabled=NO;
        self.subtractBtn.enabled=YES;
    }
    else
    {
        self.addBtn.enabled=YES;
        self.subtractBtn.enabled=YES;
    }
    self.dayLab.text=[NSString stringWithFormat:@"%ld",self.day];
    
    if (self.selectDic==nil) {
        self.addBtn.enabled=NO;
        self.subtractBtn.enabled=NO;
    }
}

-(void)typeSelect:(UITapGestureRecognizer*)tap
{
    for (int i=0; i<self.dataS.count; i++) {
        PricePopSubV *subV = [self viewWithTag:1000+i];
        if (tap.view.tag-1000==i) {
            subV.isSelect=YES;
            self.selectDic=self.dataS[i];
        }
        else
        {
            subV.isSelect=NO;
        }
    }
    if (self.day<1) {
        self.day=1;
    }
    [self fitDay];
    [self calculateTotalPrice];
}

//总价计算
-(void)calculateTotalPrice
{
    NSString *salePrice = @"0";
    NSString *salePriceVip = @"0";
    for (int i=0; i<self.dataS.count; i++) {
        NSDictionary *dic = self.dataS[i];
        if ([dic isEqualToDictionary:self.selectDic]) {
            NSArray *priceList = dic[@"priceList"];
            for (int j=0; j<priceList.count; j++) {
                NSDictionary *dicA = priceList[j];
                if ([dicA[@"days"]integerValue]==self.day) {
                    salePrice = dicA[@"salePrice"];
                    salePriceVip = dicA[@"salePriceVip"];
                }
            }
        }
    }
    
    if ([UserInfoManager getUserStatus]==201 || [UserInfoManager getUserStatus]==202) {  //vip用户
        self.totalPriceLab.text= [NSString stringWithFormat:@"¥%@",salePriceVip];
    }
    else
    {
        self.totalPriceLab.text= [NSString stringWithFormat:@"¥%@",salePrice];
    }
    
    NSInteger dayHours = [self.selectDic[@"dayHours"] integerValue];
    if (dayHours!=0) {
         self.foreignDescLab.text=[NSString stringWithFormat:@"该外籍演员1天工作时间为%@小时，超过%@小时需加收超时费，下单后会有客户专员电话通知超时费收费标准。",self.selectDic[@"dayHours"],self.selectDic[@"dayHours"]];
    }else{
        self.foreignDescLab.text=@"该外籍演员1天工作时间为6小时，超过6小时需加收超时费，下单后会有客户专员电话通知超时费收费标准";
    }
    
    
    if (self.typeSelectBlock) {
        self.typeSelectBlock(self.selectDic, self.day);
    }
}

@end


@interface PricePopSubV ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UILabel *descLab;

@end

@implementation PricePopSubV

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        [self addSubview:_bgV];
        _bgV.backgroundColor=Public_Background_Color;
        _bgV.layer.borderColor=Public_Background_Color.CGColor;
        _bgV.layer.borderWidth=0.5;
        _bgV.layer.masksToBounds=YES;
        _bgV.layer.cornerRadius=4;
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
    }
    return _bgV;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        [self.bgV addSubview:_priceLab];
        _priceLab.font=[UIFont systemFontOfSize:13];
        _priceLab.textColor=Public_Text_Color;
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).offset(0);
            if ([UserInfoManager getUserStatus]==201||[UserInfoManager getUserStatus]==202) {  //vip用户
                make.top.mas_equalTo(self).offset(10);
            }
            else
            {
                make.centerY.mas_equalTo(self);
            }
        }];
    }
    return _priceLab;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        [self.bgV addSubview:_descLab];
        _descLab.font=[UIFont systemFontOfSize:11];
        _descLab.textColor=Public_Text_Color;
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).offset(0);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
    }
    return _descLab;
}

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    NSArray *priceList = dic[@"priceList"];
    NSString *salePrice = @"0";
    NSString *salePriceVip = @"0";
    if (priceList.count) {
        NSDictionary *dicA = [priceList firstObject];
        salePrice=dicA[@"salePrice"];
        salePriceVip=dicA[@"salePriceVip"];
    }
    
    NSInteger advertType = [dic[@"advertType"]integerValue];
    NSString *advName = @"";
    if (advertType==1) {
        advName=@"视频";
    }
    else if (advertType==2)
    {
        advName=@"平面";
    }
    else if (advertType==4)
    {
        advName=@"套拍";
    }
    
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@/天",salePrice] attributes:attribtDic];
    self.descLab.attributedText = attribtStr;
    
    if ([UserInfoManager getUserStatus]==201 || [UserInfoManager getUserStatus]==202) {  //vip用户
        self.descLab.hidden=NO;
        self.priceLab.text=[NSString stringWithFormat:@"%@ ¥%@/天",advName,salePriceVip];
    }
    else
    {
        self.descLab.hidden=YES;
        self.priceLab.text=[NSString stringWithFormat:@"%@ ¥%@/天",advName,salePrice];
    }
}

-(void)setIsSelect:(BOOL)isSelect
{
    _isSelect=isSelect;
    if (isSelect==NO) {
        self.bgV.backgroundColor=Public_Background_Color;
        self.bgV.layer.borderColor=Public_Background_Color.CGColor;
        self.priceLab.textColor=Public_Text_Color;
        self.descLab.textColor=Public_Text_Color;
    }
    else
    {
        self.bgV.backgroundColor=[Public_Red_Color colorWithAlphaComponent:0.1];
        self.bgV.layer.borderColor=Public_Red_Color.CGColor;
        self.priceLab.textColor=Public_Red_Color;
        self.descLab.textColor=Public_Red_Color;
    }
}
@end
