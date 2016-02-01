//
//  ViewController.swift
//  ElasticList
//
//  Created by Sergio Cirasa on 1/31/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController{
    
    final let PADDING = CGFloat(10)
    final let CELL_HEIGHT = CGFloat(50.0)
    final let CELL_IDENTIFIER = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.collectionViewLayout = ElasticFlowLayout();
        self.collectionView!.delegate = self;
        self.collectionView!.dataSource = self;
    }
    //-----------------------------------------------------------------------------------------------------------------------------
    // MARK: - UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1;
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 100;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.textLabel?.text = NSString(format:"Cell %d",indexPath.row) as String
         cell.backgroundColor = UIColor.whiteColor()
        return cell;
    }
    //-----------------------------------------------------------------------------------------------------------------------------
    // MARK: - UICollectionViewDelegate
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        return CGSizeMake((CGFloat)(self.view.bounds.width - (PADDING*2)), CELL_HEIGHT);
    }
    
}