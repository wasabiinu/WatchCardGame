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
    
    internal class var FLOOR2CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor2Content = newValue
        }
        get
    {
        return ClassProperty.floor2Content
        }
    }
    
    internal class var FLOOR3CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor3Content = newValue
        }
        get
    {
        return ClassProperty.floor3Content
        }
    }
    
    internal class var FLOOR4CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor4Content = newValue
        }
        get
    {
        return ClassProperty.floor4Content
        }
    }
    
    internal class var FLOOR5CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor5Content = newValue
        }
        get
    {
        return ClassProperty.floor5Content
        }
    }
    
    internal class var FLOOR6CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor6Content = newValue
        }
        get
    {
        return ClassProperty.floor6Content
        }
    }
    
    internal class var FLOOR7CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor7Content = newValue
        }
        get
    {
        return ClassProperty.floor7Content
        }
    }
    
    internal class var FLOOR8CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor8Content = newValue
        }
        get
    {
        return ClassProperty.floor8Content
        }
    }
    
    internal class var FLOOR9CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor9Content = newValue
        }
        get
    {
        return ClassProperty.floor9Content
        }
    }
    
    internal class var FLOOR10CONTENT:WKInterfaceImage
        {
        set {
        ClassProperty.floor10Content = newValue
        }
        get
    {
        return ClassProperty.floor10Content
        }
    }
    
    private struct ClassProperty {
        static var floor1Content:WKInterfaceImage!
        static var floor2Content:WKInterfaceImage!
        static var floor3Content:WKInterfaceImage!
        static var floor4Content:WKInterfaceImage!
        static var floor5Content:WKInterfaceImage!
        static var floor6Content:WKInterfaceImage!
        static var floor7Content:WKInterfaceImage!
        static var floor8Content:WKInterfaceImage!
        static var floor9Content:WKInterfaceImage!
        static var floor10Content:WKInterfaceImage!
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
    
    internal class func floor1Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR1CONTENT)
    }
    
    internal class func floor2Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR2CONTENT)
    }
    
    internal class func floor3Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR3CONTENT)
    }
    
    internal class func floor4Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR4CONTENT)
    }
    
    internal class func floor5Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR5CONTENT)
    }
    
    internal class func floor6Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR6CONTENT)
    }
    
    internal class func floor7Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR7CONTENT)
    }
    
    internal class func floor8Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR8CONTENT)
    }
    
    internal class func floor9Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR9CONTENT)
    }
    
    internal class func floor10Start(timer:NSTimer)
    {
        DrawUtil.walkThrough(FLOOR10CONTENT)
    }
}