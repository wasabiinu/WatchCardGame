//
//  GameMainSceneController.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/03.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import WatchKit
import Foundation


class GameMainSceneController: WKInterfaceController {
    
    @IBOutlet weak var MonsterLeftHpBar: WKInterfaceImage!
    @IBOutlet weak var MonsterRightHpBar: WKInterfaceImage!
    @IBOutlet weak var HeroLeftHpBar: WKInterfaceImage!
    @IBOutlet weak var Floor1Content: WKInterfaceImage!
    @IBOutlet weak var HeroRightHpBar: WKInterfaceImage!
    
    private var _turnTimer:NSTimer!
    private var _manageHpTimer:NSTimer!
    private var _floor1Manager:FloorManager!
    override init()
    {
        println("init")
    }
    
    deinit
    {
        
        _turnTimer = nil
        println("deinit")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        var floorManagerArray:[FloorManager] = context as! [FloorManager]
        
        var hero:Hero = Warrior()
        var hero2:Hero = Warrior()
        hero2.xPosition += 20
        var monster:Monster = Slime()
        var monster2:Monster = Bat()
        monster2.xPosition -= 20
        _floor1Manager = floorManagerArray[0]
        _floor1Manager.heroes.append(hero)
        _floor1Manager.heroes.append(hero2)
        _floor1Manager.monsters.append(monster)
        _floor1Manager.monsters.append(monster2)
        
        
        println("awakeWithContext")
    }
    
    override func willActivate() {
        super.willActivate()
        _manageHpTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.25), target: self, selector: Selector("manageHp:"), userInfo: nil, repeats: true)
        stockMethods()
        println("willActivate")
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        _turnTimer.invalidate()
        println("didDeactivate")
    }
    
    internal func stockMethods()
    {
        println("stockMethods")
        var animationArray:[UIImage] = [UIImage]()
        var count:Int = 0
        var interval:NSTimeInterval = 0
        var play1TurnArray:[AnyObject] = [AnyObject]()
        
        if (_floor1Manager.heroes[0].xPosition > 71 && _floor1Manager.isBattle == false)
        {
            while (_floor1Manager.heroes[0].xPosition > 71 || _floor1Manager.isBattle == true)
            {
                animationArray.append(_floor1Manager.enterFloor())
                count++
            }
        }
        else if (_floor1Manager.battleStartProgress < 8)
        {
            while (_floor1Manager.battleStartProgress < 8 )
            {
                animationArray.append(_floor1Manager.battleStart())
                count++
            }
        }
        
        else if (isPlay1Turn())
        {
            
            if (_floor1Manager.monsters[0].attackProgress <= 9 && _floor1Manager.isMonsterTurn == true && _floor1Manager.monsters[0].hp > 0)
            {
                while (_floor1Manager.monsters[0].attackProgress <= 9 && _floor1Manager.isMonsterTurn == true && _floor1Manager.monsters[0].hp > 0)
                {
                    play1TurnArray = _floor1Manager.play1Turn()
                    animationArray.append(play1TurnArray[0] as! UIImage)
                    count++
                }
            }
            else if(_floor1Manager.monsters.count >= 2 && _floor1Manager.monsters[1].attackProgress <= 9 && _floor1Manager.isMonsterTurn == true && _floor1Manager.monsters[1].hp > 0)
            {
                while (_floor1Manager.monsters.count >= 2 && _floor1Manager.monsters[1].attackProgress <= 9 && _floor1Manager.isMonsterTurn == true && _floor1Manager.monsters[1].hp > 0)
                {
                    play1TurnArray = _floor1Manager.play1Turn()
                    animationArray.append(play1TurnArray[0] as! UIImage)
                    count++
                }
            }
            else if (_floor1Manager.heroes[0].attackProgress <= 9 && _floor1Manager.isMonsterTurn == false && _floor1Manager.heroes[0].hp > 0)
            {
                while (_floor1Manager.heroes[0].attackProgress <= 9 && _floor1Manager.isMonsterTurn == false && _floor1Manager.heroes[0].hp > 0)
                {
                    play1TurnArray = _floor1Manager.play1Turn()
                    animationArray.append(play1TurnArray[0] as! UIImage)
                    count++
                }
            }
            else if (_floor1Manager.heroes[1].attackProgress <= 9 && _floor1Manager.isMonsterTurn == false && _floor1Manager.heroes[1].hp > 0)
            {
                while (_floor1Manager.heroes.count >= 2 && _floor1Manager.heroes[1].attackProgress <= 9 && _floor1Manager.isMonsterTurn == false && _floor1Manager.heroes[1].hp > 0)
                {
                    play1TurnArray = _floor1Manager.play1Turn()
                    animationArray.append(play1TurnArray[0] as! UIImage)
                    count++
                }
            }
        }
            //ヒーローのHPが0かつ、進捗が0の場合　または、モンスターのHPが0かつ、進捗が0の場合　下に抜ける
            
        else if (_floor1Manager.heroes[0].hp <= 0 && (_floor1Manager.heroes.count < 2 || (_floor1Manager.heroes.count >= 2 && _floor1Manager.heroes[1].hp <= 0)))
        {
            //ヒーローが負けた場合の処理
            if (_floor1Manager.winEffect.progress < 8)
            {
                //勝利演出
                while (_floor1Manager.winEffect.progress < 8)
                {
                    animationArray.append(_floor1Manager.playWin())
                    count++
                }
            }
            else
            {
                //次のヒーロー登場演出
                animationArray.append(_floor1Manager.summonNextHero())
                _floor1Manager.heroes.append(Warrior())
                count++
            }
        }
        else if (_floor1Manager.monsters[0].hp <= 0)
        {
            //モンスターが負けた場合の処理
            //負け演出
            if (_floor1Manager.loseEffect.progress < 8)
            {
                while (_floor1Manager.loseEffect.progress < 8)
                {
                    animationArray.append(_floor1Manager.playLose())
                    count++
                }
            }
            else
            {
                //次のフロアまで歩く
                animationArray.append(_floor1Manager.enterFloor())
                count++
            }
        }
        else
        {
            println("super exception")
        }
        
        if ( count > 0)
        {
            var setImage:UIImage = UIImage.animatedImageWithImages(animationArray, duration: 1)
            var range:NSRange = NSMakeRange(0, count)
            
            
            if (play1TurnArray.count >= 2)
            {
                //キャッシュ処理
                var cacheName:String = play1TurnArray[1] as! String
                
                if (Config.DEVICE.cachedImages[cacheName] != nil)
                {
                    Floor1Content.setImageNamed(cacheName)
                }
                else
                {
                    //Config.DEVICE.removeCachedImageWithName(cacheName)
                    Config.DEVICE.addCachedImage(setImage, name: cacheName)
                    Floor1Content.setImage(setImage)
                }
            }
            else
            {
                Floor1Content.setImage(setImage)
            }
            
            interval = NSTimeInterval(Double(count + 1) * 0.25)
            Floor1Content.startAnimatingWithImagesInRange(range, duration: interval, repeatCount: 1)
        }
        else
        {
            interval = 0.25
        }
        
        
        println("interval: \(interval)")
        if (interval > 0)
        {
            _turnTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("onTurn:"), userInfo: nil, repeats: false)
        }
    }
    
    internal func onTurn(timer:NSTimer)
    {
        stockMethods()
    }
    
    //処理が複雑なので別メソッド化
    private func isPlay1Turn() -> Bool
    {
        return !(
            (
                //生き残っているヒーローがいなかったらtrue
                (_floor1Manager.heroes[0].hp <= 0 && (_floor1Manager.monsters[0].attackProgress == 0 || _floor1Manager.monsters[1].attackProgress == 0))
                    &&
                    (
                        _floor1Manager.heroes.count < 2
                            ||
                            (_floor1Manager.heroes.count >= 2 && _floor1Manager.heroes[1].hp <= 0 &&
                                (_floor1Manager.monsters[0].attackProgress == 0 || _floor1Manager.monsters[1].attackProgress == 0)
                        )
                )
                )
                ||
                (
                    //モンスター0とモンスター１が死んだらtrue
                    (
                        (_floor1Manager.monsters[0].hp <= 0 && _floor1Manager.heroes[0].attackProgress == 0)
                            &&
                            (
                                _floor1Manager.heroes.count < 2
                                    ||
                                    (_floor1Manager.heroes.count >= 2 && _floor1Manager.monsters[0].hp <= 0 && _floor1Manager.heroes[1].attackProgress == 0)
                        )
                        )
                        &&
                        (
                            (_floor1Manager.monsters[1].hp <= 0 && _floor1Manager.heroes[0].attackProgress == 0)
                                &&
                                (
                                    _floor1Manager.heroes.count < 2
                                        ||
                                        (_floor1Manager.heroes.count >= 2 && _floor1Manager.monsters[1].hp <= 0 && _floor1Manager.heroes[1].attackProgress == 0)
                            )
                    )
            )
        )
    }
    
    //処理が軽いのでHPバーを監視して常に更新する
    internal func manageHp(timer:NSTimer)
    {
        var monsterRightHp:Int = Int(Float(_floor1Manager.monsters[0].hp) / Float(_floor1Manager.monsters[0].maxHp) * 30.0)
        
        var monsterLeftHp:Int = Int(Float(_floor1Manager.monsters[1].hp) / Float(_floor1Manager.monsters[1].maxHp) * 30.0)
        
        var heroesLeftHp:Int = Int(Float(_floor1Manager.heroes[0].hp) / Float(_floor1Manager.heroes[0].maxHp) * 30.0)
        
        var heroesRightHp:Int = 0
        
        if (_floor1Manager.heroes.count >= 2)
        {
            heroesRightHp = Int(Float(_floor1Manager.heroes[1].hp) / Float(_floor1Manager.heroes[0].maxHp) * 30.0)
        }
        
        //println(heroesLeftHp)
        
        if (monsterLeftHp < 0)
        {
            monsterLeftHp = 0
        }
        
        if (monsterRightHp < 0)
        {
            monsterRightHp = 0
        }
        
        if (heroesLeftHp < 0)
        {
            heroesLeftHp = 0
        }
        
        if (heroesRightHp < 0)
        {
            heroesRightHp = 0
        }
        
        //println("MonsterRightHpBar:\(monsterRightHp), heroesLeftHp:\(heroesLeftHp)")
        
        //hp3.pngだけ、hp30.pngが読み込まれてしまうバグの対応が必要
        if (monsterRightHp <= 0 || monsterRightHp > 3)
        {
            MonsterRightHpBar.setImageNamed("hp\(monsterRightHp).png")
        }
        else
        {
            MonsterRightHpBar.setImageNamed("_hp\(monsterRightHp).png")
        }
        
        if (monsterLeftHp <= 0 || monsterLeftHp > 3)
        {
            MonsterLeftHpBar.setImageNamed("hp\(monsterLeftHp).png")
        }
        else
        {
            MonsterLeftHpBar.setImageNamed("_hp\(monsterLeftHp).png")
        }
        
        if (heroesLeftHp <= 0 || heroesLeftHp > 3)
        {
            HeroLeftHpBar.setImageNamed("hp\(heroesLeftHp).png")
        }
        else
        {
            HeroLeftHpBar.setImageNamed("_hp\(heroesLeftHp).png")
        }
        
        if (heroesRightHp <= 0 || heroesRightHp > 3)
        {
            HeroRightHpBar.setImageNamed("hp\(heroesRightHp).png")
        }
        else
        {
            HeroRightHpBar.setImageNamed("_hp\(heroesRightHp).png")
        }
        
    }
}