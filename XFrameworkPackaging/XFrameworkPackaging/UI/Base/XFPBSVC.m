//
//  LHBSVC.m
//  CHLightHandle
//
//  Created by hjpraul on 15/1/17.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "LHBSVC.h"

@interface LHBSVC ()

@end

@implementation LHBSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置返回键
    [self setBackButtonVisible:YES];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIImage *navBGImg = [[UIImage imageNamed:@"bg_nav_title"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:navBGImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    
    [self performSelector:@selector(customViewDidLoad) withObject:nil afterDelay:0];
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
// 设置返回键
- (void)setBackButtonVisible:(BOOL)isVisible{
    if (!isVisible) {
        [self setLeftButtonWithTitle:nil
                               image:nil
                    highlightedImage:nil
                               bgImg:nil
                  highlightedBgImage:nil
                              action:nil];
        return;
    }
    UIImage *backBarImg = [UIImage imageNamed:@"icon_nav_back"];
    CGRect buttonFrame = CGRectMake(-10,
                                    0,
                                    40,
                                    44);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = buttonFrame;
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton setAdjustsImageWhenHighlighted:YES];
    [backButton setTitle:@"" forState:UIControlStateNormal];
    [backButton setImage:backBarImg forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(bsBackBarClicked) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat x = 0;
    if (isIOS7Above) {
        x = -10;
        //这个属性属于UIExtendedEdge类型，它可以单独指定矩形的四条边，也可以单独指定、指定全部、全部不指定。
        //指定视图的哪条边需要扩展，不用理会操作栏的透明度。这个属性的默认值是UIRectEdgeAll。
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //如果你使用了不透明的操作栏，设置edgesForExtendedLayout的时候也请将 extendedLayoutIncludesOpaqueBars的值设置为No（默认值是YES）
        self.extendedLayoutIncludesOpaqueBars = NO;
        //如果你不想让scroll view的内容自动调整，将这个属性设为NO（默认值YES）。
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 80, 44)];
    [backView addSubview:backButton];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backBarButtonItem setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:backBarButtonItem];
}

// 设置左边按钮
- (void)setLeftButtonWithTitle:(NSString *)title
                         image:(UIImage *)image
              highlightedImage:(UIImage *)hlImage
                         bgImg:(UIImage *)bgImage
            highlightedBgImage:(UIImage *)hlBgImage
                        action:(SEL)action{
    CGSize btnSize = CGSizeMake(50, 44);
//    if (bgImage) {
//        btnSize = bgImage.size;
//    }
    CGRect buttonFrame = CGRectMake(0,
                                    0,
                                    btnSize.width,
                                    btnSize.height);
    UIButton *backButton = [[UIButton alloc] initWithFrame:buttonFrame];
    [backButton setTitle:title forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [backButton setAdjustsImageWhenHighlighted:YES];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:hlImage forState:UIControlStateHighlighted];
    [backButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    [backButton setBackgroundImage:hlBgImage forState:UIControlStateHighlighted];
    [backButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:buttonFrame];
    [backView addSubview:backButton];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backBarButtonItem setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:backBarButtonItem];
}

// 设置右边按钮
- (void)setRightButtonWithTitle:(NSString *)title
                          image:(UIImage *)image
               highlightedImage:(UIImage *)hlImage
                          bgImg:(UIImage *)bgImage
             highlightedBgImage:(UIImage *)hlBgImage
                         action:(SEL)action{
    CGSize btnSize = CGSizeMake(80, 55);
    //    if (bgImage) {
    //        btnSize = bgImage.size;
    //    }
    CGRect buttonFrame = CGRectMake(0, 0, btnSize.width, btnSize.height);
    UIButton *rightButton = [[UIButton alloc] initWithFrame:buttonFrame];
    [rightButton setTitle:title forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [rightButton setAdjustsImageWhenHighlighted:YES];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton setImage:hlImage forState:UIControlStateHighlighted];
    [rightButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    [rightButton setBackgroundImage:hlBgImage forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 12, 0, -12);
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    
    UIView *rightView = [[UIView alloc] initWithFrame:buttonFrame];
    rightView.backgroundColor = [UIColor clearColor];
    [rightView addSubview:rightButton];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [rightBarButtonItem setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];
    
    CGFloat x = 0;
    if (isIOS7Above) {
        x = -20;
    }
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = x;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:flexSpacer,rightBarButtonItem,nil, nil]];
    //    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void)customViewDidLoad{
    
}

#pragma mark - Action Method
- (void)bsBackBarClicked{
    [self.view endEditing:YES];
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)bsRightBarClicked{
}
@end
