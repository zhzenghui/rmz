//
//  ZHViewController.h
//  rmz
//
//  Created by zeng hui on 14-4-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableArray *viewControllers;
    UINavigationController *currentViewController;
}



@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (strong, nonatomic)  UIView *baseView;

- (IBAction)openSetting:(id)sender;

- (IBAction)openViewController:(UIButton *)sender;
@end
