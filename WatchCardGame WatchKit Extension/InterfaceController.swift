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
    private var _floor2Manager:FloorManager!
    private var _floor3Manager:FloorManager!
    private var _floor4Manager:FloorManager!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        _floor1Manager = FloorManager()
        _floor2Manager = FloorManager()
        _floor3Manager = FloorManager()
        _floor4Manager = FloorManager()
        
        var floorManagerArray:[FloorManager] = [FloorManager]()
        floorManagerArray.append(_floor1Manager)
        floorManagerArray.append(_floor2Manager)
        floorManagerArray.append(_floor3Manager)
        floorManagerArray.append(_floor4Manager)
        
        Config.DEVICE = WKInterfaceDevice.currentDevice()
        
        Config.floorManagers = floorManagerArray
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func onTouchResetBtn() {
        _floor1Manager.reset()
        _floor2Manager.reset()
        _floor3Manager.reset()
        _floor4Manager.reset()
    }
    @IBAction func onTouchGameStartBtn() {
        var array:NSArray = ["GameMainSceneController", "MonsterSelectController"]
        
        var contextArray:NSArray = [Config.floorManagers, Config.floorManagers]
        
        self.presentControllerWithNames(array as [AnyObject], contexts: contextArray as [AnyObject])
    }
}
