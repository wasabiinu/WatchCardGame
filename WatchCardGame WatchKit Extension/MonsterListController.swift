//
//  MonsterListController.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/05.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit

class MonsterListController: WKInterfaceController {

    @IBOutlet weak var MonsterList1: WKInterfaceButton!
    @IBOutlet weak var MonsterList2: WKInterfaceButton!
    
    private var monsterNo:Int = 0
    private var floorNo:Int = 0
    
    override func awakeWithContext(context: AnyObject?) {
        var contextString:String = context as! String
        
        switch contextString
        {
        case "onPush1FRightBtn" :
            monsterNo = 0
            floorNo = 0
            break
        case "onPush1FLeftBtn" :
            monsterNo = 1
            floorNo = 0
            break
        case "onPush2FRightBtn" :
            monsterNo = 0
            floorNo = 1
            break
        case "onPush2FLeftBtn" :
            monsterNo = 1
            floorNo = 1
            break
        case "onPush3FRightBtn" :
            monsterNo = 0
            floorNo = 2
            break
        case "onPush3FLeftBtn" :
            monsterNo = 1
            floorNo = 2
            break
        case "onPush4FRightBtn" :
            monsterNo = 0
            floorNo = 3
            break
        case "onPush4FLeftBtn" :
            monsterNo = 1
            floorNo = 3
            break
        default :
            monsterNo = 0
            floorNo = 0
            break
        }
        
        
        var bgImage:UIImage = UIImage(named: "list_bg.png")!
        
        var slime:Monster = Slime()
        
        var slimeImage:UIImage = DrawUtil.synthesizeImage(bgImage, synthImage: slime.iconImage, x: 10.0, y: -8.0)
        slimeImage = DrawUtil.synthesizeImage(slimeImage, synthImage: UIImage(named: "\(slime.elementType).png")!, x: 30.0, y: 10.0)
        MonsterList1.setBackgroundImage(slimeImage)
        
        var bat:Monster = Bat()
        
        var batImage:UIImage = DrawUtil.synthesizeImage(bgImage, synthImage: bat.iconImage, x: 10.0, y: -3.0)
        batImage = DrawUtil.synthesizeImage(batImage, synthImage: UIImage(named: "\(bat.elementType).png")!, x: 30.0, y: 10.0)
        
        MonsterList2.setBackgroundImage(batImage)
        
    }
    
    @IBAction func onTouchMonsterList1() {
        Config.floorManagers[floorNo].monsters[monsterNo] = Slime()
        openMainScene()
    }
    @IBAction func onTouchMonsterList2() {
        Config.floorManagers[floorNo].monsters[monsterNo] = Bat()
        openMainScene()
    }
    
    @IBAction func onTouchResetBtn() {
        self.presentControllerWithName("Top", context: "hoge")
    }
    private func openMainScene()
    {
        if (monsterNo == 1)
        {
            Config.floorManagers[0].monsters[monsterNo].xPosition -= 20
        }
        var array:NSArray = ["GameMainSceneController", "MonsterSelectController"]
        var contextArray:NSArray = [Config.floorManagers, Config.floorManagers]
        self.presentControllerWithNames(array as [AnyObject], contexts: contextArray as [AnyObject])
    }
}