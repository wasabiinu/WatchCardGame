//
//  Bat.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/06.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit
internal class Bat : Monster
{
    override init()
    {
        super.init()
        hp = super.level * 20
        maxHp = hp
        attack = super.level * 30
        defence = super.level * 30
        elementType = "magic"
        image = UIImage(named: "bat0.png")!
        iconImage = UIImage(named: "bat.png")!
        attackEffect = MagicEffect()
        name = "bat"
    }
    override internal func progressImage(no:Int) -> UIImage
    {
        return UIImage(named: "bat\(no).png")!
    }
}