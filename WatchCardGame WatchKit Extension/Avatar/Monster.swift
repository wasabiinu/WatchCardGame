//
//  Monster.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/29.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

//モンスター基本クラス

import Foundation
internal class Monster : Avatar
{
    override init() {
        super.init()
        xPosition = 60
        yPosition = 0
    }
}