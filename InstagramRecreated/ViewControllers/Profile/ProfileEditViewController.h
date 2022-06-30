//
//  ProfileEditViewController.h
//  InstagramRecreated
//
//  Created by Gui David on 6/29/22.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface ProfileEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

NS_ASSUME_NONNULL_END
