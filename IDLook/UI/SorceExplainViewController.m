//
//  SorceExplainViewController.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/21.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "SorceExplainViewController.h"

@interface SorceExplainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *ex1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *ex2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *ex3;
@property (weak, nonatomic) IBOutlet UILabel *title4;
@property (weak, nonatomic) IBOutlet UILabel *ex4;

@end

@implementation SorceExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 700);
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"积分说明"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.ex1 sizeToFit];
    self.ex1.y = _title1.bottom+8;
    self.title2.y = self.ex1.bottom+29;
    [self.ex2 sizeToFit];
    self.ex2.y = _title2.bottom+8;
    self.title3.y = self.ex2.bottom+29;
    [self.ex3 sizeToFit];
    self.ex3.y = _title3.bottom+8;
    self.title4.y = _ex3.bottom+29;
    [self.ex4 sizeToFit];
    self.ex4.y = self.title4.bottom+8;
    self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, self.ex4.bottom+29);
    
}
- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
