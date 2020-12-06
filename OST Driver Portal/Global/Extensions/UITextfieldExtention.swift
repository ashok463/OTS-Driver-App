//
//  UITextfieldExtention.swift
//  OTS Manager
//
//  Created by Ashok Kumar on 10/08/20.
//  Copyright © 2020 Ashok Kumar. All rights reserved.
//

import Foundation
import UIKit


extension UITextField{
    
    func setLeftIcon(icon: String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: icon)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
    
    func setRightIcon(icon: String){
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25)) // set your Own size
        iconView.image = UIImage.init(named: icon)
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }
    
    func setUnderLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }

}
