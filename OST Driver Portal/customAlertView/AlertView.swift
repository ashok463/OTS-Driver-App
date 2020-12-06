//
//  AlertView.swift
//  CustomAlertViewDemo
//
//  Created by Shashank Panwar on 06/07/19.
//  Copyright © 2019 Shashank Panwar. All rights reserved.
//

import UIKit

@IBDesignable
class AlertView: UIView {

    @IBInspectable var cornerRadiusAlertView : CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadiusAlertView
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColorAlertView : UIColor = .white{
        didSet{
            layer.borderColor = borderColorAlertView.cgColor
        }
    }
    
    @IBInspectable var borderWidthAlertView : CGFloat = 0.0{
        didSet{
            layer.borderWidth = borderWidthAlertView
        }
    }
    
}
