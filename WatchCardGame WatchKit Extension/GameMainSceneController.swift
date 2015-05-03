//
//  GameMainSceneController.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/03.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import WatchKit
import Foundation


class GameMainSceneController: WKInterfaceController {
    
    @IBOutlet weak var Floor1Content: WKInterfaceImage!
    private var _hero:Hero
    override init()
    {
        _hero = Warrior()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        var turnTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.25), target: self, selector: Selector("onTimer:"), userInfo: nil, repeats: true)
        
    }
    
    internal func onTimer(timer:NSTimer)
    {
        println("onTimer:x:\(_hero.xPosition),y:\(_hero.yPosition)")
        var heroImage:UIImage = UIImage(named: "warrior\(_hero.walkType).png")!
        var alphaImage:UIImage = UIImage(named: "floor_origin.png")!
        var image:UIImage = DrawUtil.synthesizeImage(alphaImage, synthImage: heroImage, x: CGFloat(_hero.xPosition), y: CGFloat(_hero.yPosition))
        Floor1Content.setImage(image)
        _hero.xPosition -= 5
    }
}