//
//  PostCell.h
//  InstagramRecreated
//
//  Created by Gui David on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagePost;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *captionPost;
@property (strong, nonatomic) IBOutlet UILabel *usernamePost;
@property (strong, nonatomic) IBOutlet UILabel *datePost;
@property (strong, nonatomic) IBOutlet UILabel *likesPost;


@property (strong, nonatomic) Post *post;


@end

NS_ASSUME_NONNULL_END
