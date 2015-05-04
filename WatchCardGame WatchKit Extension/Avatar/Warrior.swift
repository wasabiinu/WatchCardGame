//
//  Warrior.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//　戦士クラス

import Foundation
import WatchKit
internal class Warrior : Hero
{
    override init()
    {
        super.init()
        hp = super.level * 10
        maxHp = hp
        attack = super.level * 10
        defence = super.level * 10
        elementType = "slash"
        stopImage = UIImage(named: "warrior0.png")!
        attackImage = UIImage(named: "warrior3.png")!
        attackEffect = SlashEffect()
    }
    
    override internal var image:UIImage!
    {
        get
        {
            if (attackProgress == 0)
            {
                return UIImage(named: "warrior\(walkType).png")!
            }
            else
            {
                return UIImage(named: "warrior3.png")!
            }
            
        }
        set
        {
            
        }
    }
    
    override internal func progressImage(no:Int) -> UIImage
    {
        return UIImage(named: "warrior\(no).png")!
    }
}