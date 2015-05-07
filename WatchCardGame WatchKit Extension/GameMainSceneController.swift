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
    
    @IBOutlet weak var MonsterRightHpBar: WKInterfaceImage!
    @IBOutlet weak var HeroLeftHpBar: WKInterfaceImage!
    @IBOutlet weak var Floor1Content: WKInterfaceImage!
    @IBOutlet weak var HeroRightHpBar: WKInterfaceImage!
    
    private var _turnTimer:NSTimer!
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
        _floor1Manager = floorManagerArray[0]
        _floor1Manager.heroes.append(hero)
        _floor1Manager.heroes.append(hero2)
        _floor1Manager.monsters.append(monster)
        
        
        println("awakeWithContext")
    }
    
    override func willActivate() {
        super.willActivate()
        _turnTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.25), target: self, selector: Selector("onTimer:"), userInfo: nil, repeats: true)
        println("willActivate")
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        _turnTimer.invalidate()
        println("didDeactivate")
    }
    
    internal func onTimer(timer:NSTimer)
    {

        if (_floor1Manager.heroes[0].xPosition > 71 && _floor1Manager.isBattle == false)
        {
            Floor1Content.setImage(_floor1Manager.enterFloor())
        }
        else if (_floor1Manager.battleStartProgress < 8)
        {
            Floor1Content.setImage(_floor1Manager.battleStart())
        }
        else if (
            !(
                (
                    //生き残っているヒーローがいなかったらtrue
                    (_floor1Manager.heroes[0].hp <= 0 && _floor1Manager.monsters[0].attackProgress == 0)
                    &&
                    (
                        _floor1Manager.heroes.count < 2
                        ||
                        (_floor1Manager.heroes.count >= 2 && _floor1Manager.heroes[1].hp <= 0 && _floor1Manager.monsters[0].attackProgress == 0)
                    )
                )
                ||
                (
                    //モンスター0が死んだらtrue
                    (_floor1Manager.monsters[0].hp <= 0 && _floor1Manager.heroes[0].attackProgress == 0)
                    &&
                    (
                        _floor1Manager.heroes.count < 2
                        ||
                        (_floor1Manager.heroes.count >= 2 && _floor1Manager.monsters[0].hp <= 0 && _floor1Manager.heroes[1].attackProgress == 0)
                    )
                )
            )
        )
        {
            Floor1Content.setImage(_floor1Manager.play1Turn())
        }
        //ヒーローのHPが0かつ、進捗が0の場合　または、モンスターのHPが0かつ、進捗が0の場合　下に抜ける
        
        else if (_floor1Manager.heroes[0].hp <= 0 && (_floor1Manager.heroes.count < 2 || (_floor1Manager.heroes.count >= 2 && _floor1Manager.heroes[1].hp <= 0)))
        {
            //ヒーローが負けた場合の処理
            if (_floor1Manager.winEffect.progress < 8)
            {
                //勝利演出
                Floor1Content.setImage(_floor1Manager.playWin())
            }
            else
            {
                //次のヒーロー登場演出
                Floor1Content.setImage(_floor1Manager.summonNextHero())
                _floor1Manager.heroes.append(Warrior())
            }
        }
        else if (_floor1Manager.monsters[0].hp <= 0)
        {
            //モンスターが負けた場合の処理
            //負け演出
            if (_floor1Manager.loseEffect.progress < 8)
            {
                Floor1Content.setImage(_floor1Manager.playLose())
            }
            else
            {
                //次のフロアまで歩く
                Floor1Content.setImage(_floor1Manager.enterFloor())
            }
        }
        else
        {
            println("super exception")
        }
        manageHp()
    }
    
    //処理が軽いのでHPバーを監視して常に更新する
    private func manageHp()
    {
        var monsterRightHp:Int = Int(Float(_floor1Manager.monsters[0].hp) / Float(_floor1Manager.monsters[0].maxHp) * 30.0)
        
        var heroesLeftHp:Int = Int(Float(_floor1Manager.heroes[0].hp) / Float(_floor1Manager.heroes[0].maxHp) * 30.0)
        
        var heroesRightHp:Int = 0
        
        if (_floor1Manager.heroes.count >= 2)
        {
            heroesRightHp = Int(Float(_floor1Manager.heroes[1].hp) / Float(_floor1Manager.heroes[0].maxHp) * 30.0)
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