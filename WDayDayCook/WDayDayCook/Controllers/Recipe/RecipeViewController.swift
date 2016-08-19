//
//  RecipeViewController.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/19.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import Alamofire

class RecipeViewController: UIViewController {
    
    private lazy var waterlayout:WaterFlowlayout = {
    
        let layout1 = WaterFlowlayout()
//        layout1.itemSize = CGSize(width: 200, height: 100)
     
        layout1.delegate = self
        return layout1
    
    }()
    
    private lazy var listlayout:UICollectionViewFlowLayout = {
        let layout2 = UICollectionViewFlowLayout()
        layout2.itemSize = CGSize(width: 320, height: 150)
        return layout2
        
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
//            collectionView.collectionViewLayout = layout()
            collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "123")
            collectionView.collectionViewLayout = waterlayout
            collectionView.backgroundColor = UIColor.whiteColor()
        
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()

        // Do any additional setup after loading the view.
    }
    

    // 初始化UI
    private func makeUI()
    {
        let button = UIButton()
        button.setImage(UIImage(named: "icon－list~iphone"), forState: .Normal)
        button.setImage(UIImage(named: "icon－缩略图~iphone"), forState: .Selected)
        button.sizeToFit()
        button.addTarget(self, action: #selector(layoutStyleButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        let layoutStyleItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = layoutStyleItem
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "icon-search~iphone"), style: .Plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = searchButton
    }
    
    // MARK: - 网络请求
    func loadNewData()
    {
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - 动作监听
    @objc private func layoutStyleButtonClicked(button:UIButton)
    {
        button.selected = !button.selected
    
        button.selected ?(collectionView.collectionViewLayout = listlayout) :(collectionView.collectionViewLayout = waterlayout)
        
        collectionView.reloadData()
    
    }

}

extension RecipeViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("123", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }


}

extension RecipeViewController: UICollectionViewWaterFlowLayoutDelegate
{
    func waterFlowLayout(waterFlowLayout: WaterFlowlayout, heightForItemAtIndexpath indexpath: NSIndexPath, itemWidth: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(100) + 100)
    }
    
    func columnCountInwaterFlowLayout(waterFlowLayout: WaterFlowlayout) -> Int {
        return 2
    }

}



