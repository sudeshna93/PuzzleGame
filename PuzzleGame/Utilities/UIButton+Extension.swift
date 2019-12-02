//
//  UIButton+Extension.swift
//  PuzzleGame
//
//  Created by Consultant on 11/17/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import UIKit

class ButtonExtension: UIButton{
    
    var borderWidth : CGFloat = 3.0
    var bordercolor = UIColor.black.cgColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = bordercolor
        
    }
    
}









