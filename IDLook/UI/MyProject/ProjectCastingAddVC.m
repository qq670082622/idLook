//
//  ProjectCastingAddVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectCastingAddVC.h"
#import "UseSelectPopView.h"
#import "ProjectTypeView.h"
@interface ProjectCastingAddVC ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)sexAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
- (IBAction)minHeiAction:(id)sender;
- (IBAction)maxHeiAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *minHeiLabel;
@property (weak, nonatomic) IBOutlet UIButton *minHeiBtn;
@property (weak, nonatomic) IBOutlet UILabel *heiLine;
@property (weak, nonatomic) IBOutlet UILabel *maxHeiLabel;
@property (weak, nonatomic) IBOutlet UIButton *maxHeiBtn;
@property (weak, nonatomic) IBOutlet UILabel *minAge;
@property (weak, nonatomic) IBOutlet UIButton *minAgeBtn;
@property (weak, nonatomic) IBOutlet UILabel *ageLine;
@property (weak, nonatomic) IBOutlet UILabel *maxAge;
@property (weak, nonatomic) IBOutlet UIButton *maxAgeBtn;

- (IBAction)minAgeAction:(id)sender;
- (IBAction)maxAgeAction:(id)sender;

- (IBAction)typeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarkField;
@property (weak, nonatomic) IBOutlet UIButton *savaBtn;
- (IBAction)saveAction:(id)sender;


@end

@implementation ProjectCastingAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:_type==1?@"新建角色":@"编辑角色"]];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapGesturRecognizer];
    self.savaBtn.layer.cornerRadius = 8;
    self.savaBtn.layer.masksToBounds = YES;
    if (_type==2) {
         [self initUIWithEdit];
    }
   
}


-(void)initUIWithEdit
{
   
   
    if (_model.roleName.length>0) {
        self.nameTextField.text = _model.roleName;
    }
   
    if(_model.sex!=0){
        self.sexLabel.text = _model.sex==1?@"男":@"女";
        self.sexLabel.textColor = Public_Text_Color;
    }
   
    if(_model.heightMin>0){
        self.minHeiLabel.text = [NSString stringWithFormat:@"%ld",_model.heightMin];
        self.minHeiLabel.textColor = Public_Text_Color;
    }
  
    if(_model.heightMax>0){
        self.maxHeiLabel.text = [NSString stringWithFormat:@"%ld",_model.heightMax];
        self.maxHeiLabel.textColor = Public_Text_Color;
    }
    if(_model.ageMin>0){
        self.minAge.text = [NSString stringWithFormat:@"%ld",_model.ageMin];
        self.minAge.textColor = Public_Text_Color;
    }
    
    if(_model.ageMax>0){
        self.maxAge.text = [NSString stringWithFormat:@"%ld",_model.ageMax];
        self.maxAge.textColor = Public_Text_Color;
    }
   
    if (_model.typeName.length>0) {
        self.typeLabel.text = _model.typeName;
          self.typeLabel.textColor = Public_Text_Color;
    }
   
    if (_model.remark.length>0) {
        self.remarkField.text = _model.remark;
        self.remarkLabel.hidden = YES;
    }
    [self mutibleUILayout];
}
- (IBAction)sexAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.remarkField resignFirstResponder];
    WeakSelf(self);
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
    popv.dataSource = [NSArray arrayWithObjects:@"男",@"女",nil];
    popv.title = @"选择性别";
    popv.selectStr = _sexLabel.text;
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
        weakself.sexLabel.text = string;
        weakself.sexLabel.textColor = Public_Text_Color;
    };
}
- (IBAction)minHeiAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.remarkField resignFirstResponder];
    WeakSelf(self);
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
    NSMutableArray *heis = [NSMutableArray new];
    for(int i = 0;i<200;i++){
        NSInteger hei = 50+i;
        [heis addObject:[NSString stringWithFormat:@"%ldcm",hei]];
    }
    popv.dataSource = [heis copy];
    popv.title = @"选择最低身高";
    popv.selectStr = [NSString stringWithFormat:@"%@cm",_minHeiLabel.text];
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
        weakself.minHeiLabel.text = [string stringByReplacingOccurrencesOfString:@"cm" withString:@""];
        weakself.minHeiLabel.textColor = Public_Text_Color;
         [weakself mutibleUILayout];
    };
}

- (IBAction)maxHeiAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.remarkField resignFirstResponder];
    WeakSelf(self);
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
    NSMutableArray *heis = [NSMutableArray new];
     NSInteger minHei = [_minHeiLabel.text integerValue];
    for(int i = 0;i<200-minHei;i++){
       NSInteger hei = minHei+i;
        [heis addObject:[NSString stringWithFormat:@"%ldcm",hei]];
    }
    popv.dataSource = [heis copy];
    popv.title = @"选择最高身高";
    popv.selectStr = [NSString stringWithFormat:@"%@cm",_maxHeiLabel.text];
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
        weakself.maxHeiLabel.text = [string stringByReplacingOccurrencesOfString:@"cm" withString:@""];
         weakself.maxHeiLabel.textColor = Public_Text_Color;
         [weakself mutibleUILayout];
    };
}

- (IBAction)minAgeAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.remarkField resignFirstResponder];
    WeakSelf(self);
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
    NSMutableArray *ages = [NSMutableArray new];
    for(int i = 0;i<99;i++){
        NSInteger age = 1+i;
        [ages addObject:[NSString stringWithFormat:@"%ld岁",age]];
    }
    popv.dataSource = [ages copy];
    popv.title = @"选择最低年龄";
    popv.selectStr = [NSString stringWithFormat:@"%@岁",_minAge.text];
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
        weakself.minAge.text = [string stringByReplacingOccurrencesOfString:@"岁" withString:@""];
        weakself.minAge.textColor = Public_Text_Color;
         [weakself mutibleUILayout];
    };
}

- (IBAction)maxAgeAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.remarkField resignFirstResponder];
    WeakSelf(self);
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
    NSMutableArray *ages = [NSMutableArray new];
    NSInteger maxAge = [_minAge.text integerValue];
    for(int i = 0;i<99-maxAge;i++){
        NSInteger age = maxAge+i;
        [ages addObject:[NSString stringWithFormat:@"%ld岁",age]];
    }
    popv.dataSource = [ages copy];
    popv.title = @"选择最高年龄";
    popv.selectStr = [NSString stringWithFormat:@"%@岁",_maxAge.text];
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
        weakself.maxAge.text = [string stringByReplacingOccurrencesOfString:@"岁" withString:@""];
        weakself.maxAge.textColor = Public_Text_Color;
         [weakself mutibleUILayout];
    };
}

- (IBAction)typeAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.remarkField resignFirstResponder];
    ProjectTypeView *typeView = [[ProjectTypeView alloc] init];
    [typeView showTypeWithSelectTypes:[_typeLabel.text stringByReplacingOccurrencesOfString:@"请选择角色类型" withString:@""]];
    WeakSelf(self);
    typeView.typeSelectAction = ^(NSString * _Nonnull str) {
        weakself.typeLabel.text = str;
           weakself.typeLabel.textColor = Public_Text_Color;
    };
}
- (IBAction)saveAction:(id)sender {
    NSInteger sex=0;
    if ( [self.sexLabel.text isEqualToString:@"男"]) {
        sex=1;
    } else if ([self.sexLabel.text isEqualToString:@"女"]){
        sex=2;
    }else{
        sex=0;
    }
    NSDictionary *info = @{
                           @"roleName":self.nameTextField.text,
                           @"sex":@(sex),
                           @"heightMin":@([self.minHeiLabel.text integerValue]),
                           @"heightMax":@([self.maxHeiLabel.text integerValue]),
                           @"ageMin":@([self.minAge.text integerValue]),
                           @"ageMax":@([self.maxAge.text integerValue]),
                           @"typeName":self.typeLabel.text,
                           @"remark":self.remarkField.text
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
-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
}
#pragma mark - textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length>199) {
        if (text.length==0) {//在删除
            return YES;
        }else if (text.length>0) //还想加字，不允许
        {
            return NO;
        }
    }
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}
//-(BOOL)textfiel
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
- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)tapAction:(id)tap

{
    [self.nameTextField resignFirstResponder];
    [self.remarkField resignFirstResponder];
}
-(void)mutibleUILayout
{
    [self.minHeiLabel sizeToFit];
    [self.maxHeiLabel sizeToFit];
    self.minHeiLabel.frame = CGRectMake(124, 109, _minHeiLabel.width, 23);
    self.minHeiBtn.frame = self.minHeiLabel.frame;
    self.heiLine.x = _minHeiLabel.right+15;
    self.maxHeiLabel.frame = CGRectMake(_heiLine.right+15, 109, _maxHeiLabel.width, 23);
    self.maxHeiBtn.frame = self.maxHeiLabel.frame;
    [self.minAge sizeToFit];
    [self.maxAge sizeToFit];
    self.minAge.frame = CGRectMake(124, 157, _minAge.width, 23);
    self.minAgeBtn.frame = self.minAge.frame;
    self.ageLine.x = _minAge.right+15;
    self.maxAge.frame = CGRectMake(_ageLine.right+15, 157, _maxAge.width, 23);
    self.maxAgeBtn.frame = self.maxAge.frame;
}
@end
