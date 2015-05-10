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
    
    @IBOutlet weak var Floor2Content: WKInterfaceImage!
    @IBOutlet weak var MonsterLeftHpBar2: WKInterfaceImage!
    @IBOutlet weak var MonsterRightHpBar2: WKInterfaceImage!
    @IBOutlet weak var HeroLeftHpBar2: WKInterfaceImage!
    @IBOutlet weak var HeroRightHpBar2: WKInterfaceImage!
    
    @IBOutlet weak var Floor3Content: WKInterfaceImage!
    @IBOutlet weak var MonsterLeftHpBar3: WKInterfaceImage!
    @IBOutlet weak var MonsterRightHpBar3: WKInterfaceImage!
    @IBOutlet weak var HeroLeftHpBar3: WKInterfaceImage!
    @IBOutlet weak var HeroRightHpBar3: WKInterfaceImage!
    
    @IBOutlet weak var Floor4Content: WKInterfaceImage!
    @IBOutlet weak var MonsterLeftHpBar4: WKInterfaceImage!
    @IBOutlet weak var MonsterRightHpBar4: WKInterfaceImage!
    @IBOutlet weak var HeroLeftHpBar4: WKInterfaceImage!
    @IBOutlet weak var HeroRightHpBar4: WKInterfaceImage!
    
    //private var _turnTimer:NSTimer!
    private var _manageHpTimer:NSTimer!
    private var _floor1Manager:FloorManager!
    private var _floor2Manager:FloorManager!
    private var _floor3Manager:FloorManager!
    private var _floor4Manager:FloorManager!
    
    override init()
    {
        println("init")
    }
    
    deinit
    {
        
        _floor1Manager.turnTimer = nil
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
        _floor1Manager.scene = Floor1Content
        _floor1Manager.heroes.append(hero)
        _floor1Manager.heroes.append(hero2)
        _floor1Manager.monsters.append(monster)
        _floor1Manager.monsters.append(monster2)
        
        
        
        var hero_2:Hero = Warrior()
        var monster_2:Monster = Slime()
        var monster2_2:Monster = Bat()
        monster2_2.xPosition -= 20
        _floor2Manager = floorManagerArray[1]
        _floor2Manager.scene = Floor2Content
        _floor2Manager.monsters.append(monster_2)
        _floor2Manager.monsters.append(monster2_2)
        
        
        
        var hero_3:Hero = Warrior()
        var monster_3:Monster = Slime()
        var monster2_3:Monster = Bat()
        monster2_3.xPosition -= 20
        _floor3Manager = floorManagerArray[2]
        _floor3Manager.scene = Floor3Content
        _floor3Manager.monsters.append(monster_3)
        _floor3Manager.monsters.append(monster2_3)
        
        
        
        var hero_4:Hero = Warrior()
        var monster_4:Monster = Slime()
        var monster2_4:Monster = Bat()
        monster2_4.xPosition -= 20
        _floor4Manager = floorManagerArray[3]
        _floor4Manager.scene = Floor4Content
        _floor4Manager.monsters.append(monster_4)
        _floor4Manager.monsters.append(monster2_4)
        
        _floor1Manager.nextFloor = _floor2Manager
        _floor2Manager.nextFloor = _floor3Manager
        _floor3Manager.nextFloor = _floor4Manager
        
        
        println("awakeWithContext")
    }
    
    override func willActivate() {
        super.willActivate()
        _manageHpTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.25), target: self, selector: Selector("manageHp:"), userInfo: nil, repeats: true)
        stockMethods(_floor1Manager)
        stockMethods(_floor2Manager)
        stockMethods(_floor3Manager)
        stockMethods(_floor4Manager)
        println("willActivate")
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        if (_floor1Manager.turnTimer != nil)
        {
            _floor1Manager.turnTimer.invalidate()
        }
        if (_floor2Manager.turnTimer != nil)
        {
            _floor2Manager.turnTimer.invalidate()
        }
        if (_floor3Manager.turnTimer != nil)
        {
            _floor3Manager.turnTimer.invalidate()
        }
        if (_floor4Manager.turnTimer != nil)
        {
            _floor4Manager.turnTimer.invalidate()
        }
        println("didDeactivate")
    }
    
    internal func stockMethods(currentFloorManager:FloorManager)
    {
        //println("stockMethods")
        var animationArray:[UIImage] = [UIImage]()
        var count:Int = 0
        var interval:NSTimeInterval = 0
        var play1TurnArray:[AnyObject] = [AnyObject]()
        
        if (currentFloorManager.heroes.count >= 1 && currentFloorManager.heroes[0].xPosition > 71 && currentFloorManager.isBattle == false)
        {
            if (currentFloorManager === _floor2Manager)
            {
                println("enterFloor")
            }
            while (currentFloorManager.heroes[0].xPosition > 71 || currentFloorManager.isBattle == true)
            {
                //println("enterFloor: loop")
                animationArray.append(currentFloorManager.enterFloor())
                count++
            }
        }
        else if (currentFloorManager.heroes.count >= 1 && currentFloorManager.battleStartProgress < 8)
        {
            while (currentFloorManager.battleStartProgress < 8 )
            {
                animationArray.append(currentFloorManager.battleStart())
                count++
            }
        }
        
        else if (currentFloorManager.monsters.count >= 1 && currentFloorManager.heroes.count >= 1 && isPlay1Turn(currentFloorManager))
        {
            
            if (currentFloorManager.monsters[0].attackProgress <= 9 && currentFloorManager.isMonsterTurn == true && currentFloorManager.monsters[0].hp > 0)
            {
                while (currentFloorManager.monsters[0].attackProgress <= 9 && currentFloorManager.isMonsterTurn == true && currentFloorManager.monsters[0].hp > 0)
                {
                    play1TurnArray = currentFloorManager.play1Turn()
                    animationArray.append(play1TurnArray[0] as! UIImage)
                    count++
                }
            }
            else if(currentFloorManager.monsters.count >= 2 && currentFloorManager.monsters[1].attackProgress <= 9 && currentFloorManager.isMonsterTurn == true && currentFloorManager.monsters[1].hp > 0)
            {
                while (currentFloorManager.monsters.count >= 2 && currentFloorManager.monsters[1].attackProgress <= 9 && currentFloorManager.isMonsterTurn == true && currentFloorManager.monsters[1].hp > 0)
                {
                    play1TurnArray = currentFloorManager.play1Turn()
                    animationArray.append(play1TurnArray[0] as! UIImage)
                    count++
                }
            }
            else if (currentFloorManager.heroes[0].attackProgress <= 9 && currentFloorManager.isMonsterTurn == false && currentFloorManager.heroes[0].hp > 0)
            {
                while (currentFloorManager.heroes[0].attackProgress <= 9 && currentFloorManager.isMonsterTurn == false && currentFloorManager.heroes[0].hp > 0)
                {
                    play1TurnArray = currentFloorManager.play1Turn()
                    animationArray.append(play1TurnArray[0] as! UIImage)
                    count++
                }
            }
            else if (currentFloorManager.heroes[1].attackProgress <= 9 && currentFloorManager.isMonsterTurn == false && currentFloorManager.heroes[1].hp > 0)
            {
                while (currentFloorManager.heroes.count >= 2 && currentFloorManager.heroes[1].attackProgress <= 9 && currentFloorManager.isMonsterTurn == false && currentFloorManager.heroes[1].hp > 0)
                {
                    play1TurnArray = currentFloorManager.play1Turn()
                    animationArray.append(play1TurnArray[0] as! UIImage)
                    count++
                }
            }
        }
            //ヒーローのHPが0かつ、進捗が0の場合　または、モンスターのHPが0かつ、進捗が0の場合　下に抜ける
            
        else if (currentFloorManager.monsters.count >= 1 && currentFloorManager.heroes.count >= 1 && currentFloorManager.heroes[0].hp <= 0 && (currentFloorManager.heroes.count < 2 || (currentFloorManager.heroes.count >= 2 && currentFloorManager.heroes[1].hp <= 0)))
        {
            //ヒーローが負けた場合の処理
            if (currentFloorManager.winEffect.progress < 8)
            {
                //勝利演出
                while (currentFloorManager.winEffect.progress < 8)
                {
                    animationArray.append(currentFloorManager.playWin())
                    count++
                }
            }
            else
            {
                //次のヒーロー登場演出
                animationArray.append(currentFloorManager.summonNextHero())
                currentFloorManager.heroes.append(Warrior())
                count++
            }
        }
        else if (currentFloorManager.monsters.count >= 1 && currentFloorManager.heroes.count >= 1 && currentFloorManager.monsters[0].hp <= 0)
        {
            //モンスターが負けた場合の処理
            //負け演出
            if (currentFloorManager.loseEffect.progress < 8)
            {
                while (currentFloorManager.loseEffect.progress < 8)
                {
                    animationArray.append(currentFloorManager.playLose())
                    count++
                }
            }
            else
            {
                //次のフロアまで歩く
                while (
                (currentFloorManager.heroes[0].hp > 0 && currentFloorManager.heroes[0].xPosition > -30)
                    ||
                (currentFloorManager.heroes.count >= 2 && currentFloorManager.heroes[1].hp > 0 && currentFloorManager.heroes[1].xPosition > -30)
                )
                {
                    animationArray.append(currentFloorManager.enterFloor())
                    count++
                }
                
            }
        }
        else
        {
            play1TurnArray = currentFloorManager.play1Turn()
            animationArray.append(play1TurnArray[0] as! UIImage)
            count++
            //println("super exception")
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
                    currentFloorManager.scene.setImageNamed(cacheName)
                }
                else
                {
                    //Config.DEVICE.removeCachedImageWithName(cacheName)
                    Config.DEVICE.addCachedImage(setImage, name: cacheName)
                    currentFloorManager.scene.setImage(setImage)
                }
            }
            else
            {
                currentFloorManager.scene.setImage(setImage)
            }
            
            interval = NSTimeInterval(Double(count + 1) * 0.25)
            currentFloorManager.scene.startAnimatingWithImagesInRange(range, duration: interval, repeatCount: 1)
        }
        else
        {
            interval = 0.25
        }
        
        
        //println("interval: \(interval)")
        if (interval > 0)
        {
            if (currentFloorManager === _floor2Manager)
            {
                println("_floor2Manager, interval:\(interval)")
            }
            currentFloorManager.turnTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("onTurn:"), userInfo: currentFloorManager, repeats: false)
            //NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("onTurn:"), userInfo: currentFloorManager, repeats: false)
        }
    }
    
    internal func onTurn(timer:NSTimer)
    {
        var currentFloorManager = timer.userInfo as! FloorManager
        
        if (
            (currentFloorManager.heroes.count >= 1 && currentFloorManager.heroes[0].hp > 0 && currentFloorManager.heroes[0].xPosition <= -30)
            ||
            (currentFloorManager.heroes.count >= 2 && currentFloorManager.heroes[1].hp > 0 && currentFloorManager.heroes[1].xPosition <= -30)
        )
        {
            currentFloorManager.jumpToNextFloor()
        }
        
        stockMethods(currentFloorManager)
    }
    
    //処理が複雑なので別メソッド化
    private func isPlay1Turn(currentFloorManager:FloorManager) -> Bool
    {
        return !(
            (
                //生き残っているヒーローがいなかったらtrue
                (currentFloorManager.heroes[0].hp <= 0 && (currentFloorManager.monsters[0].attackProgress == 0 || currentFloorManager.monsters[1].attackProgress == 0))
                    &&
                    (
                        currentFloorManager.heroes.count < 2
                            ||
                            (currentFloorManager.heroes.count >= 2 && currentFloorManager.heroes[1].hp <= 0 &&
                                (currentFloorManager.monsters[0].attackProgress == 0 || currentFloorManager.monsters[1].attackProgress == 0)
                        )
                )
                )
                ||
                (
                    //モンスター0とモンスター１が死んだらtrue
                    (
                        (currentFloorManager.monsters[0].hp <= 0 && currentFloorManager.heroes[0].attackProgress == 0)
                            &&
                            (
                                currentFloorManager.heroes.count < 2
                                    ||
                                    (currentFloorManager.heroes.count >= 2 && currentFloorManager.monsters[0].hp <= 0 && currentFloorManager.heroes[1].attackProgress == 0)
                        )
                        )
                        &&
                        (
                            (currentFloorManager.monsters[1].hp <= 0 && currentFloorManager.heroes[0].attackProgress == 0)
                                &&
                                (
                                    currentFloorManager.heroes.count < 2
                                        ||
                                        (currentFloorManager.heroes.count >= 2 && currentFloorManager.monsters[1].hp <= 0 && currentFloorManager.heroes[1].attackProgress == 0)
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