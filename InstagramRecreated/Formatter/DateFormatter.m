//
//  DateFormatter.m
//  InstagramRecreated
//
//  Created by Gui David on 6/30/22.
//

#import "DateFormatter.h"

@implementation DateFormatter

+ (NSString *) formatDateString:(NSString *)stringDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy-mm-dd HH:mm:ss Z";
   
    NSDate *dateFormatted = [dateFormat dateFromString:stringDate];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:dateFormatted dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];

    return dateString;
}

@end

