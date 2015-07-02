//
//  XFPObjectDaoVC.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/7/1.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPObjectDaoVC.h"
#import "XFPCommonDao.h"

#pragma mark - test Model
@interface testModel1 : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *number;
@end
@implementation testModel1
@end

@interface testModel2 : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@end
@implementation testModel2
@end

@interface testModel3 : NSObject<MJKeyValue,XFPDaoModelDelegate>
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) CGFloat amount;
@property (strong, nonatomic) testModel1 *model1;
@property (strong, nonatomic) NSArray *mode2s;
@property (strong, nonatomic) NSArray *stringModels;
@end
@implementation testModel3
+ (NSArray *)ignoredPropertyNames {
    return @[@"stringModels"];
}

- (void)dao2ModelPretreat{
}

- (void)model2DaoPretreat{
}
@end


@interface XFPObjectDaoVC ()

@end

@implementation XFPObjectDaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
#pragma mark - Action Method
- (IBAction)storeBtnClicked:(UIButton *)sender {
    testModel1 *mode1 = [[testModel1 alloc] init];
    mode1.name = @"mode1 name";
    mode1.number = @"11";
    
    testModel2 *mode21 = [[testModel2 alloc] init];
    mode21.title = @"mode21 title";
    mode21.desc = @"mode21 desc";
    testModel2 *mode22 = [[testModel2 alloc] init];
    mode22.title = @"mode22 title";
    mode22.desc = @"mode22 desc";
    testModel2 *mode23 = [[testModel2 alloc] init];
    mode23.title = @"mode23 title";
    mode23.desc = @"mode23 desc";
    
    testModel3 *mode3 = [[testModel3 alloc] init];
    mode3.name = @"mode 3";
    mode3.stringModels = @[@"1",@"2",@"3",@"4"];
    mode3.model1 = mode1;
    mode3.mode2s = @[mode21,mode22,mode23];
    mode3.index = 200;
    mode3.amount = 125.123;
    
    [XFPCommonDao storeObjects:@[mode3] toDBTB:@"test"];
}

- (IBAction)loadBtnClicked:(UIButton *)sender {
    [XFPCommonDao loadObjectsFromDBTB:@"test" className:@"testModel3" range:NSMakeRange(0, 0)];
}
@end
