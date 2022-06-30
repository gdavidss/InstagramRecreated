//
//  ProfileViewController.m
//  InstagramRecreated
//
//  Created by Gui David on 6/29/22.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import "DetailViewController.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editProfile;

@property (strong, nonatomic) NSArray *posts;

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic) int NUM_POSTS_SHOWN;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.NUM_POSTS_SHOWN = 10;
    
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
    
    // TODO: this is the only line i really need, can I reuse the code from the homefeed view controller somehow?
    // Selects only posts from the current user
    [query whereKey:@"author" equalTo:[PFUser currentUser]];

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

// infinite scrolling
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.posts.count == indexPath.row + 1) {
        // NSLog(@"test1");
        if (self.posts.count == self.NUM_POSTS_SHOWN) {
           // NSLog(@"test2");
            self.NUM_POSTS_SHOWN++;
            [self refreshHomeFeed:self.refreshControl];
        }
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"forIndexPath:indexPath];
    postCell.post = self.posts[indexPath.row];
    return postCell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailViewController *detailController = [segue destinationViewController];
        detailController.post = self.posts[[self.tableView indexPathForCell:sender].row];
    }
}
*/

@end
