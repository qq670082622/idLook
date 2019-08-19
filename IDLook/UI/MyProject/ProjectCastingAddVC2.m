//
//  ProjectCastingAddVC2.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectCastingAddVC2.h"
#import "SiliderView.h"
@interface ProjectCastingAddVC2 ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *roleNameField;

@property (weak, nonatomic) IBOutlet UIButton *manBtn;
- (IBAction)manAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
- (IBAction)femaleAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *anyBtn;
- (IBAction)anyAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
- (IBAction)heightAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
- (IBAction)ageAction:(id)sender;

@property(nonatomic,strong)NSMutableArray *selectArr;//type

@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end

@implementation ProjectCastingAddVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:_type==1?@"新建角色":@"编辑角色"]];
    UIButton *saveBtn = [CustomNavVC getRightBarButtonItem2WithTarget:self action:@selector(save) normalImg:nil hilightImg:nil];
    saveBtn.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
    [saveBtn setTitle:@"保存" forState:0];
    saveBtn.titleLabel.textColor = [UIColor colorWithHexString:@"464646"];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:saveBtn]];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.scrollView addGestureRecognizer:tapGesturRecognizer];
    
    self.manBtn.layer.cornerRadius = 6;
    self.manBtn.layer.borderWidth = 1;
    self.femaleBtn.layer.cornerRadius = 6;
    self.femaleBtn.layer.borderWidth = 1;
    self.anyBtn.layer.cornerRadius = 6;
    self.anyBtn.layer.borderWidth = 1;
    
  if (_type==2) {
        [self initUIWithEdit];
    }
}
-(void)initUIWithEdit
{
    if (_model.roleName.length>0) {
        self.roleNameField.text = _model.roleName;
    }
    
    [self resetSexBtns];
    
    if (_model.sex==0) {
        [self.anyBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
        self.anyBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
    }else if (_model.sex==1){
        [self.manBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
        self.manBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
    }else if (_model.sex==2){
        [self.femaleBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
        self.femaleBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
    }
    
    
    if(_model.heightMin>0){
        self.heightLabel.text = [NSString stringWithFormat:@"%ld-%ldcm",_model.heightMin,_model.heightMax];
        self.heightLabel.textColor = Public_Text_Color;
    }
    
  
    if(_model.ageMin>0){
        self.ageLabel.text = [NSString stringWithFormat:@"%ld-%ld岁",_model.ageMin,_model.ageMax];
        self.ageLabel.textColor = Public_Text_Color;
    }
    
    CGFloat width = (UI_SCREEN_WIDTH-30-20)/3;
    NSArray *dataS = [NSArray arrayWithObjects:@"阳光",@"文艺",@"动感",@"职场",@"温柔",@"甜美",@"性感",@"成熟",@"潮酷",@"可爱",@"慈祥",@"平凡",@"居家",@"帅气",@"搞笑",nil];
    CGFloat btnX = 15;
    CGFloat btnY = 305;
    for (int i =0; i<dataS.count; i++) {
        UIButton *btn = [UIButton buttonWithType:0];
        [btn setTitle:dataS[i] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:Public_Text_Color forState:0];
        btn.layer.borderColor = Public_Text_Color.CGColor;
        btn.layer.borderWidth = 1;
        [btn setTag:i];
         [NSMutableArray new];
       self.selectArr = [NSMutableArray arrayWithArray:[_model.typeName componentsSeparatedByString:@"、"]];
        if ([_model.typeName containsString:dataS[i]]) {
            [btn setTitleColor:Public_Red_Color forState:0];
            btn.layer.borderColor = Public_Red_Color.CGColor;
            btn.layer.borderWidth = 1;
            
        }
        if (i%3==1) {
            btnX = 15;
        }else if (i%3==2){
            btnX = 15+ width + 10;
        }else if (i%3==0){
            btnX = 15+width*2+20;
        }
        if (i/3==1) {
            btnY = 82;
        }else if (i/3==2){
            btnY = 82+33+30;
        }else if (i/3==0){
            btnY = 82+33+30+33+30;
        }
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(btnX, btnY, width, 33);
        [self.scrollView addSubview:btn];
    }

    if (_model.remark.length>0) {
        self.remarkTextView.text = _model.remark;
        self.remarkLabel.hidden = YES;
    }
  //  [self mutibleUILayout];
}

- (IBAction)manAction:(id)sender {
    [self resetSexBtns];
    [self.manBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
    self.manBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
    _model.sex = 1;
}

- (IBAction)femaleAction:(id)sender {
    [self resetSexBtns];
    [self.femaleBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
    self.femaleBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
    _model.sex = 2;
}

- (IBAction)anyAction:(id)sender {
    [self resetSexBtns];
    [self.anyBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
    self.anyBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
    _model.sex = 0;
}

- (IBAction)heightAction:(id)sender {
    WeakSelf(self);
    SiliderView *sv = [SiliderView new];
    sv.typeStr = @"身高";
    [sv showTypeWithSelectLow:_model.heightMin andHigh:_model.heightMax];
    sv.selectNum = ^(NSInteger low, NSInteger high) {
        weakself.model.heightMin = low;
        weakself.model.heightMax = high;
        weakself.heightLabel.text = [NSString stringWithFormat:@"%ld-%ldcm",low,high];
        weakself.heightLabel.textColor = [UIColor colorWithHexString:@"464646"];
    };
}

- (IBAction)ageAction:(id)sender {
    WeakSelf(self);
    SiliderView *sv = [SiliderView new];
    sv.typeStr = @"年龄";
    [sv showTypeWithSelectLow:_model.ageMin andHigh:_model.ageMax];
    sv.selectNum = ^(NSInteger low, NSInteger high) {
        weakself.model.ageMin = low;
        weakself.model.ageMax = high;
        weakself.ageLabel.text = [NSString stringWithFormat:@"%ld-%ld岁",low,high];
        weakself.ageLabel.textColor = [UIColor colorWithHexString:@"464646"];
    };
}
-(void)click:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSArray *dataS = [NSArray arrayWithObjects:@"阳光",@"文艺",@"动感",@"职场",@"温柔",@"甜美",@"性感",@"成熟",@"潮酷",@"可爱",@"慈祥",@"平凡",@"居家",@"帅气",@"搞笑",nil];
    NSString *str = dataS[btn.tag];
    if (![_selectArr containsObject:str]) {
        [_selectArr addObject:str];
        [btn setTitleColor:Public_Red_Color forState:0];
        btn.layer.borderColor = Public_Red_Color.CGColor;
        btn.layer.borderWidth = 1;
    }else{
        [_selectArr removeObject:str];
        [btn setTitleColor:Public_Text_Color forState:0];
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        btn.layer.borderWidth = 1;
    }
}
-(void)save
{
    NSDictionary *info = @{
                           @"roleName":self.roleNameField.text,
                           @"sex":@(_model.sex),
                           @"heightMin":@(_model.heightMin),
                           @"heightMax":@(_model.heightMax),
                           @"ageMin":@(_model.ageMin),
                           @"ageMax":@(_model.ageMax),
                           @"typeName":[_selectArr componentsJoinedByString:@"、"],
                           @"remark":self.remarkTextView.text
                           };
    CastingModel *model = [CastingModel yy_modelWithDictionary:info];
    if (model.roleName.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写角色名称"];
        return;
    }
    if (model.typeName.length==0) {
        [SVProgressHUD showImage:nil status:@"请选择角色类型"];
        return;
    }
    //    if (model.remark.length==0) {
    //        [SVProgressHUD showImage:nil status:@"请填写角色备注"];
    //        return;
    //    }
    if (model.sex==0) {
        [SVProgressHUD showImage:nil status:@"请选择角色性别"];
        return;
    }
    if (model.heightMin==0) {
        [SVProgressHUD showImage:nil status:@"请选择角色最低身高"];
        return;
    }
    if (model.heightMax==0) {
        [SVProgressHUD showImage:nil status:@"请选择角色最高身高"];
        return;
    }
    if (model.ageMin==0) {
        [SVProgressHUD showImage:nil status:@"请选择角色最低年龄"];
        return;
    }
    if (model.ageMax==0) {
        [SVProgressHUD showImage:nil status:@"请选择角色最高年龄"];
        return;
    }
    if (_type==2) {
        
        model.roleId = _model.roleId;
    }
    
    if (_fromAsk) {
        if (_type==1) {//新建
            NSMutableDictionary *arg = [NSMutableDictionary new];
            [arg addEntriesFromDictionary:info];
            [arg setObject:@([[UserInfoManager getUserUID] integerValue]) forKey: @"userId"];
            [arg setObject:_projectId forKey: @"projectId"];
            [AFWebAPI_JAVA creatProjectCastingWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    self.VCAdd(model,_type);
                }else{
                    [SVProgressHUD showErrorWithStatus:object];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if (_type==2){//编辑
            NSMutableDictionary *arg = [NSMutableDictionary new];
            [arg addEntriesFromDictionary:info];
            [arg setObject:@([[UserInfoManager getUserUID] integerValue]) forKey: @"userId"];
            [arg setObject:_projectId forKey: @"projectId"];
            [arg setObject:@(_model.roleId) forKey:@"roleId"];
            [AFWebAPI_JAVA modifyCastingWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    self.VCAdd(model,_type);
                }else{
                    [SVProgressHUD showErrorWithStatus:object];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }else{
        if (_type==2) {//项目详情进来的编辑
            NSMutableDictionary *arg = [NSMutableDictionary new];
            [arg addEntriesFromDictionary:info];
            [arg setObject:@([[UserInfoManager getUserUID] integerValue]) forKey: @"userId"];
            [arg setObject:_projectId forKey: @"projectId"];
            [arg setObject:@(_model.roleId) forKey:@"roleId"];
            [AFWebAPI_JAVA modifyCastingWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    self.VCAdd(model,_type);
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }];
        }else if (_type==1){//项目进来的新建{
            self.VCAdd(model,_type);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
-(void)resetSexBtns
{
    [self.manBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
    self.manBtn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
    [self.femaleBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
    self.femaleBtn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
    [self.anyBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
    self.anyBtn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>0)
    {
        self.remarkLabel.hidden=YES;
    }
    else
    {
        self.remarkLabel.hidden=NO;
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length>9) {
        if (string.length==0) {//在删除
            return YES;
        }else if (string.length>0) //还想加字，不允许
        {
            return NO;
        }
    }
    if ([string isEqualToString:@"\n"]) {
        
        [textField resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}
-(void)tapAction:(id)tap
{
    [self.roleNameField resignFirstResponder];
    [self.remarkTextView resignFirstResponder];
}
- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
