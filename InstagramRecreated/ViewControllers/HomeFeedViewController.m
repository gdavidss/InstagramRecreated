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
#import "DetailViewController.h"

@import Parse;

@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *composeButton;

@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) int NUM_POSTS_SHOWN;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderComposeButton];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.NUM_POSTS_SHOWN = 20;
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(refreshHomeFeed:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self refreshHomeFeed:self.refreshControl];
}

- (void) refreshHomeFeed:(UIRefreshControl *)refreshControl {
    [refreshControl beginRefreshing];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = self.NUM_POSTS_SHOWN;
    [query orderByDescending:@"createdAt"];
    [query includeKeys:@[@"author"]];
    
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
    [refreshControl endRefreshing];
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


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"forIndexPath:indexPath];
    postCell.post = self.posts[indexPath.row];
    return postCell;
    /*
    postCell.captionPost.text = self.posts[indexPath.row][@"caption"];
    
    PFFileObject *imageData = self.posts[indexPath.row][@"image"];
    postCell.imagePost.image = [UIImage imageWithData:[imageData getData]];
    
    PFUser *author = self.posts[indexPath.row][@"author"];
    postCell.usernamePost.text = author.username;
    
    return postCell;
     */
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailViewController *detailController = [segue destinationViewController];
        detailController.post = self.posts[[self.tableView indexPathForCell:sender].row];
    }
}

@end
