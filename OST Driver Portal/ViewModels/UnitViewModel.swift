//
//  UnitViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class UnitViewModel {

    let id: Int
    let type: String
    let number: String

    init(_ json: JSON) {
        id = json["id"].intValue
        type = json["type"].stringValue
        number = json["number"].stringValue
    }

}
