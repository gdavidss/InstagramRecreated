//
//  Post.m
//  InstagramRecreated
//
//  Created by Gui David on 6/28/22.
//

#import "Post.h"
#import "MBProgressHUD.h"
#import "Util.h"
@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;


+ (nonnull NSString *)parseClassName {
    return @"Post";
}


+ (void) postUserImage: (UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [Util getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];
}


@end
