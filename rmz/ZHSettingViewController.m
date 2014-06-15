//
//  ZHSettingViewController.m
//  rmz
//
//  Created by zeng hui on 14-5-24.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHSettingViewController.h"
#import "ZHUserViewController.h"
#import "ZHLikeViewController.h"
#import "ZHFollowingViewController.h"
#import "InAppViewController.h"


@interface ZHSettingViewController ()

@end

@implementation ZHSettingViewController

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
//    self.navigationController.navigationBarHidden = NO;

    self.title = @"info";
    tView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20-50) style:UITableViewStylePlain];

//    tView.backgroundColor = [UIColor clearColor];
    tView.delegate = self;
    tView.dataSource = self;
//    tView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tView];
    self.dataMArray = [NSMutableArray arrayWithArray: @[ @[@"购买", @"兑换", @"喜欢", @"关注", @"我"] , @[@""]]];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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


#define KTABLEVIEW_HEADER_HIGHT 35

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KTABLEVIEW_HEADER_HIGHT)];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, KTABLEVIEW_HEADER_HIGHT)];
    lb.textColor = [UIColor grayColor];
    switch (section) {
        case 0:
            lb.text = @"账户";
            break;
            
        case 1:
            lb.text = @"设置";
            break;
        
        default:
            break;
    }
    
    [hView addSubview:lb];
    
    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.frame = CGRectMake(0, KTABLEVIEW_HEADER_HIGHT-.5, SCREEN_WIDTH, .5);
//    lineView.backgroundColor = [UIColor grayColor];
//    
//    [hView addSubview:lineView];
    
    return hView;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//        {
//            return @"账户";
//            break;
//        }
//        case 1:
//        {
//            return @"设置";
//            break;
//        }
//        case 2:
//        {
//            break;
//        }
//        default:
//            return @"";
//            break;
//    }
//    
//    return @"";
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    NSArray *a = self.dataMArray[section];
    
    return a.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KTABLEVIEW_HEADER_HIGHT;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell4";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

//        cell.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
//    cell.imageView.image = [UIImage imageNamed:@"logo140"];
//    cell.textLabel.textColor = [ UIColor lightGrayColor];
    cell.textLabel.text  = self.dataMArray[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BaseViewController *bv = nil;
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    bv = [[InAppViewController alloc] init];
                    break;
                }
                case 1:
                {
                    bv = [[ZHLikeViewController alloc] init];
                    break;
                }
                case 2:
                {
                    bv = [[ZHFollowingViewController alloc] init];
                    break;
                }
                case 3:
                {
                    bv = [[ZHUserViewController alloc] init];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    [self .navigationController pushViewController:bv animated:YES];
}


@end
