//
//  Util.h
//  InstagramRecreated
//
//  Created by Gui David on 6/30/22.
//

#import <Foundation/Foundation.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

+ (NSString *) formatDateString:(NSString *)stringDate;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
