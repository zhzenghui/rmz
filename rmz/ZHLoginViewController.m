//
//  ZHLoginViewController.m
//  rmz
//
//  Created by zeng hui on 14/6/10.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHLoginViewController.h"
#import "AFNetworking.h"
#import "TWMessageBarManager.h"



@interface ZHLoginViewController ()

@end

@implementation ZHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _email.text = @"email1gg@gdd.com";
    _user_name.text = @"zhemailgg";
    
    _password.text = @"123123";
    _conf_password.text = @"123123";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registration:(id)sender {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSDictionary *userDict = @{@"email": _email.text,
                               @"name": _user_name.text,
                               @"password": _password.text,
                               @"password_confirmation": _conf_password.text};
    NSDictionary *parameters = @{@"user": userDict };
    
    NSString *url = [NSString stringWithFormat:@"%@registrations", KHomeApiUrl];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)loginOut:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSDictionary *userDict = @{@"email": _email.text,
                               @"password": _password.text};
    NSDictionary *parameters = @{@"user": userDict };
    
    NSString *url = [NSString stringWithFormat:@"%@sessions", KHomeApiUrl];
    [manager DELETE:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


}

- (void)saveUserInfo:(NSDictionary *)data
{
    NSString *currentUser = [Cookie getCookie:@"current"];
    

    

    [Cookie setCookie:KCurrentUser value:_email.text];
    [Cookie setCookie:_email.text  value:data[@"data"]];
    
    
    SharedAppUser.name = data[@"name"];
    SharedAppUser.auth_token = data[@"auth_token"];
}
- (IBAction)login:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];

    NSDictionary *userDict = @{@"email": _email.text,
                               @"password": _password.text};
    NSDictionary *parameters = @{@"user": userDict };
    
    NSString *url = [NSString stringWithFormat:@"%@sessions", KHomeApiUrl];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        
        if ([dict[@"status"] intValue] == 1    ) {
            [self saveUserInfo:dict];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        else {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"登录失败"
                                                           description:@"" type:TWMessageBarMessageTypeError];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self loginOut:nil];
        NSLog(@"Error: %@", error);
    }];

    
    
    
}
@end
