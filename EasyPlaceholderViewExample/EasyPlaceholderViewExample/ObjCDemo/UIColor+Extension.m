//
//  UIColor+Extension.m
//  EasyPlaceholderViewExample
//
//  Created by carefree on 2022/6/26.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (instancetype)colorWithHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r /255.0f
                           green:g /255.0f
                            blue:b /255.0f
                           alpha:1.0f];
}

@end
