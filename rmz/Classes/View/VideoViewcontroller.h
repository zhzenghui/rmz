//
//  VideoViewcontroller.h
//  rmz
//
//  Created by bejoy on 14-5-29.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"

@interface VideoViewcontroller : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;


- (IBAction)startRecord:(id)sender;
- (IBAction)stopRecord:(id)sender;


@end
