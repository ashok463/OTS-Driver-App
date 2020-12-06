//
//  UITableViewExtention.swift
//  OTS Manager
//
//  Created by Ashok Kumar on 11/09/20.
//  Copyright © 2020 Ashok Kumar. All rights reserved.
//

import Foundation
import UIKit


extension UITableView {
    func setEmptyMessage(message: String?) {
        let messageLbl = UILabel.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLbl.text = message
        messageLbl.textColor = .black
        messageLbl.numberOfLines = 0
        messageLbl.font = UIFont.init(name: "", size: 16)
        messageLbl.textAlignment = .center
        messageLbl.sizeToFit()
        
        self.backgroundView = messageLbl
        self.separatorStyle = .none
    }
    
    func restoreMessageLable(){
        self.backgroundView = nil
    }
}
