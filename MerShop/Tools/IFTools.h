//
//  IFTools.h
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFTools : NSObject

/**
 *    NSDate 转换为字符串格式：yyyy-MM-dd HH:mm:ss
 *
 *    @param     date     要转换的NSDate
 *
 *    @return yyyy-MM-dd HH:mm:ss 格式的字符串时间
 */
+ (NSString*)dateToString:(NSDate*)date;
/**
 *    NSDate 转换为字符串格式
 *
 *    @param     date     要转换的NSDate
 *    @param     dateFormat     格式的字符串，如：yyyy-MM-dd HH:mm:ss 、yyyy-MM-dd
 *
 *    @return    格式化后的时间字符串
 */
+ (NSString*)dateToString:(NSDate*)date dateFormat:(NSString*)dateFormat;

+ (NSString *)toJsonData:(id)theData;

+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;
@end

