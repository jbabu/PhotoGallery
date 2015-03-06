//
//  JBTableViewCell.m
//  GalleryApp
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//


#import "JBTableViewCell.h"
#import "UIColor+Custom.h"
#import "JBTableViewCollectionViewCell.h"
@implementation JBTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 9, 10);
    layout.itemSize = CGSizeMake(150,120);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[JBTableViewCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    self.collectionView.backgroundColor = [UIColor colorAppBackground];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    
    // Create Image
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.collectionView.frame.origin.x+5, self.collectionView.frame.origin.y+5, self.collectionView.frame.size.width, self.collectionView.frame.size.height-10)];
    self.imageV.backgroundColor=[UIColor whiteColor];
    [self.collectionView addSubview:self.imageV];
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.contentView.bounds;
}

-(void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.tag = index;
    [self.collectionView reloadData];
}


@end
