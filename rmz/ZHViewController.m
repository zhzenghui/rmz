//
//  ZHViewController.m
//  rmz
//
//  Created by zeng hui on 14-4-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHViewController.h"
#import "ZHSettingViewController.h"
#import "ZHTimeLineViewController.h"
#import "ZHExploreViewController.h"
#import "ZHMessageViewController.h"
#import "ZHTakePhotoViewController.h"
#import "IAPShare.h"
#import "VideoViewcontroller.h"

#import "InAppViewController.h"


#define kPage_Size 25


@interface ZHViewController ()

@end

@implementation ZHViewController

- (IBAction)openSetting:(id)sender {
    
    ZHSettingViewController *setting = [[ZHSettingViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:setting];

    [self.baseView addSubview:nav.view];
    [self addChildViewController:nav];

}

- (void)openInAppViewController
{
    InAppViewController *inApp = [[InAppViewController alloc] init];
    
    
    [self.baseView addSubview:inApp.view];
    [self addChildViewController:inApp];
}


- (void)loadViewController:(int)index
{
    currentViewController = viewControllers[index];
    
    
    [self.baseView addSubview:currentViewController.view];
    [self addChildViewController:currentViewController];
}

- (IBAction)openViewController:(UIButton *)sender {
    

    if (currentViewController) {
        
        [currentViewController removeFromParentViewController];
        [currentViewController.view removeFromSuperview];
    }
    

    [self loadViewController:sender.tag -1];
    
    
}

- (void)loadViewControllers
{
    ZHTimeLineViewController *tl = [[ZHTimeLineViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tl];

    ZHExploreViewController *ep = [[ZHExploreViewController alloc] init];
    UINavigationController *navEP = [[UINavigationController alloc] initWithRootViewController:ep];
    
    ZHMessageViewController *ms = [[ZHMessageViewController alloc] init];
    UINavigationController *navMS = [[UINavigationController alloc] initWithRootViewController:ms];
    
    ZHSettingViewController *setting = [[ZHSettingViewController alloc] init];
    UINavigationController *navST = [[UINavigationController alloc] initWithRootViewController:setting];
    

    [viewControllers addObject:nav];
    [viewControllers addObject:navEP];
    [viewControllers addObject:navMS];
    [viewControllers addObject:navST];
    
    
    currentViewController = nav;
}


- (void)openVideoViewCongtoller
{
    VideoViewcontroller *kvc = [[VideoViewcontroller alloc] initWithNibName:@"VideoViewcontroller" bundle:nil];

    [self.view addSubview:kvc.view];
    [self addChildViewController:kvc];
}



#pragma mark - view cycle

- (void)loadView
{
    [super loadView];
    
    viewControllers = [[NSMutableArray alloc] initWithCapacity:4];
    
    [self loadViewControllers];
    
    _baseView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_baseView];
    [self.view sendSubviewToBack:self.baseView];
    

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadViewController:0];
    
    
    
    
    
    
    
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super  viewDidAppear:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //get the image
    UIImage* image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    
    //scale and rotate so you're not sending a sideways image -> method provided by http://blog.logichigh.com/2008/06/05/uiimage-fix/
//    image = [self scaleAndRotateImage:image];
    
    //obtain the jpeg data (.1 is quicker to send, i found it better for testing)
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, .1)];
    
    //get the data into a string
    NSString* imageString = [NSString stringWithFormat:@"%@", imageData];
    //remove whitespace from the string
    imageString = [imageString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //remove < and > from string
    imageString = [imageString substringWithRange:NSMakeRange(1, [imageString length]-2)];
    
    self.view.hidden = YES;
    //dismissed the camera
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    //posts the image
    [self performSelectorInBackground:@selector(postImage:) withObject:imageString];
}



- (void)postImage:(NSString*)imageData
{
    //image string formatted in json
    NSString* imageString = [NSString stringWithFormat:@"{\"image\": \"%@\", \"authenticity_token\": \"\", \"utf8\": \"✓\"}", imageData];
    
    //encoded json string
    NSData* data = [imageString dataUsingEncoding:NSUTF8StringEncoding];
    
    //url that you're going to send the image to
    NSString* url = @"http://0.0.0.0:3000/api/v1/upload";
    
    //pretty self explanatory request building
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setTimeoutInterval:10000];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod: @"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:data];
    

    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString *s = [NSString stringWithUTF8String:[result bytes]];
    
    NSLog(@"%@", s);
    
    
    
}


- (IBAction)addUploadImage:(id)sender {

    UIImage *image = [UIImage imageNamed:@"logo140"];
    
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, .1)];
    
    //get the data into a string
    NSString* imageString = [NSString stringWithFormat:@"%@", imageData];
    //remove whitespace from the string
    imageString = [imageString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //remove < and > from string
    imageString = [imageString substringWithRange:NSMakeRange(1, [imageString length]-2)];
    
    [self postImage:imageString];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
