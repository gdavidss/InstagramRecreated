//
//  ProfileEditViewController.m
//  InstagramRecreated
//
//  Created by Gui David on 6/29/22.
//

#import "ProfileEditViewController.h"
#import "Post.h"

@interface ProfileEditViewController ()

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation ProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
