//
//  JBTableViewCell.h
//  GalleryApp
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";
@interface JBTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) NSIndexPath *indexPath;

-(void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index;

@end

