//
//  InterfaceController.swift
//  WatchCardGame WatchKit Extension
//
//  Created by 横山 優 on 2015/03/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    private var _floor1Manager:FloorManager!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        _floor1Manager = FloorManager()
        
        var floorManagerArray:[FloorManager] = [FloorManager]()
        floorManagerArray.append(_floor1Manager)
        
        Config.floorManagers = floorManagerArray
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        /*
        TimerManager.FLOOR1CONTENT = Floor1Content
        
        TimerManager.start("floor1Start:", turnTime: NSTimeInterval(0.0))
        */
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func onTouchResetBtn() {
        _floor1Manager.reset()
    }
    @IBAction func onTouchGameStartBtn() {
        var array:NSArray = ["GameMainSceneController", "MonsterSelectController"]
        
        var contextArray:NSArray = [Config.floorManagers, Config.floorManagers]
        
        self.presentControllerWithNames(array as [AnyObject], contexts: contextArray as [AnyObject])
    }
}
