//
//  LoseEffect.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/04.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit
internal class LoseEffect : Effect
{
    override init()
    {
        super.init()
    }
    
    override internal var image:UIImage!
        {
        get
        {
            if (progress > 8)
            {
                progress = 0
            }
            var _image:UIImage = UIImage(named: "lose\(progress).png")!
            progress++
            return _image
        }
        set
        {
            
        }
        
    }
}