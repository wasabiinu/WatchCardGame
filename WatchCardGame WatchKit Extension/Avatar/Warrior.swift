//
//  Warrior.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//
//　戦士クラス

import Foundation
internal class Warrior : Hero
{
    override init()
    {
        super.init()
        super.hp = super.level * 10
        super.attack = super.level * 10
        super.defence = super.level * 10
        super.elementType = "slash"
    }
}