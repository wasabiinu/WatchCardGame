//
//  TimerManager.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/27.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit
internal class TimerManager: NSObject
{
    
    internal class var FLOOR1CONTENT:WKInterfaceImage
    {
        set {
            ClassProperty.floor1Content = newValue
        }
        get
        {
            return ClassProperty.floor1Content
        }
    }
    
    private struct ClassProperty {
        static var floor1Content:WKInterfaceImage!
    }
    
    internal class func start(selector:String, turnTime:NSTimeInterval)
    {
        println("TimerManager.start:\(selector)")
        var turnTimer = NSTimer.scheduledTimerWithTimeInterval(turnTime, target: self, selector: Selector(selector), userInfo: nil, repeats: false)
    }
    
    internal class func onUpdate(timer:NSTimer)
    {
        //println("onUpdata")
        //DrawUtil.draw()
    }
}