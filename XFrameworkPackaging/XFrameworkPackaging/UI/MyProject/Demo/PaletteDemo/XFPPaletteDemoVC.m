//
//  XFPPaletteDemoVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/5/7.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPPaletteDemoVC.h"
#import "XFPBSPalette.h"

@interface XFPPaletteDemoVC ()
@property (strong, nonatomic) IBOutlet XFPBSPalette *paletteView;
@property (weak, nonatomic) IBOutlet UIView *colorPreview;
@property (weak, nonatomic) IBOutlet UILabel *argbDesc;
@end

@implementation XFPPaletteDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak XFPPaletteDemoVC *weakSelf = self;
    _paletteView.selectedColorChangedBlock = ^(UIColor *color) {
        weakSelf.colorPreview.backgroundColor = color;
        CIColor *ciColor = [CIColor colorWithCGColor:color.CGColor];
        weakSelf.argbDesc.text = [NSString stringWithFormat:@"A:%.0f  R:%.0f  G:%.0f  B:%.0f",ciColor.alpha*255,ciColor.red*255,ciColor.green*255,ciColor.blue*255];
    };
}

- (void)customViewDidLoad{
    [_paletteView setSelectedColor:[UIColor colorWithRed:247/255.0 green:255/255.0 blue:31/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
