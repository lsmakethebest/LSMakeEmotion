//
//  UploadImageView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "UploadImageView.h"
@interface UploadImageView () <
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate,
    UIActionSheetDelegate>


@end
@implementation UploadImageView

+ (void)showUpUploadImageViewWithBlockImage:(BlockImage)blockImage {

  UploadImageView *v = [[UploadImageView alloc] init];
  [[UIApplication sharedApplication].keyWindow addSubview:v];
  v.clickBlockImage = blockImage;
  if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {

    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:@"请选择图像"
                         message:nil
                  preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction
        actionWithTitle:@"相册"
                  style:(UIAlertActionStyleDefault)
                handler:^(UIAlertAction *_Nonnull action) {
                  UIImagePickerController *picker =
                      [[UIImagePickerController alloc] init];
                  picker.delegate = v;
                  picker.sourceType =
                      UIImagePickerControllerSourceTypePhotoLibrary;
                  [[UIApplication sharedApplication]
                          .keyWindow.rootViewController
                      presentViewController:picker
                                   animated:YES
                                 completion:nil];

                }];
    UIAlertAction *action2 = [UIAlertAction
        actionWithTitle:@"拍照"
                  style:(UIAlertActionStyleDefault)
                handler:^(UIAlertAction *_Nonnull action) {
                  UIImagePickerController *picker =
                      [[UIImagePickerController alloc] init];
                  picker.delegate = v;
                  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                  [[UIApplication sharedApplication]
                          .keyWindow.rootViewController
                      presentViewController:picker
                                   animated:YES
                                 completion:nil];
                }];
    UIAlertAction *action3 =
        [UIAlertAction actionWithTitle:@"取消"
                                 style:(UIAlertActionStyleCancel)
                               handler:^(UIAlertAction *_Nonnull action) {
                                 [v removeFromSuperview];

                               }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [[UIApplication sharedApplication]
            .keyWindow.rootViewController presentViewController:alert
                                                       animated:YES
                                                     completion:nil];
  } else {
    UIActionSheet *sheet =
        [[UIActionSheet alloc] initWithTitle:@"请选择"
                                    delegate:v
                           cancelButtonTitle:@"取消"
                      destructiveButtonTitle:nil
                           otherButtonTitles:@"相册", @"拍照", nil];
    [sheet showInView:[UIApplication sharedApplication]
                          .keyWindow.rootViewController.view];
  }
}

- (void)actionSheet:(UIActionSheet *)actionSheet
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;

  if (buttonIndex == 0) {
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [[UIApplication sharedApplication]
            .keyWindow.rootViewController presentViewController:picker
                                                       animated:YES
                                                     completion:nil];
  } else if (buttonIndex == 1) {

    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [[UIApplication sharedApplication]
            .keyWindow.rootViewController presentViewController:picker
                                                       animated:YES
                                                     completion:nil];
  } else if (buttonIndex == 2) {
    [self removeFromSuperview];
  }
}



- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
  [picker dismissViewControllerAnimated:YES completion:nil];
  UIImage *image = info[UIImagePickerControllerOriginalImage];
  if (!image) {
    [self removeFromSuperview];
    return;
  }
  if (self.clickBlockImage) {
    self.clickBlockImage(image);
  }
  [self removeFromSuperview];
}

@end
