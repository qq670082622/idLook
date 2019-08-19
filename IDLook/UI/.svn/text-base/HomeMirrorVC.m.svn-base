//
//  HomeMirrorVC.m
//  IDLook
//
//  Created by HYH on 2018/7/9.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeMirrorVC.h"

@interface HomeMirrorVC ()

@end

@implementation HomeMirrorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"微出镜"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
