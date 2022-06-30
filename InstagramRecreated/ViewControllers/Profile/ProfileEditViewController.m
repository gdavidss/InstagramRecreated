//
//  ProfileEditViewController.m
//  InstagramRecreated
//
//  Created by Gui David on 6/29/22.
//

#import "ProfileEditViewController.h"
#import "Post.h"
#import "Util.h"

@import Parse;

@interface ProfileEditViewController ()

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation ProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //PFFileObject imageFr
    //[self.profileImage setImage:PFUser.currentUser[@"image"]];
    
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    //query.limit = self.NUM_POSTS;
    [query includeKey:@"username"];
    
    // Selects only posts from the current user
    [query whereKey:@"username" equalTo:PFUser.currentUser[@"username"]];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            NSLog(@"%@", users[0]);
            NSLog(@"Posts succesfully loaded");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
     */
}

- (IBAction)editProfileImage:(id)sender {
    
}

/*
- (void) sendProfileImage: (UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    PFUser *user = [PFUser currentUser];
    user.image = [Post getPFFileFromImage:image];
    
    [user saveInBackgroundWithBlock: completion];
}
*/

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the image
    [self.profileImage setImage:editedImage];
 
    // Dismiss UIImagePickerController to go back to compose view controller
    [self dismissViewControllerAnimated:YES completion:nil];
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
