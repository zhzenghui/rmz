//
//  InAppViewController.m
//  rmz
//
//  Created by zeng hui on 14-5-29.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "InAppViewController.h"
#import "IAPShare.h"
#import "VerificationController.h"


@interface InAppViewController ()

@end

@implementation InAppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        [[UIScreen mainScreen] setBrightness:1];
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        
    }
    return self;
}

- (void)buyProduction:(SKProduct *)product
{
    
    
             [[IAPShare sharedHelper].iap buyProduct:product
                                        onCompletion:^(SKPaymentTransaction* trans){

                                            if(trans.error)
                                            {
                                                NSLog(@"Fail %@",[trans.error localizedDescription]);
                                            }
                                            else if(trans.transactionState == SKPaymentTransactionStatePurchased) {

                                                [[IAPShare sharedHelper].iap checkReceipt:trans.transactionReceipt
                                                                          AndSharedSecret:ITC_CONTENT_PROVIDER_SHARED_SECRET
                                                                             onCompletion:^(NSString *response, NSError *error) {

                                                    
                                                    //Convert JSON String to NSDictionary
                                                    NSDictionary* rec = [IAPShare toJSON:response];

                                                    if([rec[@"status"] integerValue]==0)
                                                    {
                                                        
                                                        NSString *productIdentifier = trans.payment.productIdentifier;
                                                        [[IAPShare sharedHelper].iap provideContent:productIdentifier];
                                                        NSLog(@"SUCCESS %@",response);
                                                        NSLog(@"Pruchases %@",[IAPShare sharedHelper].iap.purchasedProducts);
                                                        

                                                    }
                                                    else {
                                                        NSLog(@"Fail");
                                                    }
                                                }];
                                            }
                                            else if(trans.transactionState == SKPaymentTransactionStateFailed) {
                                                NSLog(@"Fail");
                                            }
                                        }];//end of buy product
}

- (void)getProducts
{
    
    
    if(![IAPShare sharedHelper].iap) {
        NSSet* dataSet = [[NSSet alloc] initWithObjects:@"com.gino.xiaoyemiao.pay1", nil];

        [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
    }

#ifdef DEBUG
    [IAPShare sharedHelper].iap.production = NO;

#else
    [IAPShare sharedHelper].iap.production = YES;

#endif

    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
     {
         if(response > 0 ) {


             for (SKProduct *p in [IAPShare sharedHelper] .iap.products) {


                 DLog(@"%@", p.localizedTitle);
             }

             _products =[IAPShare sharedHelper].iap.products;
             [tView reloadData];

         }
     }];
    
}

- (void)loadView
{
    [super loadView];
    
    _products = [[NSMutableArray alloc] init];
    
    
    
    
    self.title = @"In App";
    tView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20-50) style:UITableViewStyleGrouped];
    
    tView.delegate = self;
    tView.dataSource = self;
    //    tView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tView];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getProducts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action


- (void)buyProduct:(UIButton *)button
{
    
    UITableViewCell *cell = (UITableViewCell *)[[[button superview]  superview] superview];
    
    NSIndexPath *index = [tView  indexPathForCell:cell];
    

    [self buyProduction:_products[index.row]];
    
    
    
    
}
#define KTABLEVIEW_HEADER_HIGHT 35

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return _products.count;
    
    
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
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        [b setTitle:@"buy" forState:UIControlStateNormal];
        [b addTarget:self action:@selector(buyProduct:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:b];
        
    }
    
    
    SKProduct *p = _products[indexPath.row];

    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:p.priceLocale];

    NSString *formattedPrice = [numberFormatter stringFromNumber:p.price];

    
    cell.textLabel.text  = p.localizedTitle;
    cell.detailTextLabel.text = formattedPrice;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    [self buyProduction:_products[indexPath.row]];
}



@end
