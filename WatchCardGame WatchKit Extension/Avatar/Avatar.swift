//
//  Avatar.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

//アバター基本クラス

import Foundation
import WatchKit
internal class Avatar
{
    internal var hp:Int = 1
    internal var maxHp:Int = 1
    internal var elementType:String = "impact"
    internal var level:Int = 1
    internal var attack:Int = 1
    internal var defence:Int = 1
    internal var floor:Int = 1
    internal var standPosition:String = "left"
    internal var xPosition:Int = 0
    internal var yPosition:Int = 0
    internal var image:UIImage!
    internal var iconImage:UIImage!
    internal var attackProgress:Int = 0
    internal var attackEffect:Effect!
    internal func progressImage(no:Int) -> UIImage
    {
        return UIImage(named: "floor_origin.png")!
    }
}