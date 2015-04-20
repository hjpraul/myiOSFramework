//
//  XFPSinglePicPicker.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/4/20.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPSinglePicPicker.h"

@interface XFPSinglePicPicker ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (copy, nonatomic) void (^completedBlock)(UIImage *image);
@property (assign, nonatomic) CGFloat maxSize;
@end

@implementation XFPSinglePicPicker
- (instancetype)initWithCompleted:(void(^)(UIImage *image))completedBlock
                          maxSize:(CGFloat)maxSize{
    self = [super init];
    if (self) {
        self.maxSize = maxSize;
        self.completedBlock = completedBlock;
    }
    return self;
}

#pragma mark - UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]){
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage *retImage = nil;
        if (_maxSize <= 0) {
            retImage = image;
        } else {
            retImage = [image imageScaledToSize:CGSizeMake(_maxSize, _maxSize) aspectRatio:YES];
        }
//        NSData *data;
//        if (UIImagePNGRepresentation(image) == nil) {
//            data = UIImageJPEGRepresentation(image, 1.0);
//        } else {
//            data = UIImagePNGRepresentation(image);
//        }
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        BLOCK_SAFE(_completedBlock)(retImage);
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
