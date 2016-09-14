//
//  MineCollectionontroller.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/12.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MineCollectionontroller: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.collectionView?.emptyDataSetSource = self
//        self.collectionView?.emptyDataSetDelegate = self
        
        collectionView?.backgroundColor = UIColor.greenColor()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}



extension MineCollectionontroller:DZNEmptyDataSetSource{
    
    func titleForEmptyDataSet(scrollView: UIScrollView) -> NSAttributedString? {
        
        var dict = [String:AnyObject]()
        dict[NSForegroundColorAttributeName] = UIColor.blueColor()
        dict[NSFontAttributeName] = UIFont.systemFontOfSize(16)
        
        return NSAttributedString(string: "sughuisgsgsgsgsg", attributes: dict)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView) -> NSAttributedString? {
        
        var dict = [String:AnyObject]()
        dict[NSForegroundColorAttributeName] = UIColor.blueColor()
        dict[NSFontAttributeName] = UIFont.systemFontOfSize(16)
        
        return NSAttributedString(string: "sughuisgsgsgsgsg", attributes: dict)
        
    }
    
    func backgroundColorForEmptyDataSet(scrollView: UIScrollView) -> UIColor? {
        return UIColor.whiteColor()
    }
    
    func buttonBackgroundImageForEmptyDataSet(scrollView: UIScrollView, forState state: UIControlState) -> UIImage? {
        return UIImage(named: "iPhone_personal_blank~iphone")
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "iPhone_personal_blank~iphone")
    }
    
    func buttonTitleForEmptyDataSet(scrollView: UIScrollView, forState state: UIControlState) -> NSAttributedString? {
        
        var dict = [String:AnyObject]()
        dict[NSForegroundColorAttributeName] = UIColor.blueColor()
        dict[NSFontAttributeName] = UIFont.systemFontOfSize(16)
        
        return NSAttributedString(string: "哈哈", attributes: dict)
        
    }


}

extension MineCollectionontroller:DZNEmptyDataSetDelegate{


}
