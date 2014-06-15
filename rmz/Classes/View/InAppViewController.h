//
//  InAppViewController.h
//  rmz
//
//  Created by zeng hui on 14-5-29.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"

@interface InAppViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    __block UITableView *tView;
}

@property (nonatomic,strong) __block NSArray *products;



@end
