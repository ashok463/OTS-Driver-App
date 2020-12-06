//
//  CheckVersionViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 27/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class CheckVersionViewModel{
    var id: String
    var androidV: String
    var iosV: String
    
    init(){
        self.id = ""
        self.androidV = ""
        self.iosV = ""
    }
    
    init(version: JSON) {
        self.id = version["id"].stringValue
        self.androidV = version["android_v"].stringValue
        self.iosV = version["ios_v"].stringValue
    }
    
}
