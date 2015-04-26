//
//  DrawUtil.swift
//  WatchCardGame
//
//  Created by 横山 優 on 2015/04/26.
//  Copyright (c) 2015年 Yu Yokoyama. All rights reserved.
//

import Foundation
import WatchKit

internal class DrawUtil {
    
    /**
    画像合成
    */
    internal class func synthesizeImage(originImage:UIImage, synthImage:UIImage, x:CGFloat, y:CGFloat) -> UIImage {
        
        //let startDate = NSDate()
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(Config.FLOOR_SIZE.width,Config.FLOOR_SIZE.height), false, 0.0);
        
        originImage.drawInRect(CGRectMake(0, 0, originImage.size.width, originImage.size.height))
        
        synthImage.drawInRect(CGRectMake(x, y, synthImage.size.width, synthImage.size.height))
        
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //let elapsed = NSDate().timeIntervalSinceDate(startDate)
        //println("synthesizeImage ended:\(elapsed)")
        return newImage
    }
    
    internal class func animatedUIImage(array:[UIImage]) -> UIImage
    {
        var duration: NSTimeInterval = NSTimeInterval(Config.MOVE_SEC)
        println("duration:\(duration)")
        var image:UIImage = UIImage.animatedImageWithImages(array, duration: duration)
        println(image.duration)
        return image
        
    }
    
    
    internal class func walkThrough(floorOrigin:WKInterfaceImage)
    {
        var floorImage:UIImage = UIImage(named: "floor_origin.png")!
        var alphaImage:UIImage = UIImage(named: "floor_origin.png")!
        
        var imageArray:[UIImage] = [UIImage]()
        
        
        
        var warrior0:UIImage = UIImage(named: "warrior0.png")!
        var warrior1:UIImage = UIImage(named: "warrior1.png")!
        var warrior2:UIImage = UIImage(named: "warrior2.png")!
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 170, y: 20)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 165, y: 18)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 160, y: 16)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: 155, y: 14)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 150, y: 12)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 145, y: 10)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 140, y: 8)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: 135, y: 6)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 130, y: 4)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 125, y: 2)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 120, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: 115, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 110, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 105, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 100, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: 95, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 90, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 85, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 80, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: 75, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 70, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 65, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 60, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: 55, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 50, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 45, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 40, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: 35, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 30, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 25, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 20, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: 15, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 10, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: 5, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: 0, y: 0)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: -5, y: CGFloat(-2))
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: -10, y: -4)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: -15, y: -6)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: -20, y: -8)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: -25, y: -10)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: -30, y: -12)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: -35, y: -14)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: -40, y: -16)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior1, x: -45, y: -18)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: -60, y: -20)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior2, x: -65, y: -22)
        imageArray.append(floorImage)
        
        floorImage = DrawUtil.synthesizeImage(alphaImage, synthImage: warrior0, x: -70, y: -24)
        
        
        var animationImage:UIImage = DrawUtil.animatedUIImage(imageArray)
        floorOrigin.setImage(animationImage)
        var range:NSRange = NSMakeRange(0, 48)
        floorOrigin.startAnimatingWithImagesInRange(range, duration: NSTimeInterval(Config.MOVE_SEC), repeatCount: 0)
    }
}