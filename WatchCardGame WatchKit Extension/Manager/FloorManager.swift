//
//  FloorManager.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/03.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit

internal class FloorManager
{
    internal var heroes:[Hero]
    internal var monsters:[Monster]
    internal var battleStartProgress:Int
    internal var isMonsterTurn:Boolean
    init()
    {
        heroes = [Hero]()
        monsters = [Monster]()
        battleStartProgress = 0
        isMonsterTurn = true
    }
    
    internal func enterFloor() -> UIImage
    {
        var alphaImage:UIImage = UIImage(named: "floor_origin.png")!
        
        //ヒーロー画像
        var image:UIImage = DrawUtil.synthesizeImage(alphaImage, synthImage: heroes[0].image, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        
        //モンスター画像
        image = DrawUtil.synthesizeImage(image, synthImage: monsters[0].image, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        heroes[0].xPosition -= 5
        
        return image
    }
    
    internal func battleStart() -> UIImage
    {
        var alphaImage:UIImage = UIImage(named: "floor_origin.png")!
        
        //ヒーロー画像
        var image:UIImage = DrawUtil.synthesizeImage(alphaImage, synthImage: heroes[0].stopImage, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        
        //モンスター画像
        image = DrawUtil.synthesizeImage(image, synthImage: monsters[0].image, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        //バトルスタート演出画像
        image = DrawUtil.synthesizeImage(image, synthImage: UIImage(named: "battlestart\(battleStartProgress).png")!, x: 25.0, y: 5.0)
        battleStartProgress++
        
        return image
    }
    
    internal func play1Turn() -> UIImage
    {
        return UIImage(named: "floor_origin.png")!
    }
}