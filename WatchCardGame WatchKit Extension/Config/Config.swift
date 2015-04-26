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
    
    internal class var MOVE_SEC:Float
        {
        get
    {
        return ClassProperty.moveSec
        }
    }
    
    private struct ClassProperty {
        static var floorSize:CGSize = CGSizeMake(156, 32)
        static var heartbeatRate:Float = 10
        static var moveSec:Float = 60 / heartbeatRate
    }
}