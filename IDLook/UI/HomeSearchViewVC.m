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

@property (weak, nonatomic) IBOutlet UIView *tagsView1;
@property (weak, nonatomic) IBOutlet UILabel *tag1Title;
@property (weak, nonatomic) IBOutlet UIButton *tag1Btn;
@property(nonatomic,assign)CGFloat tagsView1H;
- (IBAction)tag1Action:(id)sender;

@end

@implementation HomeSearchViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height==20?52:68;
    self.searchView.height = height;
    self.scrollView.y = _searchView.bottom;
     self.scrollView.height = UI_SCREEN_HEIGHT-_searchView.bottom;
    self.searchBar.layer.cornerRadius = 8;
    self.searchBar.layer.masksToBounds = YES;
    self.searchField.text = _selectKeyWord;
    [self.searchField becomeFirstResponder];
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewClick)]];
    [self loadData];
}
-(void)loadData
{
 NSDictionary *dic = @{
                       @"category":@(_category==3?0:_category)//因为“不限”本地是3 后端是0，所以转一下
                          };
    [AFWebAPI_JAVA getSearchVCDataWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *body = [object objectForKey:JSON_body];
            NSDictionary *historyTags = body[@"historyTags"];
            NSArray *tags = historyTags[@"tags"];
            if (tags.count==0 || [tags isKindOfClass:[NSNull class]]) {
                self.historyView.hidden = YES;
                self.hotView.y = 0;
                tags = [NSArray new];
            }
            
            //装载历史btn
            CGFloat wid = (UI_SCREEN_WIDTH - 54)/4;
            CGFloat hisViewH = 0;
            for(int i =0;i<tags.count;i++){
                UIButton *hisBtn = [UIButton buttonWithType:0];
                NSString *hisTitle = tags[i];
                [hisBtn setTitle:hisTitle forState:0];
                [hisBtn setTitleColor:Public_Text_Color forState:0];
                hisBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [hisBtn setBackgroundColor:[UIColor colorWithHexString:@"fff2e8"]];
                hisBtn.layer.cornerRadius = 16;
                hisBtn.layer.masksToBounds = YES;
                [hisBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                NSInteger ratio = i/4;
                CGFloat x = 15+(i-(ratio*4))*(wid+8);
                CGFloat y = 56+ ratio*(32+12);
                hisBtn.frame = CGRectMake(x, y, wid, 32);
                [self.historyView addSubview:hisBtn];
                hisViewH = hisBtn.bottom + 16;
            }
            self.historyView.height = hisViewH;
            
            //装载热搜词
            CGFloat hotViewH = 0;
            NSArray *hotWords = body[@"hotTags"][@"tags"];
            for(int i =0;i<hotWords.count;i++){
                UIButton *hotBtn = [UIButton buttonWithType:0];
                NSString *hotTitle = hotWords[i];
                [hotBtn setTitle:hotTitle forState:0];
                [hotBtn setTitleColor:Public_Text_Color forState:0];
                hotBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [hotBtn setBackgroundColor:[UIColor colorWithHexString:@"fff2e8"]];
                hotBtn.layer.cornerRadius = 16;
                hotBtn.layer.masksToBounds = YES;
                [hotBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                NSInteger ratio = i/4;
                CGFloat x = 15+(i-(ratio*4))*(wid+8);
                CGFloat y = 56+ ratio*(32+12);
                hotBtn.frame = CGRectMake(x, y, wid, 32);
                [self.hotView addSubview:hotBtn];
                hotViewH = hotBtn.bottom + 16;
            }
            self.hotView.y = _historyView.bottom;
            self.hotView.height = hotViewH;
            
            //装载
            CGFloat tagViewH = 0;
            NSArray *tagWords = body[@"tags"][@"tags"];
            for(int i =0;i<tagWords.count;i++){
                UIButton *tagBtn = [UIButton buttonWithType:0];
                NSString *tagTitle = tagWords[i];
                [tagBtn setTitle:tagTitle forState:0];
                [tagBtn setTitleColor:Public_Text_Color forState:0];
                tagBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [tagBtn setBackgroundColor:[UIColor colorWithHexString:@"fff2e8"]];
                tagBtn.layer.cornerRadius = 16;
                tagBtn.layer.masksToBounds = YES;
                [tagBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                NSInteger ratio = i/4;
                CGFloat x = 15+(i-(ratio*4))*(wid+8);
                CGFloat y = 56+ ratio*(32+12);
                tagBtn.frame = CGRectMake(x, y, wid, 32);
                [self.tagsView1 addSubview:tagBtn];
                tagViewH = tagBtn.bottom + 16;
            }
            self.tagsView1.y = _hotView.bottom;
            self.tagsView1.height = tagViewH>188?188:tagViewH;
            self.tagsView1.layer.masksToBounds = YES;
            _tagsView1H = tagViewH;
            
            self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _tagsView1.bottom);
        }
    }];
}
-(void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *title = btn.titleLabel.text;
    self.wordKeySelect(title);
    [self.navigationController popViewControllerAnimated:NO];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchField resignFirstResponder];
    if (textField.text.length==0) {
        return YES;
    }
    self.wordKeySelect(textField.text);
    [self.navigationController popViewControllerAnimated:NO];
    return YES;
}
-(void)scrollViewClick
{
    [self.searchField resignFirstResponder];
}
- (IBAction)cleanAction:(id)sender {
    
    [AFWebAPI_JAVA cleanSearchHistoryWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
       [self loadData];
        }
       
        }
        ];
}

- (IBAction)tag1Action:(id)sender {//展开或者关闭
    if (_tagsView1.height==188) {//关闭状态
        _tagsView1.height = _tagsView1H;
        [self.tag1Btn setTitle:@"收起" forState:0];
        [self.tag1Btn setImage:[UIImage imageNamed:@"icon_arrow_close"] forState:0];
        }else if(_tagsView1.height>188){
        _tagsView1.height = 188;
        [self.tag1Btn setTitle:@"展开" forState:0];
        [self.tag1Btn setImage:[UIImage imageNamed:@"icon_arrow_open"] forState:0];
    }
      self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _tagsView1.bottom);
}
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
@end
