//
//  IFUtils.h
//  MerShop
//
//  Created by mac on 2019/3/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IFUtils : NSObject
+(instancetype)share;
-(void)showLoadingView;
-(void)showErrorInfo:(NSString*)info;

@end

