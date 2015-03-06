//
//  JBTableView.h
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//





#import <UIKit/UIKit.h>
@protocol JBTableViewDelegate <NSObject>

-(void)jbTableViewtableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)jbTableViewcollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath ImageInfo:(NSDictionary*)dicImageInfo;;

-(void)jbtableViewScrolling:(id)scrollView;

@end

@interface JBTableView : UITableView <UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@property (nonatomic, strong) NSArray *arrPhotoGalleryInfo;
@property (nonatomic, weak) id<JBTableViewDelegate> jbTableViewDelegate;
@end
