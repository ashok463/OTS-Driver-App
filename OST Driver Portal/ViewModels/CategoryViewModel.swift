//
//  CategoryViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class CategoryViewModel {

    let name: String

    init(name:String) {
        self.name = name
    }
    
    init(_ json: JSON) {
        name = json["name"].stringValue
    }

}
