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
    
    override func awakeWithContext(context: AnyObject?) {
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
        Config.floorManagers[0].monsters[0] = Slime()
        openMainScene()
    }
    @IBAction func onTouchMonsterList2() {
        Config.floorManagers[0].monsters[0] = Bat()
        openMainScene()
    }
    
    private func openMainScene()
    {
        var array:NSArray = ["GameMainSceneController", "MonsterSelectController"]
        var contextArray:NSArray = [Config.floorManagers, Config.floorManagers]
        self.presentControllerWithNames(array as [AnyObject], contexts: contextArray as [AnyObject])
    }
}