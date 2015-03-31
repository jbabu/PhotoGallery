//
//  JBGetPhotoFromGallery.h
//  AFTabledCollectionView
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>


@interface JBGetPhotoFromGallery : NSObject

// ************** Method ***************
+ (void)getPhotoFromLibrary:(void(^)(NSArray *arrImage))handleCompletion;
@end
