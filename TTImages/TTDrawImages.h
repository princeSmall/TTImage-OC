//
//  TTDrawImages.h
//  TTImages
//
//  Created by le tong on 2019/12/17.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTDrawImages : NSObject

+ (UIImage *)ttdrawOriginImageRadii:(CGFloat)radii corner:(UIRectCorner)corner color:(UIColor *)color;
+ (UIImage *)ttdrawColorImageRadii:(CGFloat)radii corner:(UIRectCorner)corner colorArray:(NSArray *)colorArray;
+ (UIImage *)ttdrawImageFromFilePath:(NSString *)filePath;
@end

NS_ASSUME_NONNULL_END
