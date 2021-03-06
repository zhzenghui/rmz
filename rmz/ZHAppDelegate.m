//
//  ZHAppDelegate.m
//  rmz
//
//  Created by zeng hui on 14-4-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHAppDelegate.h"
#import "ZHViewController.h"
#import "ZHLoginViewController.h"


@implementation ZHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    _user = [[User alloc] init];
    
    NSString *currentUser = [Cookie getCookie:KCurrentUser];
    
    if (currentUser) {
        
        NSDictionary *dict = [Cookie getCookie:currentUser];
        
        _user.name = dict[@"name"];
        _user.auth_token = dict[@"auth_token"];
        
#ifdef  DEBUG
        DLog(@"%@", dict);
#endif
        
    }

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ZHViewController *vc = [[ZHViewController alloc] initWithNibName:@"ZHViewController_35" bundle:nil];
    if (SCREEN_HEIGHT > 480) {
        
        vc = [[ZHViewController alloc] initWithNibName:@"ZHViewController_4" bundle:nil];
    }
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    

    NSString *currentUser = [Cookie getCookie:KCurrentUser];
    
    if ( ! currentUser) {
        
        
        
        
        ZHLoginViewController *login = [[ZHLoginViewController alloc] initWithNibName:@"ZHLoginViewController" bundle:nil];
        
        
        [self.window.rootViewController presentViewController:login animated:NO completion:^{
            
        }];
        
        
    }
    
    
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
