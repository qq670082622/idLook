//
//  WebVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/17.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()

@property (weak, nonatomic) IBOutlet UIWebView *web;
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:_navTitle]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    NSURL *filePath = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:_fileName ofType:@"pdf"]];
    NSURLRequest *request = [NSURLRequest requestWithURL: filePath];
    [_web loadRequest:request];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
