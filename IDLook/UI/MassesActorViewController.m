//
//  MassesActorViewController.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/1.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MassesActorViewController.h"
#import "MassesOrderViewController.h"
@interface MassesActorViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *introView;
@property (weak, nonatomic) IBOutlet UILabel *tip1;
@property (weak, nonatomic) IBOutlet UILabel *num1;
@property (weak, nonatomic) IBOutlet UILabel *tip2;
@property (weak, nonatomic) IBOutlet UILabel *num2;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UILabel *subTitle2;
@property (weak, nonatomic) IBOutlet UILabel *tip3;
@property (weak, nonatomic) IBOutlet UILabel *num3;
@property (weak, nonatomic) IBOutlet UILabel *tip4;
@property (weak, nonatomic) IBOutlet UILabel *num4;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *prospectsView;
@property (weak, nonatomic) IBOutlet UILabel *prospectsTitle;
@property (weak, nonatomic) IBOutlet UILabel *prospectsDesc;
@property (weak, nonatomic) IBOutlet UILabel *prospectsPrice;
- (IBAction)prospectsSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *strangerView;
@property (weak, nonatomic) IBOutlet UILabel *strangerTitle;
@property (weak, nonatomic) IBOutlet UILabel *strangerDesc;
@property (weak, nonatomic) IBOutlet UILabel *strangerPrice;
- (IBAction)strangerSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
- (IBAction)buy:(id)sender;
@property(nonatomic,assign)NSInteger selectType;//1前景 2路人
@end

@implementation MassesActorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"群众演员"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.introView.layer.cornerRadius = 8;
    self.introView.layer.masksToBounds = YES;
    [self.tip1 sizeToFit];
    self.tip1.frame = CGRectMake(41, 88, self.introView.width-56, _tip1.height);
    self.num1.layer.cornerRadius = 8.5;
    self.num1.layer.masksToBounds = YES;
    self.num1.frame = CGRectMake(15, _tip1.y+(_tip1.height-17)/2, 17, 17);
    [self.tip2 sizeToFit];
    self.tip2.frame = CGRectMake(41, _tip1.bottom+10, _tip1.width, _tip2.height);
    self.num2.layer.cornerRadius = 8.5;
    self.num2.layer.masksToBounds = YES;
    self.num2.frame = CGRectMake(15,_tip2.y+(_tip2.height-17)/2, 17, 17);
    self.title2.y = _tip2.bottom+30;
    self.subTitle2.y = _title2.bottom+4;
    self.line2.y = self.subTitle2.y+9.5;
    [self.tip3 sizeToFit];
    self.tip3.frame = CGRectMake(41, _line2.bottom+30, _tip1.width, _tip3.height);
    self.num3.layer.cornerRadius = 8.5;
    self.num3.layer.masksToBounds = YES;
    self.num3.frame = CGRectMake(15,_tip3.y+(_tip3.height-17)/2, 17, 17);
    [self.tip4 sizeToFit];
     self.tip4.frame = CGRectMake(41, _tip3.bottom+10, _tip1.width, _tip4.height);
    self.num4.layer.cornerRadius = 8.5;
    self.num4.layer.masksToBounds = YES;
    self.num4.frame = CGRectMake(15,_tip4.y+(_tip4.height-17)/2, 17, 17);
    self.introView.height = _tip4.bottom+30;
    
    self.selectView.y = _introView.bottom+23;
    self.prospectsView.layer.cornerRadius = 6;
    self.prospectsView.layer.masksToBounds = YES;
    self.prospectsView.layer.borderWidth = 1;
    self.prospectsView.layer.borderColor = [UIColor clearColor].CGColor;
    self.strangerView.layer.cornerRadius = 6;
    self.strangerView.layer.masksToBounds = YES;
    self.strangerView.layer.borderWidth = 1;
    self.strangerView.layer.borderColor = [UIColor clearColor].CGColor;
    self.buyBtn.layer.cornerRadius = 8;
    self.buyBtn.layer.masksToBounds = YES;
    self.scroll.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _selectView.bottom);
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:@"¥ 800/天"];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]} range:NSMakeRange(0,5)];
    [self.prospectsPrice setAttributedText:attStr];
    NSMutableAttributedString * attStr2 = [[NSMutableAttributedString alloc] initWithString:@"¥ 120/天"];
    [attStr2 addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]} range:NSMakeRange(0,5)];
    [self.strangerPrice setAttributedText:attStr2];
}

- (IBAction)prospectsSelect:(id)sender {
    if (_selectType==1) {
        return;
    }
    if (_selectType==2) {
        self.strangerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        self.strangerTitle.textColor = [UIColor colorWithHexString:@"464646"];
        self.strangerDesc.textColor = [UIColor colorWithHexString:@"909090"];
        self.strangerPrice.textColor = [UIColor colorWithHexString:@"464646"];
        self.strangerView.layer.borderColor = [UIColor clearColor].CGColor;
        }
    self.prospectsView.backgroundColor = [UIColor colorWithHexString:@"fbedee"];
    self.prospectsTitle.textColor = [UIColor colorWithHexString:@"#FF4A57"];
    self.prospectsDesc.textColor = [UIColor colorWithHexString:@"#FF4A57"];
    self.prospectsPrice.textColor = [UIColor colorWithHexString:@"#FF4A57"];
    self.prospectsView.layer.borderColor = [UIColor colorWithHexString:@"#FF4A57"].CGColor;
    _selectType = 1;
}
- (IBAction)strangerSelect:(id)sender {
    if (_selectType==2) {
        return;
    }
    if (_selectType==1) {
        self.prospectsView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        self.prospectsTitle.textColor = [UIColor colorWithHexString:@"464646"];
        self.prospectsDesc.textColor = [UIColor colorWithHexString:@"909090"];
        self.prospectsPrice.textColor = [UIColor colorWithHexString:@"464646"];
        self.prospectsView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    self.strangerView.backgroundColor = [UIColor colorWithHexString:@"fbedee"];
    self.strangerTitle.textColor = [UIColor colorWithHexString:@"#FF4A57"];
    self.strangerDesc.textColor = [UIColor colorWithHexString:@"#FF4A57"];
    self.strangerPrice.textColor = [UIColor colorWithHexString:@"#FF4A57"];
    self.strangerView.layer.borderColor = [UIColor colorWithHexString:@"#FF4A57"].CGColor;
    _selectType = 2;
}
- (IBAction)buy:(id)sender {
    
    MassesOrderViewController *order = [MassesOrderViewController new];
    order.singlePrice = _selectType==1?800:120;
    order.hidesBottomBarWhenPushed=YES;
   [self.navigationController pushViewController:order animated:YES];
}
- (void)onGoback
{

    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
