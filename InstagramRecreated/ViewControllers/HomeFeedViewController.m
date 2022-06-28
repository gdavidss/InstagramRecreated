//
//  HomeFeedViewController.m
//  InstagramRecreated
//
//  Created by Gui David on 6/27/22.
//

#import "HomeFeedViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
@import Parse;

@interface HomeFeedViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *composeButton;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renderComposeButton];
    
}

-(void)renderComposeButton {
    UIImage *image = [[UIImage imageNamed:@"insta_camera_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.composeButton setImage:image forState:UIControlStateNormal];
    
    self.composeButton.tintColor = [UIColor linkColor];
}

- (IBAction)logout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
   
    SceneDelegate *mySceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    mySceneDelegate.window.rootViewController = loginViewController;
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
