//
//  TouchTableV.h
//  IDLook
//
//  Created by HYH on 2018/5/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CustomTableV.h"

@protocol TableVTouchDelegate <NSObject>
@optional

- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface TouchTableV : CustomTableV
@property (nonatomic,assign)id<TableVTouchDelegate>touchDelegate;

@end
