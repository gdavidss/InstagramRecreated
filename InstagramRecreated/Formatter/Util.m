//
//  Util.m
//  InstagramRecreated
//
//  Created by Gui David on 6/30/22.
//

#import "Util.h"

@implementation Util

+ (NSString *) formatDateString:(NSString *)stringDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy-mm-dd HH:mm:ss Z";
   
    NSDate *dateFormatted = [dateFormat dateFromString:stringDate];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:dateFormatted dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];

    return dateString;
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end

