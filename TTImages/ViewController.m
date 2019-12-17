//
//  ViewController.m
//  TTImages
//
//  Created by le tong on 2019/12/17.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "ViewController.h"
#import "TTDrawImages.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *originImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
    originImageView.image = [TTDrawImages ttdrawOriginImageRadii:10 corner:corner color:UIColor.greenColor];
    
    UIImageView *colorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 250, 200, 100)];
    NSArray *colorArray = @[(__bridge id)UIColor.redColor.CGColor,(__bridge id)UIColor.orangeColor.CGColor,(__bridge id)UIColor.blueColor.CGColor];
    colorImageView.image = [TTDrawImages ttdrawColorImageRadii:10 corner:corner colorArray:colorArray];
    
    UIImageView *fileImageView = [[ UIImageView alloc]initWithFrame:CGRectMake(100, 400, 200, 300)];
    fileImageView.image = [TTDrawImages ttdrawImageFromFilePath:@"/Users/letong/Desktop/TTPopView/TTImagesOC/TTImages/TTImage.png"];
    
    [self.view addSubview:originImageView];
    [self.view addSubview:colorImageView];
    [self.view addSubview:fileImageView];
    // Do any additional setup after loading the view.
}


@end
