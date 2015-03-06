//
//  JBTableViewCollectionViewCell.m
//  GalleryApp
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//

#import "JBTableViewCollectionViewCell.h"
#import "UIColor+Custom.h"
@implementation JBTableViewCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width-1, self.frame.size.height-1
                                                                )];
        self.imageV.tag =21;
        self.imageV.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.imageV.backgroundColor = [UIColor whiteColor];
        self.imageV.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageV];
        
        // Set The color
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    return self;
    
}

@end
