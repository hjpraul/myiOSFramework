//
//  XFPSwipeCellDemoVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/20.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPSwipeCellDemoVC.h"
#import "XFPSwipeCellDemoCell.h"
#import "MGSwipeTableCell.h"

@interface XFPSwipeCellDemoVC ()<MGSwipeTableCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation XFPSwipeCellDemoVC
#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XFPSwipeCellDemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XFPSwipeCellDemoCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setDataSource];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

#pragma mark - MGSwipeTableCellDelegate
-(BOOL) swipeTableCell:(MGSwipeTableCell*)cell canSwipe:(MGSwipeDirection)direction{
    if (direction == MGSwipeDirectionRightToLeft) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    [[NSString stringWithFormat:@"第%zd个按钮点击",indexPath.row] toast];
    return YES;
}
@end
