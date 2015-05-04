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
    private var _effect:Effect!
    
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
        var monsterImage:UIImage = monsters[0].image
        var effectImage:UIImage = UIImage(named: "floor_origin.png")!
        
        if (isMonsterTurn == true)
        {
            //モンスターのターン処理を書く
            monsters[0].attackProgress++
            println("monsters[0].attackProgress:\(monsters[0].attackProgress)")
            switch monsters[0].attackProgress
            {
            case 1:
                monsters[0].xPosition -= 5
                
                break
            case 3:
                //ヒットした瞬間
                monsters[0].xPosition += 10
                
                monsters[0].attackEffect.progress = 0
                monsters[0].attackEffect.point.x = CGFloat(heroes[0].xPosition)
                monsters[0].attackEffect.point.y = CGFloat(heroes[0].yPosition)
                
                effectImage = monsters[0].attackEffect.image
                
                //ヒーローのHPを削る
                heroes[0].hp -= 1
                break
            case 4:
                //ヒットした瞬間
                monsters[0].xPosition += 0
                effectImage = monsters[0].attackEffect.image
                break
            case 5:
                monsters[0].xPosition -= 5
                heroes[0].xPosition += 5
                
                effectImage = monsters[0].attackEffect.image
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    _effect = WinEffect()
                    heroImage = heroes[0].progressImage(5)
                }
                else
                {
                    heroImage = heroes[0].progressImage(4)
                }
                
                break
            case 6:
                heroes[0].xPosition -= 5
                effectImage = monsters[0].attackEffect.image
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    heroImage = heroes[0].progressImage(6)
                }
                break
            case 7:
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    heroImage = heroes[0].progressImage(7)
                }
                break
            case 8:
                isMonsterTurn = false
                monsters[0].attackProgress = 0
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    heroImage = heroes[0].progressImage(8)
                }
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
            println("heroes[0].attackProgress:\(heroes[0].attackProgress)")
            
            switch heroes[0].attackProgress
            {
            case 1:
                heroes[0].xPosition += 5
                heroImage = heroes[0].progressImage(1)
                break
            case 3:
                //ヒットした瞬間
                heroes[0].xPosition -= 10
                heroImage = heroes[0].progressImage(2)
                heroImage = heroes[0].attackImage
                
                heroes[0].attackEffect.progress = 0
                heroes[0].attackEffect.point.x = CGFloat(monsters[0].xPosition)
                heroes[0].attackEffect.point.y = CGFloat(monsters[0].yPosition)
                
                effectImage = heroes[0].attackEffect.reverseImage
                
                //モンスターのHPを削る
                monsters[0].hp -= 5
                break
            case 4:
                //ヒットした瞬間
                heroes[0].xPosition += 0
                heroImage = heroes[0].attackImage
                
                effectImage = heroes[0].attackEffect.reverseImage
                break
            case 5:
                heroes[0].xPosition += 5
                
                
                monsters[0].xPosition -= 5
                
                effectImage = heroes[0].attackEffect.reverseImage
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    _effect = LoseEffect()
                    monsterImage = monsters[0].progressImage(2)
                }
                else
                {
                    monsterImage = monsters[0].progressImage(1)
                }
            case 6:
                monsters[0].xPosition += 5
                
                effectImage = heroes[0].attackEffect.reverseImage
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    monsterImage = monsters[0].progressImage(3)
                }
                break
            case 7:
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    monsterImage = monsters[0].progressImage(4)
                }
                break
            case 8 :
                isMonsterTurn = true
                heroes[0].attackProgress = 0
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    monsterImage = monsters[0].progressImage(5)
                }
                break
            default :
                heroes[0].xPosition += 0
                heroImage = heroes[0].progressImage(0)
                break
            }
        }
        
        var effectPoint:CGPoint = CGPointMake(0, 0)
        if (isMonsterTurn == true)
        {
            effectPoint = monsters[0].attackEffect.point
        }
        else
        {
            effectPoint = heroes[0].attackEffect.point
        }
        
        //ヒーロー画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: heroImage, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        
        //モンスター画像
        image = DrawUtil.synthesizeImage(image, synthImage: monsterImage, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        //エフェクト
        image = DrawUtil.synthesizeImage(image, synthImage: effectImage, x: effectPoint.x, y: effectPoint.y)
        
        return image
    }
    
    //ヒーロー全滅時処理
    internal func playWin() -> UIImage
    {
        var monsterImage:UIImage = monsters[0].image
        var effectImage:UIImage = _effect.image
        
        //モンスター画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: monsterImage, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        //エフェクト
        image = DrawUtil.synthesizeImage(image, synthImage: effectImage, x: 28, y: 1)
        
        return image
    }
    
    //モンスター全滅時処理
    internal func playLose()
    {
        
    }
}