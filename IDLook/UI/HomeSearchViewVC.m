//
//  HomeSearchViewVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/28.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "HomeSearchViewVC.h"

@interface HomeSearchViewVC ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchView;//大view
@property (weak, nonatomic) IBOutlet UIView *searchBar;//灰色背景view
@property (weak, nonatomic) IBOutlet UITextField *searchField;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *historyView;
- (IBAction)cleanAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *hotView;
@property (weak, nonatomic) IBOutlet UIButton *open_close_btn;
- (IBAction)open_close_action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tagsView1;
@property (weak, nonatomic) IBOutlet UILabel *tag1Title;
@property (weak, nonatomic) IBOutlet UIButton *tag1Btn;
- (IBAction)tag1Action:(id)sender;

@end

@implementation HomeSearchViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)cancel:(id)sender {
}
- (IBAction)cleanAction:(id)sender {
}
- (IBAction)open_close_action:(id)sender {
}
- (IBAction)tag1Action:(id)sender {
}
@end
