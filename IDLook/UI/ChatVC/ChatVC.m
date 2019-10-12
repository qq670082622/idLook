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
@interface ChatVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *textBg;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)add:(id)sender;
- (IBAction)albumAction:(id)sender;
- (IBAction)takePhotoAction:(id)sender;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSTimer *msTimer;
//@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger msId;
@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
       [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"脸探客服"]];
    _data = [NSMutableArray new];
    self.textBg.layer.cornerRadius = 13;
    self.textBg.layer.masksToBounds = YES;
    self.textBg.y = self.view.height-70;
    self.tableV.height = self.view.height-70;
    self.textBg.y = 15;
    [self checkMessageList];
      _msTimer =  [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkMessageList) userInfo:nil repeats:YES];
    //注册键盘出现的通知
       [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(keyboardWillShow:)
                                                    name:UIKeyboardWillShowNotification object:nil];
       //注册键盘消失的通知
       [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(keyboardWillHide:)
                                                    name:UIKeyboardWillHideNotification object:nil];
//    _pageNum = 1;
}
-(void)checkMessageList
{
    NSDictionary *dic = @{
        @"pageCount":@(25),
      //  @"pageNumber":@(_pageNum),
        @"userId":@([[UserInfoManager getUserUID] integerValue]),
        @"messageId":@(_msId)
    };
    [AFWebAPI_JAVA chekMessageListWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSInteger beforeCount = _data.count;
            NSArray *list = object[@"body"][@"messages"];
            for (NSDictionary *messageDic in list) {
                ChatModel *msModel = [ChatModel yy_modelWithDictionary:messageDic];
                [_data addObject:msModel];
            }
            if (_data.count>0) {
                ChatModel *lastModel = [_data lastObject];
                _msId = lastModel.id;
            }
            [self.tableV reloadData];
            
            if (_data.count>beforeCount) {
                  //自动滚动到底部
                         [_tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_data.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
          }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    ChatModel *model = _data[indexPath.row];
    if (model.state==1) {
        ChatUserCell *cell = [ChatUserCell cellWithTableView:tableView];
        cell.model = model;
        cell.tapImg = ^(NSString * _Nonnull url) {
            [weakself lookPhotoWithArray:[NSArray arrayWithObject:model.message] WithIndex:0];
        };
        return cell;
    }else{
        ChatCell *cell = [ChatCell cellWithTableView:tableView];
        cell.model = model;
        cell.tapImg = ^(NSString * _Nonnull url) {
                [weakself lookPhotoWithArray:[NSArray arrayWithObject:model.message] WithIndex:0];
               };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell = [ChatCell cellWithTableView:tableView];
     ChatModel *model = _data[indexPath.row];
    cell.model = model;
    return cell.cellHei;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (IBAction)add:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.y = _bottomView.y-=70;//实际显示124。留一些做layer切圆
        self.tableV.height = _tableV.height-=70;
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    if (textField.text.length>0) {
         NSDictionary *arg = @{
               @"message" : textField.text,
               @"state":@(1),
               @"type":@(1),
               @"userId":@([[UserInfoManager getUserUID] integerValue])
         };
           [AFWebAPI_JAVA sendMessageWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
               if (success) {
                   textField.text = @"";
                   [self checkMessageList];
               }else{
                   [SVProgressHUD showErrorWithStatus:@"消息发送失败，请稍后重试"];
               }
           }];
    }
   
    return YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textField resignFirstResponder];
}
- (IBAction)albumAction:(id)sender {
           UIImagePickerController *picker = [[UIImagePickerController alloc] init];
           picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
           picker.delegate = self;
           picker.allowsEditing = YES;
           [self presentViewController:picker animated:YES completion:^{}];
}

- (IBAction)takePhotoAction:(id)sender {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
         UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:^{}];
          
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [UIView animateWithDuration:0.3 animations:^{
           self.bottomView.y = _bottomView.y+=70;//实际显示124。留一些做layer切圆
           self.tableV.height = _tableV.height+=70;
       }];
    [SVProgressHUD showWithStatus:@"" maskType:SVProgressHUDMaskTypeClear];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
                  NSData *data = UIImageJPEGRepresentation(image, 0.7);
            [AFWebAPI_JAVA fileUpLoadWithArg:[NSDictionary new] data:data callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    NSDictionary *response = object[@"body"];
                    NSString *url = response[@"url"];
                        NSDictionary *arg = @{
                                           @"message" : url,
                                           @"state":@(1),
                                           @"type":@(2),
                                           @"userId":@([[UserInfoManager getUserUID] integerValue])
                                       };
                                       [AFWebAPI_JAVA sendMessageWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
                                           if (success) {
                                               [SVProgressHUD dismiss];
                                               [self checkMessageList];
                                           }else{
                                                [SVProgressHUD showErrorWithStatus:@"图片发送失败，请稍后重试"];
                                           }
                                       }];
                         }
                     }];
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [UIView animateWithDuration:0.3 animations:^{
           self.bottomView.y = _bottomView.y+=70;//实际显示124。留一些做layer切圆
           self.tableV.height = _tableV.height+=70;
       }];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
         NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
         CGRect keyboardRect = [aValue CGRectValue];
         int y = keyboardRect.origin.y;
  self.bottomView.y = y-125;
    if (public_isX) {
         self.bottomView.y = y-150;
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
  
    self.bottomView.y = self.view.height-65;
    self.tableV.height = self.view.height-70;
}
//查看图片大图
-(void)lookPhotoWithArray:(NSArray*)array WithIndex:(NSInteger)index
{
   LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    [lookImage showWithImageArray:array curImgIndex:0 AbsRect:CGRectMake(0, 0,0,0)];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {  //下载回掉
       
    };
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_msTimer invalidate];
    _msTimer = nil;
}
- (void)onGoback
{
  
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
 
