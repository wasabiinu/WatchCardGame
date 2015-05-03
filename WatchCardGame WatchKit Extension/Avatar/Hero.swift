//
//  Hero.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//　ヒーロー基本クラス

import Foundation
import WatchKit
internal class Hero : Avatar
{
    private var _walkType:Int
    internal var stopImage:UIImage!
    internal var attackImage:UIImage!
    
    override init()
    {
        _walkType = 0
        super.init()
        xPosition = 170
    }
    
    //xの位置に応じてy位置が決まる
    override internal var yPosition:Int
    {
        get
        {
            var y:Int = 0
            
            switch xPosition
            {
                //次のフロアへ
            case -70...0 :
                y = (Int(xPosition / 5) * -1) * -2
                break
                //前のフロアから
            case 121...200 :
                y = (Int(xPosition / 5) * -1 + 24) * -2
                break
                //直進
            default :
                y = 0
                break
            }
            return y
        }
        
        set
        {
            
        }
    }
    
    internal var walkType:Int
        {
        get
        {
            var num:Int = 0;
            
            switch _walkType
            {
            case 0,2:
                num = 0
                break
            case 1:
                num = 1
                break
            default :
                num = 2
                break
            }
            
            _walkType++
            if(_walkType > 3)
            {
                _walkType = 0
            }
            
            return num
        }
    }
}
