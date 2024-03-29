//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown ()
{
    UINavigationController *navigationController;
}
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, retain) NSArray *list;
@property(nonatomic, retain) NSArray *imageList;

@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize imageList;
@synthesize delegate;
@synthesize animationDirection;
@synthesize bgView;

- (id)showDropDown:(UIButton *)b :(CGFloat *)height :(NSArray *)arr :(NSArray *)imgArr :(NSString *)direction :(UIView *)view {
    btnSender = b;
    animationDirection = direction;
    bgView = view;
    self.table = (UITableView *)[super init];
    if (self) {
        // Initialization code
        CGRect btn = b.frame;
       // CGRect _view = view.frame;
        self.list = [NSArray arrayWithArray:arr];
        self.imageList = [NSArray arrayWithArray:imgArr];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.backgroundColor = [UIColor whiteColor];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        
        //[UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        }
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        [b.superview addSubview:self];
        [self addSubview:table];

    }
    return self;
}

-(void)hideDropDown:(UIButton *)b
{
    CGRect btn = b.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if ([self.imageList count] == [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        cell.imageView.image = [imageList objectAtIndex:indexPath.row];
    } else if ([self.imageList count] > [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    } else if ([self.imageList count] < [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideDropDown:btnSender];
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"sec_class"];
    if ([str isEqualToString:@"Class"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:c.textLabel.text forKey:@"selected_Class_Value"];
        NSLog(@"%@",c.textLabel.text);
    }
    else
    {
    [[NSUserDefaults standardUserDefaults]setObject:c.textLabel.text forKey:@"selected_Section_Value"];
        
    }
    
    NSString *strNotification = [[NSUserDefaults standardUserDefaults]objectForKey:@"notification_key"];
    
    if ([strNotification isEqualToString:@"notification"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"notification_key"];
        
        [[NSUserDefaults standardUserDefaults]setObject:c.textLabel.text forKey:@"notificationAns_key"];
    }
    
    NSString *applyLeave = [[NSUserDefaults standardUserDefaults]objectForKey:@"applyLeave_key"];
    
    if ([applyLeave isEqualToString:@"applyLeave"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"applyLeave_key"];
        
        [[NSUserDefaults standardUserDefaults]setObject:c.textLabel.text forKey:@"applyLeaveAns_key"];
    }
    
    NSString *teacher_attendance = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendanceKey"];
    
    if ([teacher_attendance isEqualToString:@"teacher_attendance"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"teacher_attendanceKey"];
        [[NSUserDefaults standardUserDefaults]setObject:c.textLabel.text forKey:@"teacher_attendance_resultKey"];
    }
    
    NSString *class_test = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_test_Key"];
    
    if ([class_test isEqualToString:@"class_test"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"class_test_Key"];
        [[NSUserDefaults standardUserDefaults]setObject:c.textLabel.text forKey:@"class_test_resultKey"];
    }
    
    NSString *subject_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_key"];
    
    if ([subject_name isEqualToString:@"subject_name"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"subject_name_key"];
        [[NSUserDefaults standardUserDefaults]setObject:c.textLabel.text forKey:@"subject_name_resultKey"];
    }
    
    
    for (UIView *subview in btnSender.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
    imgView.image = c.imageView.image;
    imgView = [[UIImageView alloc] initWithImage:c.imageView.image];
    imgView.frame = CGRectMake(5, 5, 25, 25);
    [btnSender addSubview:imgView];
    [self myDelegate];
    
}
- (void)myDelegate
{
    [self.delegate niDropDownDelegateMethod:self];
    
}
-(void)dealloc {
//    [super dealloc];
//    [table release];
//    [self release];
}

@end
