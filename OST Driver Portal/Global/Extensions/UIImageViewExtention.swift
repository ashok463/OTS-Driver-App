//
//  UIImageViewExtention.swift
//  OTS Manager
//
//  Created by Ashok Kumar on 21/08/20.
//  Copyright © 2020 Ashok Kumar. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView{
    
     func cornerRadiusImageView(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func cornerRadiusWithBoarderImageView(radius: CGFloat, color: UIColor, width: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.clipsToBounds = true
    }
}
