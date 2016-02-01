//
//  ViewController.m
//  ListDemo
//
//  Created by Sergio Cirasa on 1/31/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import "ViewController.h"
#import "ElasticFlowLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

//------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.collectionViewLayout = [[ElasticFlowLayout alloc] init];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}
//------------------------------------------------------------------------------------------------------------------------------
#pragma mark - UICollectionView DataSource & Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//------------------------------------------------------------------------------------------------------------------------------
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}
//------------------------------------------------------------------------------------------------------------------------------
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    return cell;
}
//------------------------------------------------------------------------------------------------------------------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat padding = 10;
    CGFloat cellHeight = 50;
    return CGSizeMake(self.view.bounds.size.width - (padding*2), cellHeight);
}
//------------------------------------------------------------------------------------------------------------------------------
@end
