//
//  AdminClassesViewController.m
//  EducationApp
//
//  Created by HappySanz on 21/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminClassesViewController.h"
#import "SWRevealViewController.h"

@interface AdminClassesViewController ()
{
    AppDelegate *appDel;
    NSString *tmpString1;
    NSString *tmpString2;
    NSMutableArray *sec_id;
    NSMutableArray *sec_name;
    
    NSMutableArray *admisn_no;
    NSMutableArray *admisn_year;
    NSMutableArray *enroll_id;
    NSMutableArray *class_id;

    NSMutableArray *name;
    NSMutableArray *sex;
    
    NSMutableArray *teacher_id;
    NSMutableArray *subject_name_Array;
    NSMutableArray *Techer_name;

}
@end

@implementation AdminClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    sec_id = [[NSMutableArray alloc]init];
    sec_name = [[NSMutableArray alloc]init];
    
    admisn_no = [[NSMutableArray alloc]init];
    admisn_year = [[NSMutableArray alloc]init];
    enroll_id = [[NSMutableArray alloc]init];
    class_id = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    sex = [[NSMutableArray alloc]init];
    
    teacher_id = [[NSMutableArray alloc]init];
    subject_name_Array = [[NSMutableArray alloc]init];
    Techer_name = [[NSMutableArray alloc]init];
    
    tmpString1 = @"";
    tmpString2 = @"";
    
    self.mainView.layer.cornerRadius = 8.0f;
    self.mainView.clipsToBounds = YES;
    
    _mainView.layer.shadowRadius  = 5.5f;
    _mainView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _mainView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _mainView.layer.shadowOpacity = 0.6f;
    _mainView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_mainView.bounds, shadowInsets)];
    _mainView.layer.shadowPath    = shadowPath.CGPath;
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"view_selection"];
    
    if ([str isEqualToString:@"mainMenu"])
    {
        UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
        button2.tintColor = UIColor.whiteColor;
        self.navigationItem.leftBarButtonItem = button2;
    }
    else
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if (revealViewController)
        {
            [self.sidebarButton setTarget: self.revealViewController];
            [self.sidebarButton setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
        
        SWRevealViewController *revealController = [self revealViewController];
        UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
        tap.delegate = self;
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
    _classBtnOtlet.layer.borderColor = [UIColor colorWithRed:154/255.0f green:154/255.0f blue:154/255.0f alpha:1.0].CGColor;
   // _classBtnOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classBtnOtlet.layer.borderWidth = 1.0f;
    [_classBtnOtlet.layer setCornerRadius:10.0f];
    
    _sectionBtnOtlet.layer.borderColor = [UIColor colorWithRed:154/255.0f green:154/255.0f blue:154/255.0f alpha:1.0].CGColor;
  //  _sectionBtnOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _sectionBtnOtlet.layer.borderWidth = 1.0f;
    [_sectionBtnOtlet.layer setCornerRadius:10.0f];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Class_Value"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Section_Value"];
    
    self.tableview.hidden = YES;
    self.tableTitleView.hidden = YES;
}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    CGRect frame= _segmentControl.frame;
    [_segmentControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 45)];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sectionBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Section" forKey:@"sec_class"];

    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Section_btn_tapped"];
    
   // NSString *class_Value = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"]
    ;
    
//    NSString *classStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_btn_tapped"];
    
    NSString *selected_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"];
    
    
    if (![selected_class_name isEqualToString:@""])
    {
        
        NSArray *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_name"];
        
        NSUInteger fooIndex = [class_name indexOfObject:selected_class_name];
        
        NSArray *admin_class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_id"];
        tmpString1 = admin_class_id[fooIndex];
        
        appDel.class_id = tmpString1;
        
        [[NSUserDefaults standardUserDefaults]setObject:tmpString1 forKey:@"selected_class_id"];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:tmpString1 forKey:@"class_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forSections = @"/apiadmin/get_all_sections";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forSections, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             [self->sec_id removeAllObjects];
             [self->sec_name removeAllObjects];
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *se_id = [dict objectForKey:@"sec_id"];
                     NSString *se_name = [dict objectForKey:@"sec_name"];
                     
                     [self->sec_id addObject:se_id];
                     [self->sec_name addObject:se_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:self->sec_id forKey:@"admin_sec_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:self->sec_name forKey:@"admin_sec_name"];
                 
//                 dropDown = nil;
                 
                 if(self->dropDown == nil)
                 {
                     CGFloat f = 300;
                     self->dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self->sec_name :nil :@"down" :self.view];
                     self->dropDown.delegate = self;
                     
                 }
                 else {
                     [self->dropDown hideDropDown:sender];
                     [self rel];
                 }
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"No Data Found."
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
             }
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
        
    }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select Your Class"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
 
}

- (IBAction)classBTn:(id)sender
{
    _segmentControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    [[NSUserDefaults standardUserDefaults]setObject:@"Class" forKey:@"sec_class"];

    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"class_btn_tapped"];
    
    NSArray *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_name"];
    if(dropDown == nil)
    {
        [admisn_no removeAllObjects];
        [admisn_year removeAllObjects];
        [enroll_id removeAllObjects];
        [name removeAllObjects];
        [sex removeAllObjects];
        
        [teacher_id removeAllObjects];
        [subject_name_Array removeAllObjects];
        [Techer_name removeAllObjects];

        self.tableTitleView.hidden = YES;
        [self.tableview reloadData];
        
        CGFloat f = 300;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :class_name :nil :@"down" :self.view];
        [_sectionBtnOtlet setTitle:@"Section" forState:UIControlStateNormal];
        _sectionBtnOtlet.titleLabel.textColor = [UIColor colorWithRed:102/255.0f green:52/255.0f blue:102/255.0f alpha:1.0];
        dropDown.delegate = self;
        
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
 }
}
- (IBAction)segmentBTn:(id)sender
{
//    NSString *class = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"];
//    
    NSString *section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    if(_segmentControl.selectedSegmentIndex==0)
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"student" forKey:@"segment_key"];
        
        self.titleName.text = @"Student Name";
        self.title2Label.text = @"Admission No.";
        
        if (![section isEqualToString:@""])
        {
            NSString *selected_Section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
            
            NSArray *admin_sec_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_sec_name"];
            
            NSUInteger fooIndex = [admin_sec_name indexOfObject:selected_Section];
            
            tmpString2 = sec_id[fooIndex];
            
            appDel.section_id = tmpString2;
        }
        
        if ([tmpString1 isEqualToString:@""])
        {
            
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Please Select the Class and Section"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if ([tmpString2 isEqualToString:@""])
        {
        
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Please Select the Class"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"class_btn_tapped"];

            [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"Section_btn_tapped"];

            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            appDel.class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_class_id"];
            
            NSString *selected_Section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
            
            NSArray *admin_sec_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_sec_name"];
            
            NSUInteger fooIndex = [admin_sec_name indexOfObject:selected_Section];
            
            appDel.section_id = sec_id[fooIndex];
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.class_id forKey:@"class_id"];
            [parameters setObject:appDel.section_id forKey:@"section_id"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            
            /* concordanate with baseurl */
            NSString *forEvent = @"/apiadmin/get_all_students_in_classes";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forEvent, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSArray *data = [responseObject objectForKey:@"data"];
                 
                 [self->admisn_no removeAllObjects];
                 [self->admisn_year removeAllObjects];
                 [self->enroll_id removeAllObjects];
                 [self->class_id removeAllObjects];
                 [self->name removeAllObjects];
                 [self->sex removeAllObjects];
                 
                 if ([msg isEqualToString:@"success"])
                 {
                     for (int i = 0;i < [data count] ; i++)
                     {
                         NSDictionary *dict = [data objectAtIndex:i];
                         NSString *stradmisn_no = [dict objectForKey:@"admisn_no"];
                         NSString *stradmisn_year = [dict objectForKey:@"admisn_year"];
                         NSString *strenroll_id = [dict objectForKey:@"enroll_id"];
                         NSString *strsex = [dict objectForKey:@"sex"];
                         NSString *strname = [dict objectForKey:@"name"];
                         NSString *strclass_id = [dict objectForKey:@"class_id"];
                         
                         [self->admisn_no addObject:stradmisn_no];
                         [self->admisn_year addObject:stradmisn_year];
                         [self->enroll_id addObject:strenroll_id];
                         [self->class_id addObject:strclass_id];
                         [self->name addObject:strname];
                         [self->sex addObject:strsex];
                     }
                     self->dropDown = nil;

                     self.tableview.hidden = NO;
                     self.tableTitleView.hidden = NO;
                     
                     [self.tableview reloadData];
                     
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                 }
                 else
                 {
                     self.tableview.hidden = YES;
                     self.tableTitleView.hidden = YES;
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"ENSYFI"
                                                message:@"Please Select the Class"
                                                preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              
                                          }];
                     
                     [alert addAction:ok];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
                 
             }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"error: %@", error);
             }];
        
        }
    }
    if (_segmentControl.selectedSegmentIndex==1)
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"teacher" forKey:@"segment_key"];

        self.titleName.text = @"Teacher Name";
        self.title2Label.text = @"Handling Subjects";


        if (![section isEqualToString:@""])
        {
            NSString *selected_Section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
            
            NSArray *admin_sec_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_sec_name"];
            
            NSUInteger fooIndex = [admin_sec_name indexOfObject:selected_Section];
            
            tmpString2 = sec_id[fooIndex];
            
            appDel.section_id = tmpString2;
        }
        
        if ([tmpString1 isEqualToString:@""])
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Please Select the Class and Section"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if ([tmpString2 isEqualToString:@""])
        {
            
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Please Select the Class"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:tmpString1 forKey:@"class_id"];
            [parameters setObject:appDel.section_id forKey:@"section_id"];

            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            
            /* concordanate with baseurl */
            NSString *get_all_teachers = @"/apiadmin/list_of_teachers_for_class";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_teachers, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 NSLog(@"%@",responseObject);
                 
                 NSArray *data = [responseObject objectForKey:@"data"];
                 
                 [self->teacher_id removeAllObjects];
                 [self->subject_name_Array removeAllObjects];
                 [self->Techer_name removeAllObjects];
                 
                 for (int i = 0; i < [data count]; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *str_teacher_id = [dict objectForKey:@"teacher_id"];
                     NSString *str_subject_name = [dict objectForKey:@"subject_name"];
                     NSString *str_name = [dict objectForKey:@"name"];
                     
                     [self->teacher_id addObject:str_teacher_id];
                     [self->subject_name_Array addObject:str_subject_name];
                     [self->Techer_name addObject:str_name];
                     
                 }
                 self->dropDown = nil;

                 self.tableview.hidden = NO;
                 self.tableTitleView.hidden = NO;
                 [self.tableview reloadData];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
             }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"error: %@", error);
             }];
        }
  }
        
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
    {
        
        [self rel];
}
    
-(void)rel
{
    dropDown = nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"segment_key"];
    
    if ([str isEqualToString:@"student"])
    {
        return [enroll_id count];
    }
    else
    {
        return [teacher_id count];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdminClassesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell.....
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"segment_key"];
    
    if ([str isEqualToString:@"student"])
    {
        
        cell.idLabel.text = [NSString stringWithFormat:@"%li",indexPath.row + 1];
        //[enroll_id objectAtIndex:indexPath.row];
        cell.nameLabel.text = [name objectAtIndex:indexPath.row];
        cell.subjectLabel.text = [admisn_no objectAtIndex:indexPath.row];
    }
    else
    {
        cell.idLabel.text = [NSString stringWithFormat:@"%li",indexPath.row + 1];
        //[teacher_id objectAtIndex:indexPath.row];
        cell.nameLabel.text = [Techer_name objectAtIndex:indexPath.row];
        cell.subjectLabel.text = [subject_name_Array objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 49;
        
    }
    else
    {
        return 49;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AdminClassesTableViewCell *adminstudent = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"segment_key"];
    if ([str isEqualToString:@"student"])
    {
        NSUInteger indexstudent_id = [admisn_no indexOfObject:adminstudent.subjectLabel.text];
        appDel.student_id = enroll_id[indexstudent_id];
        NSUInteger index = [name indexOfObject:adminstudent.nameLabel.text];
        appDel.class_id = class_id[index];
        [[NSUserDefaults standardUserDefaults]setObject:@"classes" forKey:@"ClassView"];
//      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
//      AdminStudentProfileView *adminStudentProfile = (AdminStudentProfileView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminStudentProfileView"];
//      [self.navigationController pushViewController:adminStudentProfile animated:YES];
        [self performSegueWithIdentifier:@"to_adminStudentProfile" sender:self];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"classes" forKey:@"ClassView"];
        NSUInteger indexteacher_id = [Techer_name indexOfObject:adminstudent.nameLabel.text];
        NSString *teacherid = teacher_id[indexteacher_id];
        [[NSUserDefaults standardUserDefaults]setObject:teacherid forKey:@"admin_teacherid"];
//      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
//      AdminTeacherProfileView *adminTeacherProfile = (AdminTeacherProfileView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminTeacherProfileView"];
//      [self.navigationController pushViewController:adminTeacherProfile animated:YES];
        [self performSegueWithIdentifier:@"to_adminTeacherProfile" sender:self];
    }
}
@end
