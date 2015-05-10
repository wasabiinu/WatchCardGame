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
    private var _floor2Manager:FloorManager!
    private var _floor3Manager:FloorManager!
    private var _floor4Manager:FloorManager!
    private var _btnBgImage:UIImage!
    @IBOutlet weak var FirstFloorRightBtn: WKInterfaceButton!
    @IBOutlet weak var FirstFloorLeftBtn: WKInterfaceButton!
    @IBOutlet weak var SecondFloorLeftBtn: WKInterfaceButton!
    @IBOutlet weak var SecondFloorRightBtn: WKInterfaceButton!
    @IBOutlet weak var ThirdFloorLeftBtn: WKInterfaceButton!
    @IBOutlet weak var ThirdFloorRightBtn: WKInterfaceButton!
    @IBOutlet weak var FourthFloorLeftBtn: WKInterfaceButton!
    @IBOutlet weak var FourthFloorRightBtn: WKInterfaceButton!
    
    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        _btnBgImage = UIImage(named: "btn_bg.png")!
        
        var floorManagerArray:[FloorManager] = context as! [FloorManager]
        
        //1F
        _floor1Manager = floorManagerArray[0]
        
        if (_floor1Manager.monsters.count >= 1 && _floor1Manager.monsters[0].hp > 0)
        {
            var firstFloorRightMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor1Manager.monsters[0].image, x: 5.0, y: 5.0)
            
            FirstFloorRightBtn.setBackgroundImage(firstFloorRightMonsterImage)
        }
        if (_floor1Manager.monsters.count >= 2 && _floor1Manager.monsters[1].hp > 0)
        {
            var firstFloorLeftMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor1Manager.monsters[1].image, x: 5.0, y: 5.0)
            
            FirstFloorLeftBtn.setBackgroundImage(firstFloorLeftMonsterImage)
        }
        
        //2F
        _floor2Manager = floorManagerArray[1]
        
        if (_floor2Manager.monsters.count >= 1 && _floor2Manager.monsters[0].hp > 0)
        {
            var secondFloorRightMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor2Manager.monsters[0].image, x: 5.0, y: 5.0)
            
            SecondFloorRightBtn.setBackgroundImage(secondFloorRightMonsterImage)
        }
        if (_floor2Manager.monsters.count >= 2 && _floor2Manager.monsters[1].hp > 0)
        {
            var secondFloorLeftMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor2Manager.monsters[1].image, x: 5.0, y: 5.0)
            
            SecondFloorLeftBtn.setBackgroundImage(secondFloorLeftMonsterImage)
        }
        
        //3F
        _floor3Manager = floorManagerArray[2]
        
        if (_floor3Manager.monsters.count >= 1 && _floor3Manager.monsters[0].hp > 0)
        {
            var thirdFloorRightMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor3Manager.monsters[0].image, x: 5.0, y: 5.0)
            ThirdFloorRightBtn.setBackgroundImage(thirdFloorRightMonsterImage)
        }
        if (_floor3Manager.monsters.count >= 2 && _floor3Manager.monsters[1].hp > 0)
        {
            var thirdFloorLeftMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor3Manager.monsters[1].image, x: 5.0, y: 5.0)
            
            ThirdFloorLeftBtn.setBackgroundImage(thirdFloorLeftMonsterImage)
        }
        
        //3F
        _floor4Manager = floorManagerArray[3]
        
        if (_floor4Manager.monsters.count >= 1 && _floor4Manager.monsters[0].hp > 0)
        {
            var fourthFloorRightMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor4Manager.monsters[0].image, x: 5.0, y: 5.0)
            FourthFloorRightBtn.setBackgroundImage(fourthFloorRightMonsterImage)
        }
        if (_floor4Manager.monsters.count >= 2 && _floor4Manager.monsters[1].hp > 0)
        {
            var fourthFloorLeftMonsterImage:UIImage = DrawUtil.synthesizeButtonImage(_btnBgImage, synthImage: _floor4Manager.monsters[1].image, x: 5.0, y: 5.0)
            
            FourthFloorLeftBtn.setBackgroundImage(fourthFloorLeftMonsterImage)
        }
    }
    
    @IBAction func onPush1FRightBtn() {
        if (_floor1Manager.monsters.count >= 1 && _floor1Manager.monsters[0].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush1FRightBtn")
        }
    }
    @IBAction func onPush1FLeftBtn() {
        if (_floor1Manager.monsters.count >= 2 && _floor1Manager.monsters[1].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush1FLeftBtn")
        }
    }
    @IBAction func onPush2FLeftBtn() {
        if (_floor2Manager.monsters.count >= 1 && _floor2Manager.monsters[0].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush2FRightBtn")
        }
    }
    @IBAction func onPush2FRightBtn() {
        if (_floor2Manager.monsters.count >= 2 && _floor2Manager.monsters[1].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush2FLeftBtn")
        }
    }
    @IBAction func onPush3FLeftBtn() {
        if (_floor3Manager.monsters.count >= 1 && _floor3Manager.monsters[0].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush3FRightBtn")
        }
    }
    @IBAction func onPush3FRightBtn() {
        if (_floor3Manager.monsters.count >= 2 && _floor3Manager.monsters[1].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush3FLeftBtn")
        }
    }
    @IBAction func onPush4FLeftBtn() {
        if (_floor4Manager.monsters.count >= 1 && _floor4Manager.monsters[0].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush4FRightBtn")
        }
    }
    @IBAction func onPush4FRightBtn() {
        if (_floor4Manager.monsters.count >= 2 && _floor4Manager.monsters[1].hp > 0)
        {
            self.presentControllerWithName("MonsterListController", context: "onPush4FLeftBtn")
        }
    }
    
    
    
    
    
    
    
}