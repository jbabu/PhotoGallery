//
//  JBTableView.h
//
//  Created by Jairam Babu on 1/22/15.
//  Copyright (c) 2015 JairamMacbook Pro. All rights reserved.
//


#import "JBGlobleStaticText.h"
#import "JBTableView.h"

#import "UIColor+Custom.h"

#import "JBTableViewCell.h"
#import "JBTableViewCollectionViewCell.h"
@implementation JBTableView


- (void)awakeFromNib{

    self.delegate = self;
    self.dataSource = self;
    
    self.arrPhotoGalleryInfo=[[NSArray alloc]init];
    self.contentOffsetDictionary=[[NSMutableDictionary alloc]init];
}


#pragma mark - UITableViewDataSource Methods

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

   
    NSDictionary *dicDate=[self.arrPhotoGalleryInfo objectAtIndex:section];
    NSArray *arrKey=[dicDate allKeys];
   
    return  arrKey.lastObject;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    //****** UIView *****
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    if(section<self.arrPhotoGalleryInfo.count) // if Check Array Count should not be 0
    {
      //****** Date Lable *****
      UILabel *lblDate = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.origin.x+8,view.frame.origin.y, view.frame.size.width/2, view.frame.size.height)];
      lblDate.textColor = [UIColor colorAppGreen];
      NSDictionary *dicDate = [self.arrPhotoGalleryInfo objectAtIndex:section];
      NSArray *arrKey = [dicDate allKeys];
      lblDate.text = arrKey.lastObject;
      [view addSubview:lblDate];
        
        
        //****** Image Count Lable *****
        UILabel *lblImageCount = [[UILabel alloc]initWithFrame:CGRectMake(tableView.frame.size.width-208,view.frame.origin.y,200, view.frame.size.height)];
        lblImageCount.textColor= [UIColor colorAppGreen];
        NSArray *arrValue=[dicDate allValues];
        if(arrValue.count>0) // if Check Array Count should not be 0
        {
          NSArray *arrSingleValue=[arrValue objectAtIndex:0];
          lblImageCount.text=[NSString stringWithFormat:@"%d images",(int)arrSingleValue.count];
          lblImageCount.textAlignment=NSTextAlignmentRight;
          [view addSubview:lblImageCount];
        }

    }
    
    
    return view;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrPhotoGalleryInfo.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    JBTableViewCell *cell = (JBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[JBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    //[cell setCollectionViewDataSourceDelegate:self index:indexPath.section];
     cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(JBTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setCollectionViewDataSourceDelegate:self index:indexPath.section];
     NSInteger index = cell.collectionView.tag;
    
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{

    

}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    NSDictionary *dicDate=[self.arrPhotoGalleryInfo objectAtIndex:collectionView.tag];
    NSArray *arrValue=[dicDate allValues];
    NSArray *arrSingleValue=[arrValue objectAtIndex:0];
    return  arrSingleValue.count;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JBTableViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    
    NSDictionary *dicDate=nil;
    if(collectionView.tag<self.arrPhotoGalleryInfo.count)// condition in array
    {
        dicDate=[self.arrPhotoGalleryInfo objectAtIndex:collectionView.tag];
    }
    
    NSArray *arrValue=nil;
    if(dicDate!=nil)// condition for check dictionary
    {
        arrValue=[dicDate allValues];
    }
    NSArray *arrSingleValue=nil;
    if(arrValue.count) // condition for check Array
        
    {
        arrSingleValue=[arrValue objectAtIndex:0];
    }
    
    
    if(indexPath.section<arrSingleValue.count && [[arrSingleValue objectAtIndex:indexPath.section]valueForKey:IMAGETHUMBNAIL])
    {
        [cell.imageV setImage:[[arrSingleValue objectAtIndex:indexPath.section]valueForKey:IMAGETHUMBNAIL]];
    }
    
    return cell;
}


#pragma mark- UICollectionView Delegate Methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dicDate=[self.arrPhotoGalleryInfo objectAtIndex:collectionView.tag];
    NSArray *arrValue=[dicDate allValues];
    NSArray *arrSingleValue=[arrValue objectAtIndex:0];
    NSDictionary *dicImageInfo = [arrSingleValue objectAtIndex:indexPath.section];
    
    [self.jbTableViewDelegate jbTableViewcollectionView:collectionView didSelectItemAtIndexPath:indexPath ImageInfo:dicImageInfo];

}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
   if ([scrollView isKindOfClass:[UICollectionView class]])
    {
      CGFloat horizontalOffset = scrollView.contentOffset.x;
      UICollectionView *collectionView = (UICollectionView *)scrollView;
      NSInteger index = collectionView.tag;
      self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
    
      return;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if ([scrollView isKindOfClass:[UITableView class]])
    {
        
        [self.jbTableViewDelegate jbtableViewScrolling:scrollView];
        
    }
    else if ([scrollView isKindOfClass:[UICollectionView class]])
    {
        
        [self.jbTableViewDelegate jbtableViewScrolling:scrollView];
        
    }


}

@end
