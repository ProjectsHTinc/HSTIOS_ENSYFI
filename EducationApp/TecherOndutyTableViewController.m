//
//  TecherOndutyTableViewController.m
//  EducationApp
//
//  Created by HappySanz on 15/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TecherOndutyTableViewController.h"

@interface TecherOndutyTableViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *odTitle;
    NSMutableArray *frmDate;
    NSMutableArray *toDte;
    NSMutableArray *odStatus;
}
@end

@implementation TecherOndutyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2048 x 2732.png"]];
    

    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    
    odTitle = [[NSMutableArray alloc]init];
    frmDate = [[NSMutableArray alloc]init];
    toDte = [[NSMutableArray alloc]init];
    odStatus = [[NSMutableArray alloc]init];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarBtn setTarget: self.revealViewController];
        [self.sidebarBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    [self getValues];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)getValues
{
    if ([appDel.user_type isEqualToString:@"4"])
    {
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.admissionID forKey:@"user_id"];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forDispOd = @"/apimain/disp_Onduty/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forDispOd, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *ondutyDetails = [responseObject objectForKey:@"ondutyDetails"];
             
             if ([msg isEqualToString:@"View Onduty"])
             {
                 
                 [self->odTitle removeAllObjects];
                 [self->frmDate removeAllObjects];
                 [self->toDte removeAllObjects];
                 [self->odStatus removeAllObjects];
                 
                 
                 for (int i = 0; i < [ondutyDetails count]; i++)
                 {
                     NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                     
                     NSString *od_for = [onduty objectForKey:@"od_for"];
                     NSString *fromDate = [onduty objectForKey:@"from_date"];
                     NSString *toDate = [onduty objectForKey:@"to_date"];
                     NSString *status = [onduty objectForKey:@"status"];
                     
                     [self->odTitle addObject:od_for];
                     [self->frmDate addObject:fromDate];
                     [self->toDte addObject:toDate];
                     [self->odStatus addObject:status];
                 }
             }
             else
             {
                 
             }
             
             [self.tableView reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
        
    }
    else if([appDel.user_type isEqualToString:@"3"])
    {
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forDispOd = @"/apimain/disp_Onduty/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forDispOd, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *ondutyDetails = [responseObject objectForKey:@"ondutyDetails"];
             
             if ([msg isEqualToString:@"View Onduty"])
             {
                 
                 [self->odTitle removeAllObjects];
                 [self->frmDate removeAllObjects];
                 [self->toDte removeAllObjects];
                 [self->odStatus removeAllObjects];
                 
                 
                 for (int i = 0; i < [ondutyDetails count]; i++)
                 {
                     NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                     
                     NSString *od_for = [onduty objectForKey:@"od_for"];
                     NSString *fromDate = [onduty objectForKey:@"from_date"];
                     NSString *toDate = [onduty objectForKey:@"to_date"];
                     NSString *status = [onduty objectForKey:@"status"];
                     
                     [self->odTitle addObject:od_for];
                     [self->frmDate addObject:fromDate];
                     [self->toDte addObject:toDate];
                     [self->odStatus addObject:status];
                 }
             }
             else
             {
                 
             }
             
             [self.tableView reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    else if ([appDel.user_type isEqualToString:@"2"])
    {
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forDispOd = @"/apimain/disp_Onduty/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forDispOd, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *ondutyDetails = [responseObject objectForKey:@"ondutyDetails"];
             
             if ([msg isEqualToString:@"View Onduty"])
             {
                 
                 [self->odTitle removeAllObjects];
                 [self->frmDate removeAllObjects];
                 [self->toDte removeAllObjects];
                 [self->odStatus removeAllObjects];
                 
                 
                 for (int i = 0; i < [ondutyDetails count]; i++)
                 {
                     NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                     
                     NSString *od_for = [onduty objectForKey:@"od_for"];
                     NSString *fromDate = [onduty objectForKey:@"from_date"];
                     NSString *toDate = [onduty objectForKey:@"to_date"];
                     NSString *status = [onduty objectForKey:@"status"];
                     
                     [self->odTitle addObject:od_for];
                     [self->frmDate addObject:fromDate];
                     [self->toDte addObject:toDate];
                     [self->odStatus addObject:status];
                 }
             }
             else
             {
                 
             }
             
             [self.tableView reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    else if ([appDel.user_type isEqualToString:@"1"])
    {
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forDispOd = @"/apimain/disp_Onduty/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forDispOd, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *ondutyDetails = [responseObject objectForKey:@"ondutyDetails"];
             
             if ([msg isEqualToString:@"View Onduty"])
             {
                 
                 [self->odTitle removeAllObjects];
                 [self->frmDate removeAllObjects];
                 [self->toDte removeAllObjects];
                 [self->odStatus removeAllObjects];
                 
                 
                 for (int i = 0; i < [ondutyDetails count]; i++)
                 {
                     NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                     
                     NSString *od_for = [onduty objectForKey:@"od_for"];
                     NSString *fromDate = [onduty objectForKey:@"from_date"];
                     NSString *toDate = [onduty objectForKey:@"to_date"];
                     NSString *status = [onduty objectForKey:@"status"];
                     
                     [self->odTitle addObject:od_for];
                     [self->frmDate addObject:fromDate];
                     [self->toDte addObject:toDate];
                     [self->odStatus addObject:status];
                 }
             }
             else
             {
                 
             }
             
             [self.tableView reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *onDutyformView = [[NSUserDefaults standardUserDefaults]objectForKey:@"onDutyformView"];
    
    if ([onDutyformView isEqualToString:@"yes"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"onDutyformView"];
        [self getValues];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [odTitle count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OnDutyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OnDutyTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.name.text = [odTitle objectAtIndex:indexPath.row];
    NSString *str = [odStatus objectAtIndex:indexPath.row];
    
    if ([str isEqualToString:@"Approved"])
    {
        cell.statusImg.image = [UIImage imageNamed:@"approved.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:8/255.0f green:159/255.0f blue:73/255.0f alpha:1.0];
    }
    else if ([str isEqualToString:@"Rejected"])
    {
        cell.statusImg.image = [UIImage imageNamed:@"rejected.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:216/255.0f green:91/255.0f blue:74/255.0f alpha:1.0];
    }
    else
    {
        cell.statusImg.image = [UIImage imageNamed:@"pending.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:190/255.0f green:192/255.0f blue:49/255.0f alpha:1.0];
        
    }
    
    cell.fromdate.text = [frmDate objectAtIndex:indexPath.row];
    cell.toDate.text = [toDte objectAtIndex:indexPath.row];
    
    cell.mainView.layer.cornerRadius = 8.0f;
    cell.mainView.clipsToBounds = YES;
    
    cell.mainView.layer.shadowRadius  = 5.5f;
    cell.mainView.layer.shadowColor   = UIColor.grayColor.CGColor;
    cell.mainView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    cell.mainView.layer.shadowOpacity = 0.6f;
    cell.mainView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(cell.mainView.bounds, shadowInsets)];
    cell.mainView.layer.shadowPath    = shadowPath.CGPath;
    
    return cell;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)odFormBtn:(id)sender
{
    
}
@end
