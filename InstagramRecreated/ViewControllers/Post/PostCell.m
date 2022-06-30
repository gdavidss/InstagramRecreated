//
//  PostCell.m
//  InstagramRecreated
//
//  Created by Gui David on 6/28/22.
//

#import "PostCell.h"
#import "Post.h"
#import "DateFormatter.h"

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
    
    NSString *stringDate = [NSString stringWithFormat:@"%@", post.createdAt];
    self.datePost.text = [DateFormatter formatDateString:stringDate];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
