//
//  Slime.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//スライムクラス

import Foundation
import WatchKit
internal class Slime : Monster
{
    override init()
    {
        super.init()
        hp = super.level * 100
        maxHp = hp
        attack = super.level * 30
        defence = super.level * 30
        elementType = "impact"
        image = UIImage(named: "slime0.png")!
        iconImage = UIImage(named: "slime.png")!
        attackEffect = ImpactEffect()
    }
    override internal func progressImage(no:Int) -> UIImage
    {
        return UIImage(named: "slime\(no).png")!
    }
}