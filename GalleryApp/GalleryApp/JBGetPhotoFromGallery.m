//
//  JBGetPhotoFromGallery.m
//  AFTabledCollectionView
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//




#import "JBGetPhotoFromGallery.h"
#import "JBGlobleStaticText.h"
@implementation JBGetPhotoFromGallery

-(id)init{

    
    self=[super init];
    
    if(self)
    {
    
        thumbsArr=[[NSMutableArray alloc]init];
    
    }
    
    return self;

}
-(void)loadAssets{
  
    __block NSDate *now = [NSDate date];
    __block NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mmm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"Start: %@",[dateFormatter stringFromDate:now]);
    
    //***************** initialized the Object *****************************
    
    __block NSMutableArray *arrInsideDic;
    __block NSMutableDictionary *dicTime;
     __block  NSMutableDictionary *dicPhotoInfo;
    
    //***************** initialized the Object *****************************
    
    __block ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
            
            if (alAsset) {
                
                NSDate* date = [alAsset valueForProperty:ALAssetPropertyDate];
                ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                UIImage *latestPhotoThumbnail = [UIImage imageWithCGImage:[alAsset thumbnail]];
                

                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //dateFormatter.dateFormat = @"yyyy-MM-dd";
                dateFormatter.dateFormat = @"dd-MM-yyyy";
                //dateFormatter.dateFormat = @"yyyy-MM-ddHH:mm:ss";
                
                
                
                if([self dateComparingPhotoGalleryDate:[dateFormatter stringFromDate:date] CompareDate:@"02-09-2014"]) // Compare Date it will show 02-09-2014 up to till date
                {
                    
                    
                    if([dicTime valueForKey:[dateFormatter stringFromDate:date]])
                    {
                        dicPhotoInfo=[[NSMutableDictionary alloc]init];
                        [dicPhotoInfo setValue:representation.url forKey:IMAGEURL];
                        [dicPhotoInfo setValue:latestPhotoThumbnail forKey:IMAGETHUMBNAIL];
                        [dicPhotoInfo setValue:[dateFormatter stringFromDate:date] forKey:IMAGEDATE];
                        [arrInsideDic addObject:dicPhotoInfo];
                        [dicTime setValue:arrInsideDic forKey:[dateFormatter stringFromDate:date]];
                        
                    }
                    else{
                        
                        arrInsideDic=[[NSMutableArray alloc]init];
                        dicPhotoInfo=[[NSMutableDictionary alloc]init];
                        dicTime=[[NSMutableDictionary alloc]init];
                        
                        [dicPhotoInfo setValue:representation.url forKey:IMAGEURL];
                        [dicPhotoInfo setValue:latestPhotoThumbnail forKey:IMAGETHUMBNAIL];
                        [dicPhotoInfo setValue:[dateFormatter stringFromDate:date] forKey:IMAGEDATE];
                        [arrInsideDic addObject:dicPhotoInfo];
                        
                        [dicTime setValue:arrInsideDic forKey:[dateFormatter stringFromDate:date]];
                        [thumbsArr addObject:dicTime];
                        
                    }
                    
                }
                
                representation = nil;
                latestPhotoThumbnail = nil;
                date=nil;
                
            }else{
                now = [NSDate date];
                NSLog(@"End: %@",[dateFormatter stringFromDate:now]);
                now = nil;
                library = nil;
                dateFormatter = nil;
                
                
                
            }
            
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(self.delegate)
            {
                [self.delegate jbGetPhotoFromGallery:thumbsArr];
            }
            
        });
        
        
    } failureBlock: ^(NSError *error) {
        NSLog(@"No groups: %@",error);
    }];
}

-(BOOL)dateComparingPhotoGalleryDate:(NSString*)strPhotoGalleryDate CompareDate:(NSString*)strCompareDate{
    
    //********* Date Comparing ********************
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy";
    
    // Photo Gallery Date
    NSDate *datePrevious = [dateFormatter dateFromString:strPhotoGalleryDate];

    // Compare Date
    NSDate *dateCurrentDate = [dateFormatter dateFromString:strCompareDate];
    
    switch ([datePrevious compare:dateCurrentDate]){
        case NSOrderedAscending:
            NSLog(@"NSOrderedAscending");
            return NO; // If you want Less than of Compare Date Just Put Here Yes
            break;
        case NSOrderedSame:
            NSLog(@"NSOrderedSame");
             return YES;
            break;
        case NSOrderedDescending:
            NSLog(@"NSOrderedDescending");
             return YES; // If you want Less than of Compare Date than Just Put Here NO
            break;
    }
  
    return NO;
}

@end


