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
    internal var isMonsterTurn:Bool
    private var _alphaImage:UIImage = UIImage(named: "floor_origin.png")!
    
    init()
    {
        heroes = [Hero]()
        monsters = [Monster]()
        battleStartProgress = 0
        isMonsterTurn = true
    }
    
    internal func enterFloor() -> UIImage
    {
        
        //ヒーロー画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: heroes[0].image, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        
        //モンスター画像
        image = DrawUtil.synthesizeImage(image, synthImage: monsters[0].image, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        heroes[0].xPosition -= 5
        
        return image
    }
    
    internal func battleStart() -> UIImage
    {
        
        //ヒーロー画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: heroes[0].stopImage, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        
        //モンスター画像
        image = DrawUtil.synthesizeImage(image, synthImage: monsters[0].image, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        //バトルスタート演出画像
        image = DrawUtil.synthesizeImage(image, synthImage: UIImage(named: "battlestart\(battleStartProgress).png")!, x: 25.0, y: 5.0)
        battleStartProgress++
        
        return image
    }
    
    internal func play1Turn() -> UIImage
    {
        var heroImage:UIImage = heroes[0].stopImage
        var monsterImage:UIImage! = monsters[0].image
        
        if (isMonsterTurn == true)
        {
            //モンスターのターン処理を書く
            monsters[0].attackProgress++
            switch monsters[0].attackProgress
            {
            case 1:
                monsters[0].xPosition -= 5
                
                break
            case 3:
                monsters[0].xPosition += 10
                
                break
            case 5:
                monsters[0].xPosition -= 5
                
                
                heroes[0].xPosition += 5
                heroImage = heroes[0].progressImage(4)
                
                break
            case 6:
                heroes[0].xPosition -= 5
                break
            case 8:
                isMonsterTurn = false
                monsters[0].attackProgress = 0
                break
            default :
                monsters[0].xPosition += 0
                
                break
            }
        }
        else
        {
            //ヒーローのターン処理を書く
            heroes[0].attackProgress++
            switch heroes[0].attackProgress
            {
            case 1:
                heroes[0].xPosition += 5
                heroImage = heroes[0].progressImage(1)
                break
            case 3:
                heroes[0].xPosition -= 10
                heroImage = heroes[0].progressImage(2)
                heroImage = heroes[0].attackImage
                break
            case 4:
                heroes[0].xPosition += 0
                heroImage = heroes[0].attackImage
                break
            case 5:
                heroes[0].xPosition += 5
                monsterImage = monsters[0].progressImage(1)
                
                monsters[0].xPosition -= 5
            case 6:
                monsters[0].xPosition += 5
                break
            case 8 :
                isMonsterTurn = true
                heroes[0].attackProgress = 0
                break
            default :
                heroes[0].xPosition += 0
                heroImage = heroes[0].progressImage(0)
                break
            }
        }
        
        //ヒーロー画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: heroImage, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        
        //モンスター画像
        image = DrawUtil.synthesizeImage(image, synthImage: monsterImage, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        return image
    }
}