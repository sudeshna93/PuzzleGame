//
//  UIImage+Extension.swift
//  PuzzleGame
//
//  Created by Consultant on 11/18/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage {
    
   /* func cropping()
     At first making a image a perfect square. Then Dividing a image into 9 square.
     And returning a Araay of that 9 images.
    */
    func divideImage() -> [UIImage]{
        
        let sizeOfImage = self.size
        var images = [UIImage]()
        
        //make a image a square
        var width = min(sizeOfImage.width, sizeOfImage.height)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width), false, 0)
        
        //
        self.draw(at: CGPoint(x: -(self.size.width - width) / 2.0, y: -(self
            .size.height - width) / 2.0))
        
        let squareImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        //draw the divided square from that image
        width = width / 3.0
        for i in 0..<3{
            for j in 0..<3{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width), false, 0)
                let point = CGPoint(x: -(Int(width) * j), y: -(Int(width) * i))
                
                squareImage.draw(at: point)
                let square = UIGraphicsGetImageFromCurrentImageContext()
                
                images.append(square!)
                UIGraphicsEndImageContext()
            }
        }
        return images
    }
    /* func cropping()
     At first making a image a perfect square. Then Dividing a image into 16 square.
     And returning a Araay of that 16 images.
    */
    func divideImage15() -> [UIImage]{
        
        let sizeOfImage = self.size
        var images = [UIImage]()
        
        //make a image a square
        var width = min(sizeOfImage.width, sizeOfImage.height)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width), false, 0)
        
        //
        self.draw(at: CGPoint(x: -(self.size.width - width) / 2.0, y: -(self
            .size.height - width) / 2.0))
        
        let squareImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        //draw the divided square from that image
        width = width / 4.0
        for i in 0..<4{
            for j in 0..<4{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width), false, 0)
                let point = CGPoint(x: -(Int(width) * j), y: -(Int(width) * i))
                
                squareImage.draw(at: point)
                let square = UIGraphicsGetImageFromCurrentImageContext()
                
                images.append(square!)
                UIGraphicsEndImageContext()
            }
        }
        return images
    }
    
}
