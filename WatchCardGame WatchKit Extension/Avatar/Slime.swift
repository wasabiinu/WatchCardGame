//
//  Slime.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//スライムクラス

import Foundation
internal class Slime : Monster
{
    override init()
    {
        super.init()
        super.hp = super.level * 100
        super.attack = super.level * 30
        super.defence = super.level * 30
        super.elementType = "impact"
    }
}