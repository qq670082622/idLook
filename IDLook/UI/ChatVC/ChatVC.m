//
//  ChatVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/10/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ChatVC.h"
#import "ChatCell.h"
#import "ChatUserCell.h"
#import "ChatModel.h"
@interface ChatVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *textBg;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)add:(id)sender;
- (IBAction)albumAction:(id)sender;
- (IBAction)takePhotoAction:(id)sender;
@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [NSMutableArray new];
    self.textBg.layer.cornerRadius = 13;
    self.textBg.layer.masksToBounds = YES;
    self.textBg.y = UI_SCREEN_HEIGHT-70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (IBAction)add:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.textBg.y = UI_SCREEN_HEIGHT-124;//实际显示124。留一些做layer切圆
        self.tableV.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-124);
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textField resignFirstResponder];
}
- (IBAction)albumAction:(id)sender {
}

- (IBAction)takePhotoAction:(id)sender {
}
@end
 
