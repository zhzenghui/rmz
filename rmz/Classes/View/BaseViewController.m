//
//  BaseViewController.m
//  Dyrs
//
//  Created by mbp  on 13-8-22.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
}
@end

@implementation BaseViewController


- (void)back:(UIButton *)button
{
    
  
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.alpha  = 0;
    } completion:^(BOOL finished) {
        
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
        }
    }];
    
    

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight|| toInterfaceOrientation == UIDeviceOrientationLandscapeLeft);
}





- (void)addMemu
{

    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 768)];
    _menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"左导航条-bg"]];
    [self.view addSubview:_menuView];
    
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}



-(UIStatusBarStyle)preferredStatusBarStyle{
    if (iOS7) {
        UIImageView *statuebar_gb_ImageView = [[UIImageView alloc] init];
        statuebar_gb_ImageView.frame = CGRectMake(0, 0, 1024, 20);
        statuebar_gb_ImageView.image = [[ImageView share] createSolidColorImageWithColor:[UIColor blackColor] andSize:statuebar_gb_ImageView.frame.size];

        [self.view addSubview:statuebar_gb_ImageView];
    }
    return UIStatusBarStyleLightContent;
}



- (void)loadView
{
    [super loadView];
    

    self.view.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]; // [UIColor orangeColor];
//    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    _baseView = [[UIView alloc] initWithFrame:CGRectMake(55, 0, 1024-55, 768)];
//    _baseView.clipsToBounds = YES;
//
//    [self.view addSubview:_baseView];
    

    
}

- (void)addLogo
{
    [[ImageView share] addToView:self.baseView imagePathName:@"logo" rect:RectMake2x(74, 66, 389, 102)];

}


- (void)addBackView
{
    [[Button share] addToView:self.view addTarget:self rect:CGRectMake(0  , 0, 111, 111) tag:Action_Back action:@selector(back:) imagePath:@"bg"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addBackView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
