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
    internal class func synthesizeImage(originImage:UIImage, synthImage:UIImage, x:CGFloat, y:CGFloat) -> UIImage
    {
        
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
    
    internal class func synthesizeButtonImage(originImage:UIImage, synthImage:UIImage, x:CGFloat, y:CGFloat) -> UIImage
    {
        
        //let startDate = NSDate()
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(Config.BUTTON_SIZE.width,Config.BUTTON_SIZE.height), false, 0.0);
        
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
    
    internal class func compressUIImage(origin:UIImage) -> UIImage
    {
        var renderedImage = UIImageJPEGRepresentation(origin,0.5);
        var uiImage:UIImage = UIImage(data: renderedImage)!
        return uiImage
    }
    
    internal class func reverseImage(origin:UIImage) -> UIImage
    {
        var image:UIImage = UIImage(CGImage: origin.CGImage, scale: 2.0, orientation: UIImageOrientation.RightMirrored)!
        
        /*
        var imgRef:CGImageRef = origin.CGImage
        UIGraphicsBeginImageContext(origin.size)
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM( context, origin.size.width, origin.size.height)
        CGContextScaleCTM( context, -1.0, 1.0)
        CGContextDrawImage( context, CGRectMake( 0, 0, origin.size.width, origin.size.height), imgRef)
        var retImg:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return retImg*/
        
        return image
    }
    
    internal class func draw1frame()
    {
        
    }
}