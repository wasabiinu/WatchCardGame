//
//  WinEffect.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/04.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit
internal class WinEffect : Effect
{
    override init()
    {
        super.init()
    }
    
    override internal var image:UIImage!
        {
        get
        {
            println("progress:\(progress)")
            if (progress > 7)
            {
                progress = 0
            }
            var _image:UIImage = UIImage(named: "win\(progress).png")!
            println("win\(progress).png")
            progress++
            return _image
        }
        set
        {
            
        }
        
    }
}