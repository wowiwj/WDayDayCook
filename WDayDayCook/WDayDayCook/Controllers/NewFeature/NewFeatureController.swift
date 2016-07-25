//
//  NewFeatureController.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/24.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import MediaPlayer
import SnapKit


class NewFeatureController: UIViewController {

    static let playFinishedNotify = "PlayFinishedNotify"
    
    
    private lazy var moviePlayer: MPMoviePlayerController = {
    
        let path = NSBundle.mainBundle().pathForResource("loadingVideo", ofType: "mp4")
        let player = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: path!))
        // 和屏幕一样大小
        player.view.frame = self.view.bounds
        // 设置自动播放
        player.shouldAutoplay = true
        // 设置源类型
        player.movieSourceType = .File
        // 隐藏控制视图
        player.controlStyle = .None

        return player
    }()
    
    let cancerButton: UIButton = {
    let button = UIButton()
        button.setImage(UIImage(named:"loading_start_btn"), forState: .Normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        view.addSubview(moviePlayer.view)
        moviePlayer.prepareToPlay()
        view.addSubview(cancerButton)
     
        cancerButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(-80)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.6)
            make.height.equalTo(cancerButton.snp_width).multipliedBy(0.18)
        }
        
        
        cancerButton.addTarget(self, action: #selector(playFinished), forControlEvents: .TouchUpInside)
 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playEnd), name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loadStatus), name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)

    }
    

    @objc private func loadStatus()
    {
        print(moviePlayer.loadState)
        
        if moviePlayer.loadState == MPMovieLoadState.PlaythroughOK{
            moviePlayer.play()
        }
    
    }
    
    @objc private func playFinished()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(MPMoviePlayerPlaybackDidFinishNotification, object: nil)
    }
    
    @objc func playEnd()
    {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            appDelegate.showMainStoryboard()
        }
    }
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
        print("deinit")
    }


}
