//
//  ComposeController.m
//  InstagramRecreated
//
//  Created by Gui David on 6/28/22.
//

#import "ComposeController.h"
#import "Post.h"
#import "MBProgressHUD.h"

@interface ComposeController ()

@property (weak, nonatomic) IBOutlet UIImageView *composeImage;
@property (weak, nonatomic) IBOutlet UITextField *captionField;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation ComposeController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)beginEditingCaption:(id)sender {
    self.captionField.text = @"";
}


- (IBAction)tapGesture:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the image
    [self.composeImage setImage:editedImage];
    
    // Dismiss UIImagePickerController to go back to compose view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapShare:(id)sender {
    // Progress HUD for when post is being made
    [MBProgressHUD showHUDAddedTo:self.view animated: true];
    
    [Post postUserImage:self.composeImage.image withCaption:self.captionField.text
         withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
    NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Post made successfully");
        }
        // Hides progress HUD on completion
        [MBProgressHUD hideHUDForView:self.view animated:true];
    }];
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
