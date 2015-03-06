//
//  JBDisplayViewController.m
//  GalleryApp
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//


#import "JBDisplayViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "JBGlobleStaticText.h"
@interface JBDisplayViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imagV;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;

@end

@implementation JBDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    [self geTheImageFromLibrary];
    
}
// Set ScrollView
- (void)setupScrollView{

    self.scrollV.delegate=self;
    self.scrollV.minimumZoomScale = 1.0;
    self.scrollV.maximumZoomScale = 4.0;
    self.scrollV.scrollEnabled=YES;

}
// Get the Image from Library
-(void)geTheImageFromLibrary{
   
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            self.imagV.image = [UIImage imageWithCGImage:iref];
            NSData *data=UIImagePNGRepresentation(self.imagV.image);
            NSLog(@"%u KB",data.length/(1024*1024));
           
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"booya, cant get image - %@",[myerror localizedDescription]);
    };
    
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:[self.dicImageInfo valueForKey:IMAGEURL]
                       resultBlock:resultblock
                      failureBlock:failureblock];
   
    
}

#pragma mark- ScrollView Scroll Delegate Method
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.imagV;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Action Button
- (IBAction)actionDismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
