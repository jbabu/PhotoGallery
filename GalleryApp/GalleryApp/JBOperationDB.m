//
//  JBOperationDB.m
//  GalleryApp
//
//  Created by jairam Babu on 18/02/15.
//  Copyright (c) 2015 ConnexInfoSystem. All rights reserved.
//

#import "JBOperationDB.h"
#import "ViewController.h"
#import "UIColor+Custom.h"
@implementation JBOperationDB
+ (void)saveIndocumentFolder:(NSArray*)array{

    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [data writeToFile:[self documentDirectryPath] atomically:YES];
}

+ (NSString*)documentDirectryPath{
    
    NSString *strDestPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *strDestPathWithName =[strDestPath stringByAppendingPathComponent:@"record"];
    return strDestPathWithName;
}

+ (NSArray*)retriveDateFromDocument{
   
    NSData *data = [[NSData alloc]initWithContentsOfFile:[self documentDirectryPath]];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return array;
    
}

+ (void)customWindow:(UIWindow*)window{

   
    ViewController *viewC=[[ViewController alloc]init];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorAppGreen]}];
    
    UINavigationController *naviHome = [[UINavigationController alloc]initWithRootViewController:viewC];
    window.rootViewController=naviHome;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];

}

@end
