//
//  Hero.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//　ヒーロー基本クラス

import Foundation
internal class Hero : Avatar
{
    internal var xPosition:Int = 170
    private var _walkType:Int
    
    override init()
    {
        _walkType = 0
        super.init()
    }
    
    //xの位置に応じてy位置が決まる
    internal var yPosition:Int
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
