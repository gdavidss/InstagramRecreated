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
#import "PostCell.h"
@import Parse;

@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *composeButton;
@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) int NUM_POSTS_SHOWN;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renderComposeButton];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.NUM_POSTS_SHOWN = 20;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self fetchPosts];
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

-(void)fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = self.NUM_POSTS_SHOWN;
    [query orderByDescending:@"createdAt"];
    // [query includeKeys:@[@"author"]];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            NSLog(@"Posts succesfully loaded: %@", self.posts);
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    PostCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    //Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    postCell.captionPost.text = self.posts[indexPath.row][@"caption"];
    
    PFFileObject *imageData = self.posts[indexPath.row][@"image"];
    postCell.imagePost.image = [UIImage imageWithData:[imageData getData]];  //self.posts[indexPath.row][@"image"];

    /*
    PFUser *user = self.messages[indexPath.row][@"user"];
    if (user != nil) {
        // User found! update username label with username
        cell.username.text = user.username;
    } else {
        // No user found, set default username
        cell.username.text = @"🤖";
    }
     */
    return postCell;

}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

@end
