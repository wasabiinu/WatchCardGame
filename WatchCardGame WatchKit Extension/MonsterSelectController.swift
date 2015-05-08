//
//  MonsterSelectController.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/05/05.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit

class MonsterSelectController: WKInterfaceController {

    private var _floor1Manager:FloorManager!
    private var _btnBgImage:UIImage!
    @IBOutlet weak var FirstFloorRightBtn: WKInterfaceButton!
    @IBOutlet weak var FirstFloorLeftBtn: WKInterfaceButton!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        _btnBgImage = UIImage(named: "btn_bg.png")!
        
        var floorManagerArray:[FloorManager] = context as! [FloorManager]
        _floor1Manager = floorManagerArray[0]
        
        var firstFloorRightMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor1Manager.monsters[0].image, x: 5.0, y: 5.0)
        
        FirstFloorRightBtn.setBackgroundImage(firstFloorRightMonsterImage)
        
        if (_floor1Manager.monsters.count >= 2 && _floor1Manager.monsters[1].hp > 0)
        {
            var firstFloorLeftMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor1Manager.monsters[1].image, x: 5.0, y: 5.0)
            
            FirstFloorLeftBtn.setBackgroundImage(firstFloorLeftMonsterImage)
        }
    }
    
    @IBAction func onPush1FRightBtn() {
        println("onPush1FRightBtn")
        self.presentControllerWithName("MonsterListController", context: "onPush1FRightBtn")
    }
    @IBAction func onPush1FLeftBtn() {
        if (_floor1Manager.monsters.count >= 2 && _floor1Manager.monsters[1].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush1FLeftBtn")
        }
    }
}