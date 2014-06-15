//
//  ZHTimeLineViewController.m
//  rmz
//
//  Created by zeng hui on 14-5-25.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHTimeLineViewController.h"
#import "SVPullToRefresh.h"
#import "ZHTimeLineCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

@interface ZHTimeLineViewController ()

@end

@implementation ZHTimeLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadAlbums:(int)page
{
    if ( ! SharedAppUser.auth_token) {
        return;
    }
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSDictionary *parameters = @{ @"auth_token": SharedAppUser.auth_token};
    
    NSString *url = [NSString stringWithFormat:@"%@albums", KHomeApiUrl];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        if ([dict[@"status"] intValue] == 1) {
            self.dataMArray = [NSMutableArray arrayWithArray: dict[@"data"]];
            [self.tableView reloadData];
            
            __weak ZHTimeLineViewController *weakSelf = self;
            [weakSelf.tableView.pullToRefreshView stopAnimating];
            
        }
        else {
            
        }
        

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)insertRowAtTop {
    
    [self. dataMArray removeAllObjects];
    self.dataMArray = nil;
    [self.tableView reloadData];

    [self loadAlbums:0];
}

- (void)loadView
{
    [super loadView];
    

    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource =  self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsPullToRefresh = NO;
    
//    if (iOS7) {
//        _tableView.frame = NavitionRectMake(0, 105, 320, screenHeight-64-44-43);;
//    }
//    else {
//        _tableView.frame = NavitionRectMake(0, 77, 320, 471);;
//        
//    }
    _tableView.frame = self.view.frame;
    [self.view addSubview:_tableView];

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"timeline";

    
    
    __weak ZHTimeLineViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    
    [weakSelf.tableView triggerPullToRefresh];
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataMArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 510;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ZHTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ZHTimeLineCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    
    NSDictionary *dict = [self.dataMArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [dict objectForKey:@"title"];
    NSString *str = [NSString stringWithFormat:@"%@%@", KHomeUrl, [dict objectForKey:@"avatar_url"]];
    NSURL *url = [NSURL URLWithString:str];
    
    
    cell.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [cell.contentImageView setImageWithURL:url
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    
    
    
    
    long long timestmp = [[dict objectForKey:@"showTime"] longLongValue]/1000;
    cell.dateLabel.text = [NSDate dateWithTimestamp:timestmp];
    
//    
//    if (  ! [[dict objectForKey:@"favNum"]  isEqual:[NSNull null]]) {
//        cell.likeLabel.text = [NSString stringWithFormat:@"%d", [[dict objectForKey:@"enjoy"] intValue]];
//    }
//    else {
//        cell.likeLabel.text = @"0";
//    }
//    
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ( self.tableView.contentOffset.y == 40) {
        self.navigationController.navigationBarHidden = YES ;        
    }
    

    
}



@end
