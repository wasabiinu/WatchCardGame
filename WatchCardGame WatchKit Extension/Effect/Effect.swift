//
//  Effect.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/04.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit
internal class Effect
{
    internal var progress:Int = 0
    internal var point:CGPoint
    init()
    {
        point = CGPointMake(0, 0)
    }
    
    internal var image:UIImage!
    internal var reverseImage:UIImage
    {
        get
        {
            return DrawUtil.reverseImage(image)
        }
    }
}