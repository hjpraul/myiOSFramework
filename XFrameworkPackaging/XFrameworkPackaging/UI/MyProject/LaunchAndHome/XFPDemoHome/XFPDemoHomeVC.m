//
//  XFPDemoHomeVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/24.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPDemoHomeVC.h"
#import "UIView+BGLoading.h"

@interface XFPDemoHomeVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XFPDemoHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackButtonVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - UITableView Data Sourceer
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"工具类";
            break;
        case 1:
            return @"动画类";
            break;
        default:
            return nil;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XFPDemoHomeCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XFPDemoHomeCell"];
    }
    
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"SwipeTableCell Demo";
                    break;
                case 1:
                    cell.textLabel.text = @"Loading/Alert/Toast Demo";
                    break;
                case 2:
                    cell.textLabel.text = @"Palette Demo";
                    break;
                default:
                    break;
            }
        }break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    [_tableView showBGLoadingWithMessage:@"加载中..."];
                    [_tableView performSelector:@selector(showBGNoInfoWithMessage:) withObject:@"失败，失败，失败" afterDelay:3];
                }break;
                case 1:{
                }break;
                case 2:{
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PaletteDemo" bundle:nil];
                    [self.navigationController presentViewController:sb.instantiateInitialViewController animated:YES completion:nil];
                }break;
                default:
                    break;
            }
        }break;
            
        default:
            break;
    }
}


@end
