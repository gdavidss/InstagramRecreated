//
//  LoginViewController.m
//  InstagramRecreated
//
//  Created by Gui David on 6/27/22.
//

#import "LoginViewController.h"
@import Parse;

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)beginEditingUsername:(id)sender {
    self.usernameField.text = @"";
}

- (IBAction)beginEditingPassword:(id)sender {
    self.passwordField.text = @"";
}

- (IBAction)signUp:(id)sender {
    // initialize a user object
      PFUser *newUser = [PFUser user];
      
      // set user properties
      newUser.username = self.usernameField.text;
      //newUser.email = self.emailField.text;
      newUser.password = self.passwordField.text;
      
      // call sign up function on the object
      [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
          if (error != nil) {
              NSLog(@"Error: %@", error.localizedDescription);
          } else {
              NSLog(@"User registered successfully");
              
              // segue to home feed
              [self performSegueWithIdentifier:@"loginSegue" sender:nil];
          }
      }];
}

- (IBAction)login:(id)sender {
    NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                // segue to home feed
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
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
