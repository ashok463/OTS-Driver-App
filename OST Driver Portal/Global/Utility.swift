//
//  Utility.swift
//  OTS Manager
//
//  Created by Ashok Kumar on 11/09/20.
//  Copyright © 2020 Ashok Kumar. All rights reserved.
//

import Foundation
import UIKit

class Utility{
    
    static func checkTextFieldIsEmpty(textfields: UITextField...) -> Bool{
        
        for textfield in textfields{
            if textfield.text?.isEmpty ?? false{
                AlertService().showAlert(title: "Alert", message: "Fill all textfields", actionButtonTitle: "OK") {
                }
                return false
            }
        }
        return true
    }
}


extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
