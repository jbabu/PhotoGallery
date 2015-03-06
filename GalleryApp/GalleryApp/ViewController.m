//
//  ViewController.m
//  GalleryApp
//
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//

#import "ViewController.h"
#import "JBGetPhotoFromGallery.h"
#import "JBTableView.h"
#import "UIViewController+ScrollingNavbar.h"
#import "JBDisplayViewController.h"
#import "UIColor+Custom.h"
#import "JBOperationDB.h"

@interface ViewController ()<JBGetPhotoFromGalleryDelegate,JBTableViewDelegate>
@property (weak, nonatomic) IBOutlet JBTableView *jbTable;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.title = @"Photos Gallery";
    self.view.backgroundColor = [UIColor colorAppBackground];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
    //self.jbTable.colorArray=self.colorArray;
    self.jbTable.contentOffsetDictionary=self.contentOffsetDictionary;
    self.jbTable.jbTableViewDelegate=self;
    
   // [self getThePhotoFromPhotoGallery];
    
    // Just call this line to enable the scrolling navbar
    
    NSLayoutConstraint *leftButtonXConstraint = [NSLayoutConstraint
                                                 constraintWithItem:self.jbTable attribute:NSLayoutAttributeCenterX
                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:
                                                 NSLayoutAttributeCenterX multiplier:1.0 constant:-60.0f];
    [self followScrollView:self.jbTable usingTopConstraint:leftButtonXConstraint withDelay:20];
    [self setShouldScrollWhenContentFits:YES];
    [self setViewScrollingType:self.jbTable];
    
    NSMutableArray *arrImage = [[NSMutableArray alloc]init];
    
    for (int i =0 ; i < 5000; i++) {
        
        [arrImage addObject:[UIImage imageNamed:@"1.jpg"]];
    }
    [JBOperationDB saveIndocumentFolder:arrImage];
    
   NSLog(@"%@",[JBOperationDB retriveDateFromDocument]);
}


//Get the Photo From Gallery
- (void)getThePhotoFromPhotoGallery{
    
    
    JBGetPhotoFromGallery *getPhoto = [[JBGetPhotoFromGallery alloc]init];
    getPhoto.delegate=self;
    [getPhoto loadAssets];
    
    
   /*
   if([[JBOperationDB retriveDateFromDocument]count]==0)
    {
       JBGetPhotoFromGallery *getPhoto = [[JBGetPhotoFromGallery alloc]init];
        getPhoto.delegate=self;
       [getPhoto loadAssets];
    }
    else{
       
        NSArray *arrPhoto =[JBOperationDB retriveDateFromDocument];
        self.jbTable.arrPhotoGalleryInfo=arrPhoto;
        [self.jbTable reloadData];
    }
    */
   
}

#pragma mark- JBGetPhotoFromGalleryClass Delegate Method
-(void)jbGetPhotoFromGallery:(NSArray *)arrPhoto{
    
    self.jbTable.arrPhotoGalleryInfo=arrPhoto;
    [self.jbTable reloadData];
    
    [JBOperationDB saveIndocumentFolder:arrPhoto];
    
}

#pragma mark- JBTableView Delegate Method

-(void)jbTableViewcollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath ImageInfo:(NSDictionary *)dicImageInfo{
    
    
    NSLog(@"%@",indexPath);
    NSLog(@"%@",dicImageInfo);
    
    JBDisplayViewController *display=[[JBDisplayViewController alloc]init];
    display.dicImageInfo=dicImageInfo;
    [self.navigationController presentViewController:display animated:YES completion:NULL];
    
}

-(void)jbTableViewtableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",indexPath);
    
}

-(void)jbtableViewScrolling:(id)scrollView{

    
    if([scrollView isKindOfClass:[UITableView class]])
    {
    
        [self setViewScrollingType:scrollView];
        
    
    }
   

}

@end
