//
//  AboutUsViewController.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutView.h"

@interface AboutUsViewController ()
@property (weak, nonatomic)AboutView *aboutView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviTitle:@"关于我们"];
    [self.view setBackgroundColor:WhiteColor];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AboutView" owner:self options:nil];
    _aboutView = [nib objectAtIndex:0];
    [_aboutView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:_aboutView];
    
}



@end
