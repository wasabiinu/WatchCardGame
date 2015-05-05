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
    
    @IBOutlet weak var Floor1Content: WKInterfaceImage!
    @IBOutlet weak var MonsterRightHpBar: WKInterfaceImage!
    @IBOutlet weak var HeroLeftHpBar: WKInterfaceImage!
    
    
    private var _turnTimer:NSTimer!
    private var _floor1Manager:FloorManager
    override init()
    {
        var hero:Hero = Warrior()
        var monster:Monster = Slime()
        _floor1Manager = FloorManager()
        _floor1Manager.heroes.append(hero)
        _floor1Manager.monsters.append(monster)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        _turnTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.25), target: self, selector: Selector("onTimer:"), userInfo: nil, repeats: true)
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        _turnTimer.invalidate()
        _turnTimer = nil
    }
    
    internal func onTimer(timer:NSTimer)
    {
        
        println("onTimer: \(_floor1Manager.heroes[0].xPosition)")
        
        if (_floor1Manager.heroes[0].xPosition > 71 && _floor1Manager.isBattle == false)
        {
            Floor1Content.setImage(_floor1Manager.enterFloor())
            println("enterFloor")
        }
        else if (_floor1Manager.battleStartProgress < 8)
        {
            Floor1Content.setImage(_floor1Manager.battleStart())
            println("battleStart")
        }
        else if (!((_floor1Manager.heroes[0].hp == 0 && _floor1Manager.monsters[0].attackProgress == 0) ||
            (_floor1Manager.monsters[0].hp == 0 && _floor1Manager.heroes[0].attackProgress == 0)))
        {
            Floor1Content.setImage(_floor1Manager.play1Turn())
            println("play1Turn")
        }
        //ヒーローのHPが0かつ、進捗が0の場合　または、モンスターのHPが0かつ、進捗が0の場合　下に抜ける
        
        else if (_floor1Manager.heroes[0].hp <= 0)
        {
            println("playWin")
            //ヒーローが負けた場合の処理
            if (_floor1Manager.winEffect.progress < 8)
            {
                //勝利演出
                println("Chased out!:progress\(_floor1Manager.winEffect.progress)")
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
            println("playLose")
            if (_floor1Manager.loseEffect.progress < 8)
            {
                println("Invaded next floor...")
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
            println("超例外")
        }
        manageHp()
    }
    
    //処理が軽いのでHPバーを監視して常に更新する
    private func manageHp()
    {
        var monsterRightHp:Int = Int(Float(_floor1Manager.monsters[0].hp) / Float(_floor1Manager.monsters[0].maxHp) * 30.0)
        
        var heroesLeftHp:Int = Int(Float(_floor1Manager.heroes[0].hp) / Float(_floor1Manager.heroes[0].maxHp) * 30.0)
        
        if (monsterRightHp < 0)
        {
            monsterRightHp = 0
        }
        
        if (heroesLeftHp < 0)
        {
            heroesLeftHp = 0
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
        //println("hp\(heroesLeftHp).png")
    }
}