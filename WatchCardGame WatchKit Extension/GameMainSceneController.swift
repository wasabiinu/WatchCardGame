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
    private var _turnTimer:NSTimer!
    private var _floor1Manager:FloorManager
    override init()
    {
        var hero:Hero = Warrior()
        var monster:Monster = Slime()
        _floor1Manager = FloorManager()
        _floor1Manager.heroes.append(hero)
        _floor1Manager.monsters.append(monster)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        _turnTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.25), target: self, selector: Selector("onTimer:"), userInfo: nil, repeats: true)
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        _turnTimer.invalidate()
        _turnTimer = nil
    }
    
    internal func onTimer(timer:NSTimer)
    {
        println("onTimer:x:\(_floor1Manager.heroes[0].xPosition),y:\(_floor1Manager.heroes[0].yPosition)")
        
        if (_floor1Manager.heroes[0].xPosition > 71)
        {
            Floor1Content.setImage(_floor1Manager.enterFloor())
        }
        else if(_floor1Manager.battleStartProgress < 8)
        {
            Floor1Content.setImage(_floor1Manager.battleStart())
        }
        else if(_floor1Manager.heroes[0].hp > 0 && _floor1Manager.monsters[0].hp > 0)
        {
            
        }
        
    }
}