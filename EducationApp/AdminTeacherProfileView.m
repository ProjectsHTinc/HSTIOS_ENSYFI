//
//  AdminTeacherProfileView.m
//  EducationApp
//
//  Created by HappySanz on 20/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminTeacherProfileView.h"

@interface AdminTeacherProfileView ()
{
    AppDelegate *appDel;
    NSMutableArray *class_id;
    NSMutableArray *class_name;
    NSMutableArray *day;
    NSMutableArray *name_arr;
    NSMutableArray *period;
    NSMutableArray *sec_name;
    NSMutableArray *subject_id;
    NSMutableArray *subject_name;
    NSMutableArray *table_id;
    NSMutableArray *teacher_id_arr;
    NSString *teacherProPic;

}
@end

@implementation AdminTeacherProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    self.timetablebtnOtlet.layer.cornerRadius = 5.0;
    self.timetablebtnOtlet.clipsToBounds = YES;

    NSString *strstat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    self.userImage.layer.cornerRadius = 50.0;
    self.userImage.clipsToBounds = YES;
    
    if ([strstat_user_type isEqualToString:@"teachers"])
    {
        self.timetablebtnOtlet.hidden = YES;
    }
    
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
    
    class_id = [[NSMutableArray alloc]init];
    class_name = [[NSMutableArray alloc]init];
    day = [[NSMutableArray alloc]init];
    name_arr = [[NSMutableArray alloc]init];
    period = [[NSMutableArray alloc]init];
    sec_name = [[NSMutableArray alloc]init];
    subject_id = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];
    table_id = [[NSMutableArray alloc]init];
    teacher_id_arr = [[NSMutableArray alloc]init];
    
  
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *strteacher_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_teacherid"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:strteacher_id forKey:@"teacher_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_teacher = @"/apiadmin/get_teacher_class_details";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_teacher, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *teacherProfile = [responseObject objectForKey:@"teacherProfile"];
         NSArray *teacherTimeTable = [responseObject objectForKey:@"timeTable"];
         if ([msg isEqualToString:@"Class and Sections"])
         {
             for (int i =0; i < [teacherProfile count]; i++)
             {
                 NSDictionary *dict = [teacherProfile objectAtIndex:i];
                 self.address.text = [dict objectForKey:@"address"];
                 self.age.text = [dict objectForKey:@"age"];
                 self.className.text = [dict objectForKey:@"class_name"];
                 self.classTeacher.text = [dict objectForKey:@"class_teacher"];
                 self.comunityClass.text = [dict objectForKey:@"community_class"];
                 self.email.text = [dict objectForKey:@"email"];
                 self.name.text = [dict objectForKey:@"name"];
                 self.phone.text = [dict objectForKey:@"phone"];
                 self.qualification.text = [dict objectForKey:@"qualification"];
                 self.religion.text = [dict objectForKey:@"religion"];
                 self.sec_Email.text = [dict objectForKey:@"sec_email"];
                 self.secyionName.text = [dict objectForKey:@"sec_name"];
                 self.sec_Phone.text = [dict objectForKey:@"sec_phone"];
                 self.sex.text = [dict objectForKey:@"sex"];
                 self.subject.text = [dict objectForKey:@"subject"];
                 self.subjectName.text = [dict objectForKey:@"subject_name"];
                 self.teacher_id.text = [dict objectForKey:@"teacher_id"];
                 self->teacherProPic = [dict objectForKey:@"profile_pic"];
             }
             
             [[NSUserDefaults standardUserDefaults]setObject:teacherTimeTable forKey:@"ad_teacher_timeTable_key"];
             
             [self->class_id removeAllObjects];
             [self->class_name removeAllObjects];
             [self->day removeAllObjects];
             [self->name_arr removeAllObjects];
             [self->period removeAllObjects];
             [self->sec_name removeAllObjects];
             [self->subject_id removeAllObjects];
             [self->subject_name removeAllObjects];
             [self->table_id removeAllObjects];
             [self->teacher_id_arr removeAllObjects];

             
             for (int i = 0; i < [teacherTimeTable count]; i++)
             {
                 NSDictionary *dictTimeTable = [teacherTimeTable objectAtIndex:i];
                 
                 NSString *strclass_id = [dictTimeTable objectForKey:@"class_id"];
                 NSString *strclass_name = [dictTimeTable objectForKey:@"class_name"];
                 NSString *strday = [dictTimeTable objectForKey:@"day_id"];
                 NSString *strname = [dictTimeTable objectForKey:@"name"];
                 NSString *strperiod = [dictTimeTable objectForKey:@"period"];
                 NSString *strsec_name = [dictTimeTable objectForKey:@"sec_name"];
                 NSString *strsubject_id = [dictTimeTable objectForKey:@"subject_id"];
                 NSString *strsubject_name = [dictTimeTable objectForKey:@"subject_name"];
                 NSString *strtable_id = [dictTimeTable objectForKey:@"table_id"];
                 NSString *strteacher_id = [dictTimeTable objectForKey:@"teacher_id"];
                 
                 [self->class_id addObject:strclass_id];
                 [self->class_name addObject:strclass_name];
                 [self->day addObject:strday];
                 [self->name_arr addObject:strname];
                 [self->period addObject:strperiod];
                 [self->sec_name addObject:strsec_name];
                 [self->subject_id addObject:strsubject_id];
                 [self->subject_name addObject:strsubject_name];
                 [self->table_id addObject:strtable_id];
                 [self->teacher_id_arr addObject:strteacher_id];

             }
         }
         
         
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    if ([self->teacherProPic isEqualToString:@""])
    {
        self.userImage.image = [UIImage imageNamed:@"profile.png"];
    }
    else
    {
        NSArray *componentsPic = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,teacher_profile,teacherProPic, nil];
        NSString *fullpath= [NSString pathWithComponents:componentsPic];
        NSURL *url = [NSURL URLWithString:fullpath];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                self.userImage.image = [UIImage imageWithData:imageData];
                if (self.userImage.image == nil)
                {
                    self.userImage.image = [UIImage imageNamed:@"profile.png"];
                }
                
            });
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,900);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender
{
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassView"];
    
    NSString *strstat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    if ([strstat_user_type isEqualToString:@"teachers"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"strstat_user_type"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherProfileViewController *teacherProfileViewController = (TeacherProfileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherProfileViewController"];
        [self.navigationController pushViewController:teacherProfileViewController animated:YES];
    }
    
    else if ([str isEqualToString:@"classes"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"ClassView"];
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
//        AdminClassesViewController *adminClassesViewController = (AdminClassesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminClassesViewController"];
//        [self.navigationController pushViewController:adminClassesViewController animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}
- (IBAction)timeTableBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeachersTimeTableView *teachersTimeTableView = (TeachersTimeTableView *)[storyboard instantiateViewControllerWithIdentifier:@"TeachersTimeTableView"];
    [self.navigationController pushViewController:teachersTimeTableView animated:YES];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
