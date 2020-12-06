//
//  UIButtonExtention.swift
//  OTS Manager
//
//  Created by Ashok Kumar on 27/08/20.
//  Copyright © 2020 Ashok Kumar. All rights reserved.
//

import Foundation
import UIKit


extension UIButton{
    
     func cornerRadiusBtn(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func cornerRadiusWithBoarderBtn(radius: CGFloat, color: UIColor, width: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.clipsToBounds = true
    }
    
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor,tittleColor: UIColor, for state: UIControl.State) {
        self.backgroundColor = .clear
        self.setBackgroundImage(image(withColor: color), for: state)
        //self.applyShadowWithCornerRadius(color: .lightGray, opacity: 1.0, cornerRadius: self.frame.height/2, radius: 2.0, edge: .All, shadowSpace: 20)
        self.setTitleColor(tittleColor, for: state)
    }
}
