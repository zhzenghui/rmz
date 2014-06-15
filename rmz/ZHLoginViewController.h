//
//  ZHLoginViewController.h
//  rmz
//
//  Created by zeng hui on 14/6/10.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"

@interface ZHLoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *user_name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *conf_password;
@property (weak, nonatomic) IBOutlet UITextField *email;



- (IBAction)registration:(id)sender;
- (IBAction)login:(id)sender;

@end
