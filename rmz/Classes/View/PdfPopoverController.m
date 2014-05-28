//
//  PdfPopoverController.m
//  Designer
//
//  Created by bejoy on 14-3-7.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "PdfPopoverController.h"

@interface PdfPopoverController ()
{

    NSMutableArray *fileArrayM ;
    
    UITableView *tb;
    
}
@end

@implementation PdfPopoverController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView
{
    
    [super loadView];
    

    
    
    
    tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self    .view.frame.size.width, self    .view.frame.size.height)];
    tb.backgroundColor = [UIColor clearColor];
    tb.dataSource = self;
    tb.delegate = self;
    
    [self.view addSubview:tb];

}

- (void)loadData
{
    
    
    
    fileArrayM = [[ZHDBData share] getFilesForD_Id:kD_Id];
    
    
    [tb reloadData];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"按钮-PDF-bg"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action

- (void)openProductDetail:(UIButton *)button
{
    
//    UITableViewCell *cell = (UITableViewCell *)[[[button superview]  superview] superview];
//    NSIndexPath *indexPath = [tb indexPathForCell:cell];
    
    
//    int index = (indexPath.row*4)  + button.tag - 301;
    
   // NSString *cate_id = [NSString stringWithFormat:@"%d", [[[self.dataMArray objectAtIndex:index] objectForKey:@"cate_id"] intValue]];
    
    
    //
//    NSMutableArray *products = [[ZHDBData share] getProductForCategory:cate_id];
    //
    //
    //    if (products.count == 0) {
    //        [[Message share] messageAlert:@"敬请期待！"];
    //        return;
    //    }
    
    //    ProductListViewController  *lvc = [[ProductListViewController alloc] init];
    //    lvc.dataMArray = [[ZHDBData share] getProductForCategory:cate_id];
    //
    //
    //    lvc.view.alpha = 0;
    //
    //    [UIView animateWithDuration:KLongDuration animations:^{
    //        lvc.view.alpha = 1;
    //    }];
    //
    //
    //    [self.view addSubview:lvc.view];
    //    [self addChildViewController:lvc];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fileArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 130/2;
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell4";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil ) {
        cell =[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];

    }
    
    cell.imageView.image = [UIImage imageNamed:@"按钮-PDF-0"];
    cell.textLabel.text =  fileArrayM[indexPath.row][@"show_name"];
    return cell;
    
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



@end
