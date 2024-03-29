//
//  TeacherViewController.h
//  EducationApp
//
//  Created by HappySanz on 02/08/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIButton *classAttendanceOutlet;
@property (strong, nonatomic) IBOutlet UIButton *classAssignmentOutlet;
- (IBAction)classAttendanceBtn:(id)sender;
- (IBAction)classAssignBtn:(id)sender;

@end
