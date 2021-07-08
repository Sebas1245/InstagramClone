//
//  LoginViewController.m
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 06/07/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "Alert.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)handleLogin:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSString *errorMsg = @"There was an error logging you in. Please verify your username and password and check that you have a good network connection";
            [[Alert new] showAlertWithMessage:errorMsg viewController:self];
        } else {
            NSLog(@"User logged in successfully");
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"AuthenticatedView" sender:nil];
        }
    }];
}
- (IBAction)handleSignup:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            NSString *errorMsg = [NSString stringWithFormat:@"There was an error perfoming signup: %@", error.localizedDescription];
            [[Alert new] showAlertWithMessage:errorMsg viewController:self];
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"AuthenticatedView" sender:nil];
        }
    }];
}

@end
