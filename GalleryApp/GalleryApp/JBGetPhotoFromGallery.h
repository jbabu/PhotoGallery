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

@protocol JBGetPhotoFromGalleryDelegate <NSObject>

-(void)jbGetPhotoFromGallery:(NSArray*)arrPhoto;

@end

@interface JBGetPhotoFromGallery : NSObject
{

    __block NSMutableArray *thumbsArr;

}
// *************  Property *************
@property (nonatomic, weak) id <JBGetPhotoFromGalleryDelegate> delegate;

// ************** Method ***************
-(void)loadAssets;
@end
