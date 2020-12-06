//
//  VendorViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class VendorViewModel {

    let id: Int
    let name: String

    init() {
        id = kInt0
        name = kBlankString
    }
    
    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }

}
