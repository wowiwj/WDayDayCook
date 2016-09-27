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
    
    
    fileprivate lazy var moviePlayer: MPMoviePlayerController = {
    
        let path = Bundle.main.path(forResource: "loadingVideo", ofType: "mp4")
        let player = MPMoviePlayerController(contentURL: URL(fileURLWithPath: path!))
        // 和屏幕一样大小
        player?.view.frame = self.view.bounds
        // 设置自动播放
        player?.shouldAutoplay = true
        // 设置源类型
        player?.movieSourceType = .file
        // 隐藏控制视图
        player?.controlStyle = .none

        return player!
    }()
    
    let cancerButton: UIButton = {
    let button = UIButton()
        button.setImage(UIImage(named:"loading_start_btn"), for: UIControlState())
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
        
        
        cancerButton.addTarget(self, action: #selector(playFinished), for: .touchUpInside)
 
        NotificationCenter.default.addObserver(self, selector: #selector(playEnd), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadStatus), name: NSNotification.Name.MPMoviePlayerLoadStateDidChange, object: nil)

    }
    

    @objc fileprivate func loadStatus()
    {
        print(moviePlayer.loadState)
        
        if moviePlayer.loadState == MPMovieLoadState.playthroughOK{
            moviePlayer.play()
        }
    
    }
    
    @objc fileprivate func playFinished()
    {
        NotificationCenter.default.post(name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: nil)
    }
    
    @objc func playEnd()
    {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.showMainStoryboard()
        }
    }
    
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    
        print("deinit")
    }


}
