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
    
    @IBOutlet weak var Floor1Content: WKInterfaceImage!
    @IBOutlet weak var Floor2Content: WKInterfaceImage!
    @IBOutlet weak var Floor3Content: WKInterfaceImage!
    @IBOutlet weak var Floor4Content: WKInterfaceImage!
    @IBOutlet weak var Floor5Content: WKInterfaceImage!
    @IBOutlet weak var Floor6Content: WKInterfaceImage!
    @IBOutlet weak var Floor7Content: WKInterfaceImage!
    @IBOutlet weak var Floor8Content: WKInterfaceImage!
    @IBOutlet weak var Floor9Content: WKInterfaceImage!
    @IBOutlet weak var Floor10Content: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        //var timerManager:TimerManager = TimerManager()
        
        TimerManager.FLOOR1CONTENT = Floor1Content
        TimerManager.FLOOR2CONTENT = Floor2Content
        TimerManager.FLOOR3CONTENT = Floor3Content
        TimerManager.FLOOR4CONTENT = Floor4Content
        TimerManager.FLOOR5CONTENT = Floor5Content
        TimerManager.FLOOR6CONTENT = Floor6Content
        TimerManager.FLOOR7CONTENT = Floor7Content
        TimerManager.FLOOR8CONTENT = Floor8Content
        TimerManager.FLOOR9CONTENT = Floor9Content
        TimerManager.FLOOR10CONTENT = Floor10Content
        
        TimerManager.start("floor1Start:", turnTime: NSTimeInterval(0.0))
        TimerManager.start("floor2Start:", turnTime: NSTimeInterval(4.0))
        TimerManager.start("floor3Start:", turnTime: NSTimeInterval(8.0))
        TimerManager.start("floor4Start:", turnTime: NSTimeInterval(12.0))
        TimerManager.start("floor5Start:", turnTime: NSTimeInterval(16.0))
        TimerManager.start("floor6Start:", turnTime: NSTimeInterval(20.0))
        TimerManager.start("floor7Start:", turnTime: NSTimeInterval(24.0))
        TimerManager.start("floor8Start:", turnTime: NSTimeInterval(28.0))
        TimerManager.start("floor9Start:", turnTime: NSTimeInterval(32.0))
        TimerManager.start("floor10Start:", turnTime: NSTimeInterval(36.0))
        
        
        //var object:NSObject = NSObject()
        
        //DrawUtil.walkThrough(Floor1Content)
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: "floor1Start", userInfo: nil, repeats: true)
        
        //walkThrough(Floor2Content)
        //walkThrough(Floor3Content)
        //walkThrough(Floor4Content)
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func floor2Start(timer:NSTimer)
    {
      //  walkThrough(Floor2Content)
    }
    

}
