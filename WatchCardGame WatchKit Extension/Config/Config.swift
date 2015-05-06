//
//  Config.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/26.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit

internal class Config {
    internal class var FLOOR_SIZE:CGSize
        {
        get
    {
        return ClassProperty.floorSize
        }
    }
    
    internal class var BUTTON_SIZE:CGSize
        {
        get
    {
        return ClassProperty.buttonSize
        }
    }
    
    internal class var MOVE_SEC:Float
        {
        get
    {
        return ClassProperty.moveSec
        }
    }
    
    internal class var floorManagers:[FloorManager]
    {
        get
        {
            return ClassProperty._floorManagers
        }
        set
        {
            ClassProperty._floorManagers = newValue
        }
    }
    
    private struct ClassProperty {
        static var floorSize:CGSize = CGSizeMake(156, 32)
        static var buttonSize:CGSize = CGSizeMake(78, 38)
        static var heartbeatRate:Float = 10
        static var moveSec:Float = 60 / heartbeatRate
        static var _floorManagers:[FloorManager] = [FloorManager]()
    }
}