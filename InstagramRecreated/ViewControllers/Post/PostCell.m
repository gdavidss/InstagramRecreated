//
//  PostCell.m
//  InstagramRecreated
//
//  Created by Gui David on 6/28/22.
//

#import "PostCell.h"
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void) setPost:(Post *)post {
    _post = post;
    self.imagePost.image = [UIImage imageWithData:[post.image getData]];
    self.captionPost.text = post.caption;
    
    self.usernamePost.text = post.author.username;
    
    self.profileImage = nil; // TODO: profile pictures

    self.likesPost.text = [NSString stringWithFormat:@"%@ likes", post.likeCount];
    
    // TODO: format date post
    self.datePost.text = [NSString stringWithFormat:@"%@", post.createdAt];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
