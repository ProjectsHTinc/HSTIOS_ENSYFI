//
//  StudentinfoViewController.m
//  EducationApp
//
//  Created by HappySanz on 06/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "StudentinfoViewController.h"

@interface StudentinfoViewController ()
{
    NSMutableArray *name;
    NSMutableArray *studentID;
    NSMutableArray *admissionnumber;
    NSMutableArray *className;
    NSMutableArray *section;
    NSMutableArray *classid;
    NSMutableArray *admisionID;

    AppDelegate *appDel;
}
@end

@implementation StudentinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"STUDENT INFO";
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    name = [[NSMutableArray alloc]init];
    studentID = [[NSMutableArray alloc]init];
    admissionnumber = [[NSMutableArray alloc]init];
    className = [[NSMutableArray alloc]init];
    section = [[NSMutableArray alloc]init];
    classid = [[NSMutableArray alloc]init];
    admisionID = [[NSMutableArray alloc]init];

    name = [[NSUserDefaults standardUserDefaults]objectForKey:@"studentname_arr"];
    studentID = [[NSUserDefaults standardUserDefaults]objectForKey:@"registered_id_arr"];
    admissionnumber = [[NSUserDefaults standardUserDefaults]objectForKey:@"admission_no_arr"];
    className = [[NSUserDefaults standardUserDefaults]objectForKey:@"classname_arr"];
    section = [[NSUserDefaults standardUserDefaults]objectForKey:@"sec_name_arr"];
    classid = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_arr"];
    admisionID = [[NSUserDefaults standardUserDefaults]objectForKey:@"admission_id_arr"];

    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    static NSString *simpleTableIdentifier = @"StudentInfoTableViewCell";
    
    StudentInfoTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[StudentInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    // Configure the cell...
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ : %@",@"Name",[name objectAtIndex:indexPath.row]];
    cell.classid.text =  [classid objectAtIndex:indexPath.row];
    cell.admissionidLabel.text = [NSString stringWithFormat:@"%@ : %@",@"Admission Id",[admissionnumber objectAtIndex:indexPath.row]];
    NSLog(@"%@", cell.admissionidLabel.text);
    
    NSString *class = [className objectAtIndex:indexPath.row];
    NSString *strSection = [section objectAtIndex:indexPath.row];
    NSString *classSection = [NSString stringWithFormat:@"%@ %@", class, strSection];
    
    cell.continueOutlet.tag = indexPath.row;
    cell.continueOutlet.layer.cornerRadius = 3.0f;
    cell.continueOutlet.clipsToBounds = YES;
    
    [cell.continueOutlet addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];


    cell.classnameLabel.text = [NSString stringWithFormat:@"%@ : %@",@"Class",classSection];
    cell.classid.text = [classid objectAtIndex:indexPath.row];
    
//    cell.mainView.layer.borderWidth = 1.0f;
//    cell.mainView.layer.borderColor = [UIColor clearColor].CGColor;
//    cell.mainView.layer.cornerRadius = 6.0f;
    
    cell.cellView.layer.cornerRadius = 8.0f;
    cell.cellView.clipsToBounds = YES;
    
    cell.cellView.layer.shadowRadius  = 5.5f;
    cell.cellView.layer.shadowColor   = UIColor.grayColor.CGColor;
    cell.cellView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    cell.cellView.layer.shadowOpacity = 0.6f;
    cell.cellView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(cell.cellView.bounds, shadowInsets)];
    cell.cellView.layer.shadowPath    = shadowPath.CGPath;
    
    return cell;
}

-(void)yourButtonClicked:(UIButton*)sender
{
    if (sender.tag == 0)
    {
        StudentInfoTableViewCell *selectedCell;
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;

        appDel.class_id = selectedCell.classid.text;
        
        NSInteger indexValu = [classid indexOfObject:selectedCell.classid.text];
        
        appDel.student_id = studentID[indexValu];
        NSLog(@"%@",appDel.student_id);
      //  appDel.student_id = selectedCell.studentidLabel.text;

        NSInteger indexValue = [classid indexOfObject:selectedCell.classid.text];

        appDel.admissionID = admisionID[indexValue];

        NSInteger indexValueSecName = [classid indexOfObject:selectedCell.classid.text];

        NSString *sectionname = section[indexValueSecName];


        //    [[NSUserDefaults standardUserDefaults]setObject:stradmission_id forKey:@"admission_id_key"];
        [[NSUserDefaults standardUserDefaults]setObject:selectedCell.admissionidLabel.text forKey:@"admission_no_Key"];
        [[NSUserDefaults standardUserDefaults]setObject:selectedCell.classnameLabel.text forKey:@"class_name_key"];
        [[NSUserDefaults standardUserDefaults]setObject:appDel.class_id forKey:@"class_id_key"];
        [[NSUserDefaults standardUserDefaults]setObject:selectedCell.nameLabel.text forKey:@"studentname_Key"];
        [[NSUserDefaults standardUserDefaults]setObject:appDel.student_id forKey:@"registered_id_key"];


        [[NSUserDefaults standardUserDefaults]setObject:sectionname forKey:@"sec_name_key"];


        //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //    SWRevealViewController *exam = (SWRevealViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        //    [self.navigationController pushViewController:exam animated:YES];
        [self performSegueWithIdentifier:@"SWRevealViewController" sender:self.view];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StudentInfoTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDel.class_id = selectedCell.classid.text;
   
    NSInteger indexValu = [classid indexOfObject:selectedCell.classid.text];
    
    appDel.student_id = studentID[indexValu];
    
    NSInteger indexValue = [classid indexOfObject:selectedCell.classid.text];
    
    appDel.admissionID = admisionID[indexValue];
    
    NSInteger indexValueSecName = [classid indexOfObject:selectedCell.classid.text];
    
    NSString *sectionname = section[indexValueSecName];
    
    
//    [[NSUserDefaults standardUserDefaults]setObject:stradmission_id forKey:@"admission_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:selectedCell.admissionidLabel.text forKey:@"admission_no_Key"];
    [[NSUserDefaults standardUserDefaults]setObject:selectedCell.classnameLabel.text forKey:@"class_name_key"];
    [[NSUserDefaults standardUserDefaults]setObject:selectedCell.classid.text forKey:@"class_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:selectedCell.nameLabel.text forKey:@"studentname_Key"];
    [[NSUserDefaults standardUserDefaults]setObject:appDel.student_id  forKey:@"registered_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:sectionname forKey:@"sec_name_key"];

    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    SWRevealViewController *exam = (SWRevealViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
//    [self.navigationController pushViewController:exam animated:YES];
    [self performSegueWithIdentifier:@"SWRevealViewController" sender:self.view];
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
