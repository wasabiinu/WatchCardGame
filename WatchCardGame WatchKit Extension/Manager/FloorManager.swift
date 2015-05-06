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
    internal var winEffect:Effect!
    internal var loseEffect:Effect!
    internal var isBattle:Bool
    private var _alphaImage:UIImage = UIImage(named: "floor_origin.png")!
    private var _effectImage:UIImage!
    private var _heroImage1:UIImage!
    private var _heroImage2:UIImage!
    private var _monsterImage:UIImage!
    
    init()
    {
        heroes = [Hero]()
        monsters = [Monster]()
        battleStartProgress = 0
        isMonsterTurn = true
        isBattle = false
    }
    
    internal func reset()
    {
        heroes = [Hero]()
        monsters = [Monster]()
        battleStartProgress = 0
        isMonsterTurn = true
        isBattle = false
    }
    
    internal func enterFloor() -> UIImage
    {
        
        //ヒーロー画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: heroes[0].image, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        if (heroes.count >= 2)
        {
            //ヒーロー画像２
            image = DrawUtil.synthesizeImage(image, synthImage: heroes[1].image, x: CGFloat(heroes[1].xPosition), y: CGFloat(heroes[1].yPosition))
        }
        
        if (monsters[0].hp > 0)
        {
            //モンスター画像
            image = DrawUtil.synthesizeImage(image, synthImage: monsters[0].image, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        }
        
        heroes[0].xPosition -= 5
        if (heroes.count >= 2)
        {
            heroes[1].xPosition -= 5
        }
        
        return image
    }
    
    internal func battleStart() -> UIImage
    {
        
        //ヒーロー画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: heroes[0].stopImage, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        //ヒーロー画像２
        if (heroes.count >= 2)
        {
            image = DrawUtil.synthesizeImage(image, synthImage: heroes[1].stopImage, x: CGFloat(heroes[1].xPosition), y: CGFloat(heroes[1].yPosition))
        }
        
        //モンスター画像
        image = DrawUtil.synthesizeImage(image, synthImage: monsters[0].image, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        //バトルスタート演出画像
        image = DrawUtil.synthesizeImage(image, synthImage: UIImage(named: "battlestart\(battleStartProgress).png")!, x: 25.0, y: 5.0)
        battleStartProgress++
        
        return image
    }
    
    internal func play1Turn() -> UIImage
    {
        isBattle = true
        _heroImage1 = heroes[0].stopImage
        if (heroes.count >= 2)
        {
            _heroImage2 = heroes[1].stopImage
        }
        _monsterImage = monsters[0].image
        _effectImage = UIImage(named: "floor_origin.png")!
        
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
                //ヒットした瞬間
                monsters[0].xPosition += 10
                
                monsters[0].attackEffect.progress = 0
                monsters[0].attackEffect.point.x = CGFloat(heroes[0].xPosition)
                monsters[0].attackEffect.point.y = CGFloat(heroes[0].yPosition)
                
                _effectImage = monsters[0].attackEffect.image
                
                //ヒーローのHPを削る
                heroes[0].hp -= 1
                break
            case 4:
                //ヒットした瞬間
                monsters[0].xPosition += 0
                _effectImage = monsters[0].attackEffect.image
                break
            case 5:
                
                
                monsters[0].xPosition -= 5
                heroes[0].xPosition += 5
                
                _effectImage = monsters[0].attackEffect.image
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    winEffect = WinEffect()
                    _heroImage1 = heroes[0].progressImage(5)
                }
                else
                {
                    _heroImage1 = heroes[0].progressImage(4)
                }
                
                break
            case 6:
                
                heroes[0].xPosition -= 5
                
                
                _effectImage = monsters[0].attackEffect.image
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    _heroImage1 = heroes[0].progressImage(6)
                }
                break
            case 7:
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    _heroImage1 = heroes[0].progressImage(7)
                }
                break
            case 8:
                
                
                //死亡時
                if (heroes[0].hp <= 0)
                {
                    _heroImage1 = heroes[0].progressImage(8)
                }
                break
            default :
                monsters[0].xPosition += 0
                
                break
            }
            
            if (monsters[0].attackProgress == 8)
            {
                //2匹目のモンスターがいない、又は、2匹目のモンスターが死亡している場合、ターンエンド
                if ((monsters.count >= 2 && monsters[1].hp <= 0)
                    || monsters.count < 2)
                {
                    isMonsterTurn = false
                    monsters[0].attackProgress = 0
                }
            }
            
        }
        else
        {
            if (heroes[1].attackProgress == 9)
            {
                isMonsterTurn = true
                heroes[0].attackProgress = 0
                heroes[1].attackProgress = 0
            }
            
            if (heroes[0].attackProgress == 9)
            {
                //2人目のヒーローがいない、又は、2人目のヒーローが死亡している場合、ターンエンド
                if ((heroes.count >= 2 && heroes[1].hp <= 0)
                    || heroes.count < 2)
                {
                    isMonsterTurn = true
                    heroes[0].attackProgress = 0
                }
                //2人目のヒーローの処理
                else
                {
                    secondHeroProgress()
                }
            }
                //１人目のヒーロー処理
            else
            {
                firstHeroProgress()
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
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: _heroImage1, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        
        if (heroes.count >= 2)
        {
            //ヒーロー2人目画像
            image = DrawUtil.synthesizeImage(image, synthImage: _heroImage2, x: CGFloat(heroes[1].xPosition), y: CGFloat(heroes[1].yPosition))
        }
        
        //モンスター画像
        image = DrawUtil.synthesizeImage(image, synthImage: _monsterImage, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        //エフェクト
        image = DrawUtil.synthesizeImage(image, synthImage: _effectImage, x: effectPoint.x, y: effectPoint.y)
        
        return image
    }
    
    //1人目のヒーロー処理
    private func firstHeroProgress()
    {
        //ヒーローのターン処理を書く
        heroes[0].attackProgress++
        println("heroes[0].attackProgress:\(heroes[0].attackProgress)")
        
        switch heroes[0].attackProgress
        {
        case 1:
            heroes[0].xPosition += 5
            _heroImage1 = heroes[0].progressImage(1)
            break
        case 3:
            //ヒットした瞬間
            heroes[0].xPosition -= 10
            _heroImage1 = heroes[0].progressImage(2)
            _heroImage1 = heroes[0].attackImage
            
            heroes[0].attackEffect.progress = 0
            heroes[0].attackEffect.point.x = CGFloat(monsters[0].xPosition)
            heroes[0].attackEffect.point.y = CGFloat(monsters[0].yPosition)
            
            _effectImage = heroes[0].attackEffect.reverseImage
            
            //モンスターのHPを削る
            monsters[0].hp -= 5
            break
        case 4:
            //ヒットした瞬間
            heroes[0].xPosition += 0
            _heroImage1 = heroes[0].attackImage
            
            _effectImage = heroes[0].attackEffect.reverseImage
            break
        case 5:
            heroes[0].xPosition += 5
            
            
            monsters[0].xPosition -= 5
            
            _effectImage = heroes[0].attackEffect.reverseImage
            
            //死亡時
            if (monsters[0].hp <= 0)
            {
                loseEffect = LoseEffect()
                _monsterImage = monsters[0].progressImage(2)
            }
            else
            {
                _monsterImage = monsters[0].progressImage(1)
            }
        case 6:
            monsters[0].xPosition += 5
            
            _effectImage = heroes[0].attackEffect.reverseImage
            
            //死亡時
            if (monsters[0].hp <= 0)
            {
                _monsterImage = monsters[0].progressImage(3)
            }
            break
        case 7:
            //死亡時
            if (monsters[0].hp <= 0)
            {
                _monsterImage = monsters[0].progressImage(4)
            }
            break
        case 8 :
            heroes[0].attackProgress = 9
            
            //死亡時
            if (monsters[0].hp <= 0)
            {
                _monsterImage = monsters[0].progressImage(5)
            }
            break
        default :
            heroes[0].xPosition += 0
            _heroImage1 = heroes[0].progressImage(0)
            break
        }
    }
    
    //2人目のヒーロー処理
    private func secondHeroProgress()
    {
        //ヒーローのターン処理を書く
        heroes[1].attackProgress++
        
        println("heroes[1].attackProgress: \(heroes[1].attackProgress)")
        
        switch heroes[1].attackProgress
        {
        case 1:
            heroes[1].xPosition += 5
            _heroImage2 = heroes[1].progressImage(1)
            break
        case 3:
            //ヒットした瞬間
            heroes[1].xPosition -= 10
            _heroImage2 = heroes[1].progressImage(2)
            _heroImage2 = heroes[1].attackImage
            
            heroes[1].attackEffect.progress = 0
            heroes[1].attackEffect.point.x = CGFloat(monsters[0].xPosition)
            heroes[1].attackEffect.point.y = CGFloat(monsters[0].yPosition)
            
            _effectImage = heroes[1].attackEffect.reverseImage
            
            //モンスターのHPを削る
            monsters[0].hp -= 5
            break
        case 4:
            //ヒットした瞬間
            heroes[1].xPosition += 0
            _heroImage2 = heroes[1].attackImage
            
            _effectImage = heroes[1].attackEffect.reverseImage
            break
        case 5:
            heroes[1].xPosition += 5
            
            
            monsters[0].xPosition -= 5
            
            _effectImage = heroes[1].attackEffect.reverseImage
            
            //死亡時
            if (monsters[0].hp <= 0)
            {
                loseEffect = LoseEffect()
                _monsterImage = monsters[0].progressImage(2)
            }
            else
            {
                _monsterImage = monsters[0].progressImage(1)
            }
        case 6:
            monsters[0].xPosition += 5
            
            _effectImage = heroes[1].attackEffect.reverseImage
            
            //死亡時
            if (monsters[0].hp <= 0)
            {
                _monsterImage = monsters[0].progressImage(3)
            }
            break
        case 7:
            //死亡時
            if (monsters[0].hp <= 0)
            {
                _monsterImage = monsters[0].progressImage(4)
            }
            break
        case 8 :
            heroes[1].attackProgress = 9
            
            //死亡時
            if (monsters[0].hp <= 0)
            {
                _monsterImage = monsters[0].progressImage(5)
            }
            break
        default :
            heroes[1].xPosition += 0
            _heroImage2 = heroes[1].progressImage(0)
            break
        }
    }
    
    //ヒーロー全滅時処理
    internal func playWin() -> UIImage
    {
        isBattle = false
        var _monsterImage:UIImage = monsters[0].image
        _effectImage = winEffect.image
        
        //モンスター画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: _monsterImage, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        //エフェクト
        image = DrawUtil.synthesizeImage(image, synthImage: _effectImage, x: 28, y: 1)
        
        return image
    }
    
    //モンスター全滅時処理
    internal func playLose() -> UIImage
    {
        isBattle = false
        var _heroImage:UIImage = heroes[0].image
        var _effectImage:UIImage = loseEffect.image
        
        //モンスター画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: _heroImage, x: CGFloat(heroes[0].xPosition), y: CGFloat(heroes[0].yPosition))
        
        //エフェクト
        image = DrawUtil.synthesizeImage(image, synthImage: _effectImage, x: 28, y: 1)
        
        return image
    }
    
    //次のヒーローを呼ぶ
    internal func summonNextHero() -> UIImage
    {
        var _monsterImage:UIImage = monsters[0].image
        
        //モンスター画像
        var image:UIImage = DrawUtil.synthesizeImage(_alphaImage, synthImage: _monsterImage, x: CGFloat(monsters[0].xPosition), y: CGFloat(monsters[0].yPosition))
        
        heroes = [Hero]()
        battleStartProgress = 0
        isMonsterTurn = true
        
        return image
    }
}