//
//  UIColor+Custom.m
//  GalleryApp
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)
+ (UIColor *) colorAppGreen{

    //return [UIColor redColor];
    return [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];

}
+ (UIColor *) colorAppBlue{

    return [UIColor colorWithRed:107/255.0 green:155/255.0 blue:202/255.0 alpha:1.0f];
    
}

+ (UIColor *) colorAppBackground{

    return  [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];

}

@end
