//
//  AdminEventDescripitionView.h
//  EducationApp
//
//  Created by HappySanz on 18/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminEventDescripitionView : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *eventdescrp;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
- (IBAction)backButton:(id)sender;
- (IBAction)OrganiserButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *eventdiscrpDateLabel;
@property (strong, nonatomic) IBOutlet UIButton *organiserOutlet;

@end
