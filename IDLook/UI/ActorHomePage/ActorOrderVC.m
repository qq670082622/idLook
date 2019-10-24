//
//  ActorOrderVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorOrderVC.h"
#import "CollectionActorView.h"
#import "ActorSearchModel.h"
@interface ActorOrderVC ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *darenTitle;
@property (weak, nonatomic) IBOutlet UIView *darenView;
@property (weak, nonatomic) IBOutlet UIImageView *darenIcon;
@property (weak, nonatomic) IBOutlet UIImageView *darenAgencyImg;
@property (weak, nonatomic) IBOutlet UILabel *darenName;
@property (weak, nonatomic) IBOutlet UILabel *darenName2;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addDaren:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *serviceTypeView;

@property (weak, nonatomic) IBOutlet UIView *planView;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *planName;
@property (weak, nonatomic) IBOutlet UITextField *budget;

@property (weak, nonatomic) IBOutlet UIView *contactView;
@property (weak, nonatomic) IBOutlet UITextField *contanctName;
@property (weak, nonatomic) IBOutlet UITextField *contactPosition;
@property (weak, nonatomic) IBOutlet UITextField *contanctPhoneNum;

@property (weak, nonatomic) IBOutlet UIView *submitView;
- (IBAction)submitAction:(id)sender;

@property(nonatomic,strong)NSArray *tagsArr;
@property(nonatomic,strong)NSMutableArray *selectTags;
@property(nonatomic,strong)NSMutableArray *darenArr;
@end

@implementation ActorOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addBtn.layer.borderWidth = 1;
    self.addBtn.layer.borderColor = [UIColor colorWithHexString:@"ff6600"].CGColor;
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.cornerRadius = 5;
    _selectTags = [NSMutableArray new];
    _darenArr = [NSMutableArray new];
  
    [self.darenIcon sd_setImageWithUrlStr:_userModel.avatar placeholderImage:[UIImage imageNamed:@"default_icon"]];
    if (!_userModel.agencyOperation) {
        self.darenAgencyImg.hidden = YES;
    }
    self.darenName.text = _userModel.nickName;
    [self.darenName sizeToFit];
  
    if (_userModel.academy.length>0) {
         self.darenName2.text = [NSString stringWithFormat:@"带货达人 • %@",_userModel.academy];
    }else{
        self.darenName2.text = @"带货达人";
    }
    _darenName2.x = _darenName.right+10;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"定制带货服务"]];
    [AFWebAPI_JAVA checkOrderTypeWithArg:[NSArray new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            _tagsArr = [NSArray arrayWithArray:object[@"body"]];
            [self resetScrollViewWithTypeView:YES];
        }
    }];
}


- (IBAction)addDaren:(id)sender {
    WeakSelf(self);
    [AFWebAPI_JAVA checkCollectionActorsWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSArray *body = object[@"body"];
            if (body.count==0 || [body isKindOfClass:[NSNull class]]) {
                [SVProgressHUD showImage:nil status:@"暂无可添加的达人，请先去收藏"];
            }else if (body.count>0){
               
                CollectionActorView *caView = [[CollectionActorView alloc] init];
                [caView showWithSelectActors:_darenArr noSystemId:_userModel.actorId];
                caView.selectActors = ^(NSArray * _Nonnull arr) {
                    weakself.darenArr = [NSMutableArray arrayWithArray:arr];
                    [weakself resetDarenViewWithRenew:YES];
                };
            }
        }
        
    }];
}
-(void)resetDarenViewWithRenew:(BOOL)reNew
{
    if (reNew) {
        //清除已经有的btn 重新添加
        for(id subViews in _darenView.subviews){
            if ((UIImageView *)subViews == _darenIcon){
                continue;
            }else if ((UILabel *)subViews == _darenName){
                continue;
            }else if ((UILabel *)subViews == _darenName2){
                continue;
            }else if ((UIButton *)subViews == _addBtn){
                continue;
            }else if ((UILabel *)subViews == _darenTitle){
                continue;
            }else if ((UIImageView *)subViews == _darenAgencyImg){
                continue;
            }
            [subViews removeFromSuperview];
    }
    }
    CGFloat addBtnY = 0;
    if (_darenArr.count>0) {
        for(int i = 0;i<_darenArr.count;i++){
            ActorSearchModel *user = _darenArr[i];
            UIImageView *icon = [UIImageView new];
            [icon sd_setImageWithUrlStr:user.headPorUrl placeholderImage:[UIImage imageNamed:@"default_icon"]];
            icon.layer.cornerRadius = 21;
            icon.layer.masksToBounds = YES;
            
            //if (!model.agencyOperation) {
//                self.agency.hidden = YES;
//            }
            UIImageView *agencyImg = [UIImageView new];
            agencyImg.image = [UIImage imageNamed:@"homepage_daren_logo"];
           
            UILabel *name1 = [UILabel new];
            name1.text = user.nikeName;
            name1.textColor = [UIColor colorWithHexString:@"333333"];
            name1.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
            
            UILabel *name2 = [UILabel new];
           // name2.text = [NSString stringWithFormat:@"带货达人 • %@毕业生",user.academy];
            if (user.academy.length>0) {
                name2.text = [NSString stringWithFormat:@"带货达人 • %@",user.academy];
            }else{
               name2.text = @"带货达人";
            }
            name2.textColor = [UIColor colorWithHexString:@"333333"];
            name2.font = [UIFont systemFontOfSize:13];
            
            UIButton *dele = [UIButton buttonWithType:0];
         [dele setImage:[UIImage imageNamed:@"customized_delete_icon"] forState:0];
            [dele addTarget:self action:@selector(deleteActor:) forControlEvents:UIControlEventTouchUpInside];
            [dele setTag:i+200];
            
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
            
            CGFloat lineY = (_darenIcon.bottom+12)+i*(66);
            CGFloat icony = lineY+12;
            CGFloat name1Y = lineY + 22;
            CGFloat name2y = lineY + 24;
            CGFloat deleY = lineY + 24;
            icon.frame = CGRectMake(12, icony, 42, 42);
            agencyImg.frame = CGRectMake(12,icony + 33, 42, 19);
            name1.frame = CGRectMake(64, name1Y, 19*user.nikeName.length, 23);
            
            name2.frame = CGRectMake(name1.right+10, name2y, 250, 19);
            dele.frame = CGRectMake(_darenView.width-18-12, deleY, 18, 18);
            line.frame = CGRectMake(12, lineY, UI_SCREEN_WIDTH-48, 0.5);
            [self.darenView addSubview:icon];
            [self.darenView addSubview:agencyImg];
            [self.darenView addSubview:name1];
            [self.darenView addSubview:name2];
            [self.darenView addSubview:line];
            [self.darenView addSubview:dele];
            addBtnY = lineY+73;
        }
        _addBtn.frame = CGRectMake(12, addBtnY, UI_SCREEN_WIDTH-48, 48);
        _darenView.height = _addBtn.bottom + 20;
        [self resetScrollViewWithTypeView:NO];
    }else if (_darenArr.count == 0){
        _addBtn.frame = CGRectMake(12, 105, UI_SCREEN_WIDTH-48, 48);
        _darenView.height = 173;
        [self resetScrollViewWithTypeView:NO];
    }
}
-(void)resetScrollViewWithTypeView:(BOOL)renewTypeview
{
    
    if (renewTypeview) {
        //清除已经有的btn 重新添加
        for(int i = 0;i<_tagsArr.count;i++){
            UIButton *btn = [_serviceTypeView viewWithTag:i+100];
            if(btn){
                [btn removeFromSuperview];
            }
        }
        CGFloat wid = (UI_SCREEN_WIDTH-24-24-18)/3;
        CGFloat serviceHei = 0;
        for(int i = 0;i<_tagsArr.count;i++){
            NSDictionary *tagDic = _tagsArr[i];
            NSString *typeName = tagDic[@"name"];
            NSInteger row = i/3;
            NSInteger yu = i%3;
            CGFloat x = yu*(wid+9)+12;//余出*(宽+间隔)+第一个按钮x
            CGFloat y = row*(40+10)+52;//行数*(高+间隔)+第一个按钮y
            UIButton *typeBtn = [UIButton buttonWithType:0];
            [typeBtn setTitle:typeName forState:0];
            typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [typeBtn setTitleColor:Public_Text_Color forState:0];
            [typeBtn setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
            typeBtn.layer.cornerRadius = 4;
            typeBtn.layer.masksToBounds = YES;
            
            typeBtn.frame = CGRectMake(x, y, wid, 40);
            [typeBtn setTag:i+100];
            [typeBtn addTarget:self action:@selector(typeSelect:) forControlEvents:UIControlEventTouchUpInside];
            [self.serviceTypeView addSubview:typeBtn];
            serviceHei = typeBtn.bottom+20;
        }
        self.serviceTypeView.frame = CGRectMake(12, _darenView.bottom+10, UI_SCREEN_WIDTH-24, serviceHei);
    }else{
        self.serviceTypeView.y = _darenView.bottom+10;
    }
    
    self.planView.y = _serviceTypeView.bottom + 10;
    self.contactView.y = _planView.bottom+10;
   
    self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _contactView.bottom+20);
    
    
}
-(void)deleteActor:(id)sender
{
     UIButton *tagBtn = (UIButton *)sender;
   NSInteger deleIndex = tagBtn.tag - 200;
    [_darenArr removeObjectAtIndex:deleIndex];
    [self resetDarenViewWithRenew:YES];
}
-(void)typeSelect:(id)sender
{
    UIButton *tagBtn = (UIButton *)sender;
    NSString *btnTitle = tagBtn.titleLabel.text;
    if ([_selectTags containsObject:btnTitle]) {//删除
        [_selectTags removeObject:btnTitle];
         [tagBtn setTitleColor:Public_Text_Color forState:0];
        [tagBtn setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
        tagBtn.layer.borderWidth = 0;
    }else{
        [_selectTags addObject:btnTitle];//添加
        [tagBtn setTitleColor:Public_Red_Color forState:0];
        [tagBtn setBackgroundColor:[UIColor colorWithHexString:@"f4e8ec"]];
        tagBtn.layer.borderColor = Public_Red_Color.CGColor;
        tagBtn.layer.borderWidth = 1;
    }
}
- (IBAction)submitAction:(id)sender {
    if (_budget.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写预算金额"];
        return;
    }
    if (_companyName.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写公司名称"];
        return;
    }
    if (_contanctPhoneNum.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写联系号码"];
        return;
    }
    if (_contactPosition.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写您的职位"];
        return;
    }
    if (_planName.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写企划名称"];
        return;
    }
    if (_tagsArr.count==0) {
        [SVProgressHUD showImage:nil status:@"请选择服务类别"];
        return;
    }
    NSMutableArray *actorIds = [NSMutableArray new];
    for (ActorSearchModel *model in _darenArr) {
        [actorIds addObject:[NSString stringWithFormat:@"%ld",model.userId]];
    }
    [actorIds addObject:[NSString stringWithFormat:@"%ld",_userModel.actorId]];
    NSDictionary *arg = @{
                          @"budget": @([_budget.text integerValue]),
                          @"companyName":_companyName.text,
                          @"expertId":[actorIds componentsJoinedByString:@","],
                         // "id": 0,
                          @"linkmanContact":_contanctPhoneNum.text,
                          @"linkmanName":_contanctName.text,
                          @"linkmanPosition":_contactPosition.text,
                          @"projectName":_planName.text,
                        //  "remark": "string",
                          @"serviceType":[_selectTags componentsJoinedByString:@","],
                          @"userId":@([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA addCustomOrderWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功，我们会在24小时内联系您"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==1) {
        return YES;//tag==1的textfield需要控制文字长度
    }
    if (textField.text.length>50) {
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.companyName resignFirstResponder];
    [self.planName resignFirstResponder];
    [self.budget resignFirstResponder];
    [self.contanctName resignFirstResponder];
    [self.contactPosition resignFirstResponder];
    [self.contanctPhoneNum resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)onGoback
{
[self.navigationController popViewControllerAnimated:YES];
}
@end
