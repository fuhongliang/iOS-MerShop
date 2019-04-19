//
//  IFTools.m
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "IFTools.h"

@implementation IFTools

+ (NSString*)dateToString:(NSDate*)date
{
    return [self dateToString:date dateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString*)dateToString:(NSDate*)date dateFormat:(NSString*)dateFormat
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:dateFormat];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)toJsonData:(id)theData{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (jsonData.length > 0) {
        return jsonStr;
    }else{
        return nil;
    }
}

@end
