//
//  XIWModalViewController.m
//  DemoApp
//
//  Created by User on 11/4/13.
//  Copyright (c) 2013 Xinran Wang. All rights reserved.
//

#import "XIWModalViewController.h"

@interface XIWModalViewController ()
@property (nonatomic, retain) UIToolbar *keyboardToolbar;
@property (nonatomic, retain) UIBarButtonItem *previousButton;
@property (nonatomic, retain) UIBarButtonItem *nextButton;
- (void) previousField:(id)sender;
- (void) nextField:(id)sender;
- (void) setupKeyboard:(id)sender;
- (void) resignKeyboard:(id)sender;
- (void) pickerChanged:(id)sender;
@end

@implementation XIWModalViewController

- (IBAction)dismissModal:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Never mind"
                                               destructiveButtonTitle:@"Cancel"
                                                    otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) previousField:(id)sender
{
    if ([emailField isFirstResponder]) {
        [nameField becomeFirstResponder];
    } else if ([phoneField isFirstResponder]){
        [emailField becomeFirstResponder];
    } else if ([birthdayField isFirstResponder]){
        [phoneField becomeFirstResponder];
    }
}

- (void) nextField:(id)sender
{
    if ([nameField isFirstResponder]){
        [emailField becomeFirstResponder];
    } else if ([emailField isFirstResponder]) {
        [phoneField becomeFirstResponder];
    } else if ([phoneField isFirstResponder]){
        [birthdayField becomeFirstResponder];
    }
}

- (void)setupKeyboard:(id)sender
{
    if (self.keyboardToolbar == nil){
        self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        _previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                                                           style:UIBarButtonItemStyleBordered
                                                                          target:self
                                                                          action:@selector(previousField:)];
        
        _nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(nextField:)];
        
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(resignKeyboard:)];
        [self.keyboardToolbar setItems:[[NSArray alloc] initWithObjects:_previousButton, _nextButton, extraSpace, doneButton, nil]];
    }
}

- (void) resignKeyboard:(id)sender{
    [nameField resignFirstResponder];
    [emailField resignFirstResponder];
    [phoneField resignFirstResponder];
    [birthdayField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupKeyboard:self];
    
    nameField.inputAccessoryView = self.keyboardToolbar;
    emailField.inputAccessoryView = self.keyboardToolbar;
    phoneField.inputAccessoryView = self.keyboardToolbar;
    birthdayField.inputAccessoryView = self.keyboardToolbar;
    
    UIDatePicker *myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    [myDatePicker addTarget:self
                     action:@selector(pickerChanged:)
           forControlEvents:UIControlEventValueChanged];
    myDatePicker.maximumDate = [NSDate date];
    
    birthdayField.inputAccessoryView = self.keyboardToolbar;
    birthdayField.inputView = myDatePicker;
}

- (void)pickerChanged:(id)sender
{
    NSLog(@"value: %@", [sender date]);
}

//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    CGRect viewFrame = self.view.frame;
//    viewFrame.origin.y = 0;
//    
//    [UIView beginAnimations:nil context: NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration: .4];
//    
//    [textField resignFirstResponder];
//    [self.view setFrame: viewFrame];
//    [UIView commitAnimations];
//}
//
//- (void) textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGRect viewFrame = self.view.frame;
//    
//    _previousButton.enabled = YES;
//    _nextButton.enabled = YES;
//    
//    if (nameField == textField){
//        _previousButton.enabled = NO;
//    }
//    if (birthdayField == textField){
//        _nextButton.enabled = NO;
//    }
//    
//    if (phoneField == textField){
//        viewFrame.origin.y -= 50;
//    } else if (birthdayField == textField){
//        viewFrame.origin.y -= 200;
//    }
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration: .4];
//    
//    [self.view setFrame: viewFrame];
//    [UIView commitAnimations];
//}

- (IBAction)registerUser:(id)sender
{
    if ([nameField.text isEqualToString:@""]
        || [emailField.text isEqualToString:@""]
        || [phoneField.text isEqualToString:@""]){
        UIAlertView *missingFields = [[UIAlertView alloc] initWithTitle:@"Hey"
                                                                message:@"You need to fill everything"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
        [missingFields show];
    } else {
        // perform user registration
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
