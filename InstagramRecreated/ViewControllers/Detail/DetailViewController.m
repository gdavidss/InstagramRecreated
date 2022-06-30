//
//  DetailViewController.m
//  InstagramRecreated
//
//  Created by Gui David on 6/28/22.
//

#import "DetailViewController.h"
#import "DateFormatter.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imagePost;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *captionPost;
@property (strong, nonatomic) IBOutlet UILabel *usernamePost;
@property (strong, nonatomic) IBOutlet UILabel *datePost;
@property (strong, nonatomic) IBOutlet UILabel *likesPost;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imagePost.image = [UIImage imageWithData:[_post.image getData]];
    self.captionPost.text = _post.caption;
    
    self.usernamePost.text = _post.author.username;
    
    self.profileImage = nil; // TODO: profile pictures

    self.likesPost.text = [NSString stringWithFormat:@"%@ likes", _post.likeCount];
    
    NSString *stringDate = [NSString stringWithFormat:@"%@", _post.createdAt];
    self.datePost.text = [DateFormatter formatDateString:stringDate];
}

@end
