//
//  SlashEffect.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/04.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit
internal class SlashEffect : Effect
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
            var _image:UIImage = UIImage(named: "slash\(progress).png")!
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
            super.point.x = CGFloat(newPoint.x - 3)
            super.point.y = CGFloat(newPoint.y + 12)
            
        }
    }
}