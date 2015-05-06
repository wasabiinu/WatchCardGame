//
//  MagicEffect.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/06.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit
internal class MagicEffect : Effect
{
    override init()
    {
        super.init()
    }
    
    override internal var image:UIImage!
        {
        get
        {
            if (progress > 4)
            {
                progress = 0
            }
            var _image:UIImage = UIImage(named: "magic\(progress).png")!
            progress++
            return _image
        }
        set
        {
            
        }
    }
    
    override internal var point:CGPoint
        {
        get
        {
            return super.point
        }
        set
        {
            var newPoint:CGPoint = newValue as CGPoint
            super.point.x = newPoint.x - 12
            super.point.y = newPoint.y - 6
            
        }
    }
}