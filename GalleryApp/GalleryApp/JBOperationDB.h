//
//  JBOperationDB.h
//  GalleryApp
//
//  Created by jairam Babu on 18/02/15.
//  Copyright (c) 2015 ConnexInfoSystem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JBOperationDB : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, weak) id delegate;
+ (void)saveIndocumentFolder:(NSArray*)array;
+ (NSArray*)retriveDateFromDocument;
+ (void)customWindow:(UIWindow*)window;
@end
