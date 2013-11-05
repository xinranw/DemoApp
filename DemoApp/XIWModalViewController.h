//
//  XIWModalViewController.h
//  DemoApp
//
//  Created by User on 11/4/13.
//  Copyright (c) 2013 Xinran Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIWModalViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *emailField;
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *birthdayField;
}

- (IBAction)dismissModal:(id)sender;
- (IBAction)registerUser:(id)sender;

@end
