//
//  TTDrawImages.m
//  TTImages
//
//  Created by le tong on 2019/12/17.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "TTDrawImages.h"

@implementation TTDrawImages
//        kCGImageSourceCreateThumbnailWithTransform - 设置缩略图是否进行Transfrom变换
//        kCGImageSourceCreateThumbnailFromImageAlways - 设置是否创建缩略图，无论原图像有没有包含缩略图，默认kCFBooleanFalse，影响 CGImageSourceCreateThumbnailAtIndex 方法
//        kCGImageSourceCreateThumbnailFromImageIfAbsent - 设置是否创建缩略图，如果原图像有没有包含缩略图，则创建缩略图，默认kCFBooleanFalse，影响 CGImageSourceCreateThumbnailAtIndex 方法
//        kCGImageSourceThumbnailMaxPixelSize - 设置缩略图的最大宽/高尺寸 需要设置为CFNumber值，设置后图片会根据最大宽/高 来等比例缩放图片
//        kCGImageSourceShouldCache - 设置是否以解码的方式读取图片数据 默认为kCFBooleanTrue，如果设置为true，在读取数据时就进行解码 如果为false 则在渲染时才进行解码 */
+ (UIImage *)ttdrawImageFromFilePath:(NSString *)filePath{
    if (@available(iOS 10,*)) {
        NSURL *url = [[NSURL alloc]initFileURLWithPath:filePath];
        CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)url, NULL);
        CFDictionaryRef dicOptionsRef = (__bridge CFDictionaryRef) @{
                                                                     (id)kCGImageSourceCreateThumbnailFromImageIfAbsent : @(YES),
                                                                     (id)kCGImageSourceThumbnailMaxPixelSize : @(1000),
                                                                     (id)kCGImageSourceShouldCache : @(YES),
                                                                     };
        CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, dicOptionsRef);
        return [[UIImage alloc]initWithCGImage:imageRef];
    }else{
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:filePath];
        CGFloat scale = 0.2f;
        CGFloat imageW = image.size.width *scale;
        CGFloat imageH = image.size.height *scale;
        CGSize size = CGSizeMake(imageW, imageH);
        UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc]initWithSize:size];
        UIImage *resizedImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        }];
        return resizedImage;
    }
}

+ (UIImage *)ttdrawOriginImageRadii:(CGFloat)radii corner:(UIRectCorner)corner color:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 200, 100);
    if (@available(iOS 10,*)) {
        UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc]initWithSize:rect.size];
        UIImage *image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            [color setFill];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:CGSizeMake(radii, radii)];
            [path addClip];
            UIRectFill(rect);
        }];
        return image;
        
    }else{
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        [color setFill];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:CGSizeMake(radii, radii)];
        [path addClip];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

+ (UIImage *)ttdrawColorImageRadii:(CGFloat)radii corner:(UIRectCorner)corner colorArray:(nonnull NSArray *)colorArray{
    CGRect rect = CGRectMake(0, 0, 200, 100);
    if (@available(iOS 10,*)) {
        UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc]initWithSize:rect.size];
        UIImage *image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:CGSizeMake(radii, radii)];
            [path addClip];
            UIRectFill(rect);
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGFloat locations[3] = {0,0.5,1};
            
            CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorArray, locations);

            CGPoint startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
            
            CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
            
            
            CGContextDrawLinearGradient(rendererContext.CGContext, gradientRef, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
        }];
        return image;

    }else{
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:CGSizeMake(radii, radii)];
        [path addClip];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[3] = {0,0.5,1};
        CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorArray, locations);
        CGPoint startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint,kCGGradientDrawsBeforeStartLocation);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
@end
